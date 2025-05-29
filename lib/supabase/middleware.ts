import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";
import { Database } from "../database.types";

const publicOnlyRoutes = ["/login"];
const protectedRoutes = ["/settings", "/analytics"];

export async function updateSession(request: NextRequest) {
  const NEXT_PUBLIC_SUPABASE_ANON_KEY: string =
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "";
  const NEXT_PUBLIC_SUPABASE_URL: string =
    process.env.NEXT_PUBLIC_SUPABASE_URL || "";

  if (!NEXT_PUBLIC_SUPABASE_ANON_KEY || !NEXT_PUBLIC_SUPABASE_URL) {
    throw new Error("Missing Supabase Environment Variables");
  }

  let supabaseResponse = NextResponse.next({
    request,
  });

  const supabase = createServerClient<Database>(
    NEXT_PUBLIC_SUPABASE_URL,
    NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          // eslint-disable-next-line no-unused-vars, @typescript-eslint/no-unused-vars
          cookiesToSet.forEach(({ name, value, options }) =>
            request.cookies.set(name, value)
          );
          supabaseResponse = NextResponse.next({
            request,
          });
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          );
        },
      },
    }
  );
  // IMPORTANT: Avoid writing any logic between createServerClient and
  // supabase.auth.getUser(). A simple mistake could make it very hard to debug
  // issues with users being randomly logged out.
  const { data } = await supabase.auth.getUser();

  const pathname = request.nextUrl.pathname;
  const isPublicOnly = publicOnlyRoutes.some((r) => pathname.startsWith(r));
  const isProtected =
    pathname === "/" || protectedRoutes.some((r) => pathname.startsWith(r));

  if (!data.user && isProtected) {
    // no user, potentially respond by redirecting the user to the login page
    return NextResponse.redirect(new URL("/login", request.url));
  }
  if (data.user && isPublicOnly) {
    // redirect logged in users away from the login page
    return NextResponse.redirect(new URL("/", request.url));
  }

  // IMPORTANT: You *must* return the supabaseResponse object as it is. If you're
  // creating a new response object with NextResponse.next() make sure to:
  // 1. Pass the request in it, like so:
  //    const myNewResponse = NextResponse.next({ request })
  // 2. Copy over the cookies, like so:
  //    myNewResponse.cookies.setAll(supabaseResponse.cookies.getAll())
  // 3. Change the myNewResponse object to fit your needs, but avoid changing
  //    the cookies!
  // 4. Finally:
  //    return myNewResponse
  // If this is not done, you may be causing the browser and server to go out
  // of sync and terminate the user's session prematurely!
  return supabaseResponse;
}

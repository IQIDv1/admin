import { createServerClient } from "@supabase/ssr";
import { createClient as createSupabaseClient } from "@supabase/supabase-js";
import { cookies } from "next/headers";
import { Database } from "../database.types";

export async function createClient() {
  const NEXT_PUBLIC_SUPABASE_ANON_KEY: string =
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "";
  const NEXT_PUBLIC_SUPABASE_URL: string =
    process.env.NEXT_PUBLIC_SUPABASE_URL || "";

  if (!NEXT_PUBLIC_SUPABASE_ANON_KEY || !NEXT_PUBLIC_SUPABASE_URL) {
    throw new Error("Missing Supabase Environment Variables");
  }

  const cookieStore = cookies();

  return createServerClient<Database>(
    NEXT_PUBLIC_SUPABASE_URL,
    NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll();
        },
        setAll(cookiesToSet) {
          try {
            cookiesToSet.forEach(({ name, value, options }) =>
              cookieStore.set(name, value, options)
            );
          } catch {
            // The `setAll` method was called from a Server Component.
            // This can be ignored if you have middleware refreshing
            // user sessions.
          }
        },
      },
    }
  );
}

export async function createServiceRoleClient() {
  const NEXT_PUBLIC_SUPABASE_URL: string =
    process.env.NEXT_PUBLIC_SUPABASE_URL || "";

  const SUPABASE_SERVICE_ROLE_KEY: string =
    process.env.SUPABASE_SERVICE_ROLE_KEY || "";

  if (!NEXT_PUBLIC_SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error("Missing Supabase Environment Variables");
  }

  return createSupabaseClient<Database>(
    NEXT_PUBLIC_SUPABASE_URL,
    SUPABASE_SERVICE_ROLE_KEY,
    {
      auth: {
        persistSession: false,
      },
    }
  );
}

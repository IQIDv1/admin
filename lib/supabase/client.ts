import { createBrowserClient } from "@supabase/ssr";
import {
  NEXT_PUBLIC_SUPABASE_ANON_KEY,
  NEXT_PUBLIC_SUPABASE_URL,
} from "../constants";
// import { Database } from "../database.types";

export function createClient() {
  //   return createBrowserClient<Database>(
  return createBrowserClient(
    NEXT_PUBLIC_SUPABASE_URL,
    NEXT_PUBLIC_SUPABASE_ANON_KEY
  );
}

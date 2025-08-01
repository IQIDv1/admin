import { createBrowserClient } from '@supabase/ssr';
import { Database } from '../database.types';

export function createClient() {
  const NEXT_PUBLIC_SUPABASE_ANON_KEY: string = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '';
  const NEXT_PUBLIC_SUPABASE_URL: string = process.env.NEXT_PUBLIC_SUPABASE_URL || '';

  if (!NEXT_PUBLIC_SUPABASE_ANON_KEY || !NEXT_PUBLIC_SUPABASE_URL) {
    throw new Error('Missing Supabase Environment Variables');
  }
  return createBrowserClient<Database>(NEXT_PUBLIC_SUPABASE_URL, NEXT_PUBLIC_SUPABASE_ANON_KEY);
}

import type { Metadata } from "next";
import InteractionsList from "@/components/interactions-list";
import { APP_NAME } from "@/lib/constants";
import { createClient } from "@/lib/supabase/server";
import { DATABASE_TABLES } from "@/lib/constants";

export const metadata: Metadata = {
  title: `Interactions | ${APP_NAME}`,
  description: "Monitor and manage your email agent's performance",
};

export default async function InteractionsPage() {
  const supabase = await createClient();
  const { data, error } = await supabase.auth.getUser();

  if (error || !data?.user) {
    // Optionally handle unauthorized state, or return null/redirect
    return null;
  }

  const { data: memberData, error: memberError } = await supabase
    .from(DATABASE_TABLES.MEMBERS)
    .select("*")
    .eq("id", data.user.id)
    .single();

  if (memberError || !memberData) {
    // Optionally handle missing member, or return null/redirect
    return null;
  }

  return <InteractionsList currentUser={memberData} />;
}

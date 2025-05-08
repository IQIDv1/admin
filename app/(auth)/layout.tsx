import DashboardShell from "@/components/dashboard-shell";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { DATABASE_TABLES } from "@/lib/constants";
import { ReactNode } from "react";

export default async function AuthenticatedLayout({
  children,
}: {
  children: ReactNode;
}) {
  const supabase = await createClient();
  const { data, error } = await supabase.auth.getUser();

  if (error || !data?.user) {
    redirect("/login?error=unauthorized");
  }

  const { data: memberData, error: memberError } = await supabase
    .from(DATABASE_TABLES.MEMBERS)
    .select("*")
    .eq("id", data.user.id)
    .single();

  if (memberError || !memberData) {
    try {
      await supabase.auth.signOut();
    } catch (error) {}
    redirect("/login?error=unauthorized");
  }

  return <DashboardShell member={memberData}>{children}</DashboardShell>;
}

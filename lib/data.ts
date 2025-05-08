import { redirect } from "next/navigation";
import { createClient, createServiceRoleClient } from "@/lib/supabase/server";
import { DATABASE_TABLES } from "@/lib/constants";
import { Member } from "./types";

export async function fetchMemberData(): Promise<Member | void> {
  const supabaseClient = await createClient();
  const supabaseServiceRoleClient = await createServiceRoleClient();
  try {
    const { data, error } = await supabaseClient.auth.getUser();

    if (error || !data?.user) {
      throw new Error();
    }

    const { data: memberData, error: memberError } =
      await supabaseServiceRoleClient
        .from(DATABASE_TABLES.MEMBERS)
        .select("*")
        .eq("id", data.user.id)
        .single();

    if (memberError || !memberData) {
      try {
        await supabaseClient.auth.signOut();
      } catch (error) {}
      throw new Error();
    }

    return memberData;
  } catch (error) {
    redirect("/login?error=unauthorized");
  }
}

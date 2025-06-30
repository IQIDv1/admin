import type { SupabaseClient } from "@supabase/supabase-js";
import type {
  OrganizationInboundMessage,
  OrganizationInboundMessagesStudent,
  Student,
  StudentAcademic,
  StudentCurrentAid,
  StudentFinancialAid,
  StudentInteractionsSummary,
  StudentLoan,
  StudentEabMatch,
} from "@/lib/types";

interface Filters {
  startDate?: string;
  endDate?: string;
  subject?: string;
  // status?: "pending" | "skipped" | "completed"; // Not used for now
}

/**
 * Fetches student details and associated records by student ID.
 */
export type StudentDetails = {
  student: Student;
  academic: StudentAcademic | null;
  currentAid: StudentCurrentAid | null;
  eabMatch: StudentEabMatch | null;
  financialAid: StudentFinancialAid | null;
  interactionsSummary: StudentInteractionsSummary | null;
  loans: StudentLoan[];
};

export async function getStudentDetails(
  supabase: SupabaseClient,
  studentId: string
): Promise<StudentDetails | null> {
  const { data, error } = await supabase
    .from("students")
    .select(
      `*,
      student_academic(*),
      student_current_aid(*),
      student_eab_match(*),
      student_financial_aid(*),
      student_interactions_summary(*),
      student_loans(*)`
    )
    .eq("id", studentId)
    .maybeSingle();
  if (error) {
    throw error;
  }
  if (!data) {
    return null;
  }
  return {
    student: data,
    academic: data.student_academic?.[0] ?? null,
    currentAid: data.student_current_aid?.[0] ?? null,
    eabMatch: data.student_eab_match?.[0] ?? null,
    financialAid: data.student_financial_aid?.[0] ?? null,
    interactionsSummary: data.student_interactions_summary?.[0] ?? null,
    loans: data.student_loans ?? [],
  };
}


/**
 * Fetches organization inbound messages with optional filters and joined students.
 */
export async function getOrganizationInboundMessages(
  supabase: SupabaseClient,
  organizationId: string,
  filters: Filters = {}
): Promise<
  (OrganizationInboundMessage & {
    students: (OrganizationInboundMessagesStudent & { student?: Student | null })[];
  })[]
> {
  let query = supabase
    .from("organization_inbound_messages")
    .select(`*, students:organization_inbound_messages_students(*, student:students(*))`)
    .eq("organization_id", organizationId)
    .order("received_at", { ascending: false });

  if (filters.startDate && filters.endDate) {
    query = query.gte("received_at", filters.startDate).lte("received_at", filters.endDate);
  }

  if (filters.subject) {
    query = query.ilike("subject", `%${filters.subject}%`);
  }

  const { data, error } = await query;
  if (error) throw error;
  return data as (
    OrganizationInboundMessage & {
      students: (OrganizationInboundMessagesStudent & { student?: Student | null })[];
    }
  )[];
}

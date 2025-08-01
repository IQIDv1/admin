import type { SupabaseClient } from '@supabase/supabase-js';
import type {
  OrganizationInboundMessage,
  OrganizationInboundMessagesStudent,
  OrganizationOutboundMessage,
  OrganizationOutboundMessageVersion,
  Student,
  StudentAcademic,
  StudentCurrentAid,
  StudentFinancialAid,
  StudentInteractionsSummary,
  StudentLoan,
  StudentEabMatch
} from '@/lib/types';

export type OutboundMessageVersionSummary = Pick<
  OrganizationOutboundMessageVersion,
  'id' | 'version' | 'subject' | 'body' | 'liked' | 'created_at' | 'updated_at'
>;

interface Filters {
  startDate?: string;
  endDate?: string;
  subject?: string;
  // status?: "pending" | "skipped" | "completed"; // Not used for now
}

/**
 * Creates or updates an outbound message version for a given inbound message.
 * If no outbound exists, creates a new organization_outbound_message and initial version.
 * Otherwise creates a new version incremented from the latest.
 */
export async function saveOutboundResponse(
  supabase: SupabaseClient,
  inboundMessageId: string,
  subject: string,
  body: string
): Promise<{ outboundMessageId: string; version: OutboundMessageVersionSummary }> {
  // Find existing outbound message
  const { data: found, error: findError } = await supabase
    .from('organization_outbound_messages')
    .select('id')
    .eq('inbound_message_id', inboundMessageId)
    .maybeSingle();
  if (findError) {
    throw findError;
  }
  let outboundId: string;
  let nextVersion = 1;
  if (!found) {
    // Create initial outbound
    const { data: outData, error: outError } = await supabase
      .from('organization_outbound_messages')
      .insert({ inbound_message_id: inboundMessageId })
      .select('id')
      .single();
    if (outError) {
      throw outError;
    }
    outboundId = outData.id;
  } else {
    outboundId = found.id;
    // Determine next version number
    const { data: maxData, error: maxError } = await supabase
      .from('organization_outbound_message_versions')
      .select('version')
      .eq('outbound_message_id', outboundId)
      .order('version', { ascending: false })
      .limit(1)
      .maybeSingle();
    if (maxError) {
      throw maxError;
    }
    nextVersion = (maxData?.version || 0) + 1;
  }
  // Insert new version
  const { data: verData, error: verError } = await supabase
    .from('organization_outbound_message_versions')
    .insert({
      outbound_message_id: outboundId,
      version: nextVersion,
      subject,
      body
    })
    .select('id, version, subject, body, liked, created_at, updated_at')
    .single();
  if (verError) {
    throw verError;
  }
  return { outboundMessageId: outboundId, version: verData };
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
    .from('students')
    .select(
      `*,
      student_academic(*),
      student_current_aid(*),
      student_eab_match(*),
      student_financial_aid(*),
      student_interactions_summary(*),
      student_loans(*)`
    )
    .eq('id', studentId)
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
    loans: data.student_loans ?? []
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
    inbound_activities: { action: string; action_data: unknown; created_at: string }[];
    organization_outbound_message?:
      | (OrganizationOutboundMessage & {
          latest_version?: OutboundMessageVersionSummary | null;
          outbound_activities: { action: string; action_data: unknown; created_at: string }[];
        })
      | null;
  })[]
> {
  let query = supabase
    .from('organization_inbound_messages')
    .select(
      `*,
      students:organization_inbound_messages_students(*, student:students(*)),
      inbound_activities:organization_inbound_messages_activity(action, action_data, created_at),
      organization_outbound_message:organization_outbound_messages(*,
        outbound_activities:organization_outbound_messages_activity(action, action_data, created_at),
        versions:organization_outbound_message_versions(id, version, subject, body, liked, created_at, updated_at)
      )
    `
    )
    .eq('organization_id', organizationId)
    .order('received_at', { ascending: false });

  if (filters.startDate && filters.endDate) {
    query = query.gte('received_at', filters.startDate).lte('received_at', filters.endDate);
  }

  if (filters.subject) {
    query = query.ilike('subject', `%${filters.subject}%`);
  }

  const { data, error } = await query;
  if (error) {
    throw error;
  }

  const fixed = data.map((msg) => {
    let outbound = msg.organization_outbound_message?.[0] ?? null;
    if (outbound) {
      const versions: OutboundMessageVersionSummary[] = outbound.versions || [];
      let latest_version: OutboundMessageVersionSummary | null = null;
      if (versions.length > 0) {
        const maxVersion = versions.reduce(
          (prev: OutboundMessageVersionSummary, curr: OutboundMessageVersionSummary) =>
            prev.version > curr.version ? prev : curr
        );
        latest_version = { ...maxVersion };
      }
      outbound = { ...outbound, latest_version };
      delete outbound.versions;
    }
    return { ...msg, organization_outbound_message: outbound };
  });

  return fixed;
}

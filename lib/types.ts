import type { Database } from "./database.types";

export type InboundMessageEmbedding = Database["public"]["Tables"]["inbound_message_embeddings"]["Row"];
export type Invite = Database["public"]["Tables"]["invites"]["Row"];
export type Member = Database["public"]["Tables"]["members"]["Row"];
export type Organization = Database["public"]["Tables"]["organizations"]["Row"];
export type OrganizationMailbox = Database["public"]["Tables"]["organization_mailboxes"]["Row"];
export type OrganizationInboundMessage = Database["public"]["Tables"]["organization_inbound_messages"]["Row"];
export type OrganizationInboundMessagesStudent = Database["public"]["Tables"]["organization_inbound_messages_students"]["Row"];
export type OrganizationOutboundMessage = Database["public"]["Tables"]["organization_outbound_messages"]["Row"];
export type OrganizationOutboundMessageVersion = Database["public"]["Tables"]["organization_outbound_message_versions"]["Row"];
export type Student = Database["public"]["Tables"]["students"]["Row"];
export type StudentAcademic = Database["public"]["Tables"]["student_academic"]["Row"];
export type StudentCurrentAid = Database["public"]["Tables"]["student_current_aid"]["Row"];
export type StudentFinancialAid = Database["public"]["Tables"]["student_financial_aid"]["Row"];
export type StudentInteractionsSummary = Database["public"]["Tables"]["student_interactions_summary"]["Row"];
export type StudentLoan = Database["public"]["Tables"]["student_loans"]["Row"];
export type StudentPayment = Database["public"]["Tables"]["student_payments"]["Row"];

export type THEMES = "dark" | "light";

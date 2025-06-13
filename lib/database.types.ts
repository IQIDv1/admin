export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      invites: {
        Row: {
          accepted: boolean
          created_at: string
          email: string
          expires_at: string
          id: string
          invited_by: string | null
          organization_id: string
          role: string
        }
        Insert: {
          accepted?: boolean
          created_at?: string
          email: string
          expires_at?: string
          id?: string
          invited_by?: string | null
          organization_id: string
          role: string
        }
        Update: {
          accepted?: boolean
          created_at?: string
          email?: string
          expires_at?: string
          id?: string
          invited_by?: string | null
          organization_id?: string
          role?: string
        }
        Relationships: [
          {
            foreignKeyName: "invites_invited_by_fkey"
            columns: ["invited_by"]
            isOneToOne: false
            referencedRelation: "members"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "invites_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      members: {
        Row: {
          active: boolean
          created_at: string
          display_name: string | null
          email: string
          first_name: string
          id: string
          last_name: string
          organization_id: string
          role: string
          settings: Json
          updated_at: string
        }
        Insert: {
          active?: boolean
          created_at?: string
          display_name?: string | null
          email: string
          first_name: string
          id: string
          last_name: string
          organization_id: string
          role: string
          settings?: Json
          updated_at?: string
        }
        Update: {
          active?: boolean
          created_at?: string
          display_name?: string | null
          email?: string
          first_name?: string
          id?: string
          last_name?: string
          organization_id?: string
          role?: string
          settings?: Json
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "members_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      organization_inbound_messages: {
        Row: {
          body: string | null
          created_at: string
          embedding: string | null
          id: string
          message_id: string | null
          organization_id: string
          provider: string
          received_at: string
          recipient_address: string
          sender_address: string
          subject: string | null
          thread_id: string | null
          updated_at: string
        }
        Insert: {
          body?: string | null
          created_at?: string
          embedding?: string | null
          id?: string
          message_id?: string | null
          organization_id: string
          provider: string
          received_at: string
          recipient_address: string
          sender_address: string
          subject?: string | null
          thread_id?: string | null
          updated_at?: string
        }
        Update: {
          body?: string | null
          created_at?: string
          embedding?: string | null
          id?: string
          message_id?: string | null
          organization_id?: string
          provider?: string
          received_at?: string
          recipient_address?: string
          sender_address?: string
          subject?: string | null
          thread_id?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "organization_inbound_messages_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      organization_inbound_messages_students: {
        Row: {
          created_at: string
          inbound_message_id: string
          student_id: string
        }
        Insert: {
          created_at?: string
          inbound_message_id: string
          student_id: string
        }
        Update: {
          created_at?: string
          inbound_message_id?: string
          student_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "organization_inbound_messages_students_inbound_message_id_fkey"
            columns: ["inbound_message_id"]
            isOneToOne: false
            referencedRelation: "organization_inbound_messages"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "organization_inbound_messages_students_student_id_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "students"
            referencedColumns: ["id"]
          },
        ]
      }
      organization_mailboxes: {
        Row: {
          connection_settings: Json
          created_at: string
          email_address: string
          id: string
          is_active: boolean
          last_synced_at: string | null
          organization_id: string
          provider: string
          updated_at: string
        }
        Insert: {
          connection_settings: Json
          created_at?: string
          email_address: string
          id?: string
          is_active?: boolean
          last_synced_at?: string | null
          organization_id: string
          provider: string
          updated_at?: string
        }
        Update: {
          connection_settings?: Json
          created_at?: string
          email_address?: string
          id?: string
          is_active?: boolean
          last_synced_at?: string | null
          organization_id?: string
          provider?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "organization_mailboxes_org_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      organization_outbound_message_versions: {
        Row: {
          body: string | null
          created_at: string
          embedding: string | null
          feedback: string | null
          id: string
          liked: boolean | null
          outbound_message_id: string
          subject: string | null
          updated_at: string
          version: number
        }
        Insert: {
          body?: string | null
          created_at?: string
          embedding?: string | null
          feedback?: string | null
          id?: string
          liked?: boolean | null
          outbound_message_id: string
          subject?: string | null
          updated_at?: string
          version: number
        }
        Update: {
          body?: string | null
          created_at?: string
          embedding?: string | null
          feedback?: string | null
          id?: string
          liked?: boolean | null
          outbound_message_id?: string
          subject?: string | null
          updated_at?: string
          version?: number
        }
        Relationships: [
          {
            foreignKeyName: "organization_outbound_message_versions_outbound_message_id_fkey"
            columns: ["outbound_message_id"]
            isOneToOne: false
            referencedRelation: "organization_outbound_messages"
            referencedColumns: ["id"]
          },
        ]
      }
      organization_outbound_messages: {
        Row: {
          created_at: string
          id: string
          inbound_message_id: string
          is_sent: boolean
          organization_id: string
          provider_message_id: string | null
          sent_at: string | null
          updated_at: string
        }
        Insert: {
          created_at?: string
          id?: string
          inbound_message_id: string
          is_sent?: boolean
          organization_id: string
          provider_message_id?: string | null
          sent_at?: string | null
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          inbound_message_id?: string
          is_sent?: boolean
          organization_id?: string
          provider_message_id?: string | null
          sent_at?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "organization_outbound_messages_inbound_message_id_fkey"
            columns: ["inbound_message_id"]
            isOneToOne: false
            referencedRelation: "organization_inbound_messages"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "organization_outbound_messages_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      organizations: {
        Row: {
          created_at: string
          domain: string
          id: string
          name: string
          settings: Json
          sso_provider_id: string
          sso_provider_name: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          domain: string
          id?: string
          name: string
          settings?: Json
          sso_provider_id: string
          sso_provider_name: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          domain?: string
          id?: string
          name?: string
          settings?: Json
          sso_provider_id?: string
          sso_provider_name?: string
          updated_at?: string
        }
        Relationships: []
      }
      student_academic: {
        Row: {
          academic_program: string | null
          academic_standing: string | null
          created_at: string
          enrollment_status: string | null
          gpa: number | null
          id: string
          sap_status: string | null
          student_id: string
          updated_at: string
        }
        Insert: {
          academic_program?: string | null
          academic_standing?: string | null
          created_at?: string
          enrollment_status?: string | null
          gpa?: number | null
          id?: string
          sap_status?: string | null
          student_id: string
          updated_at?: string
        }
        Update: {
          academic_program?: string | null
          academic_standing?: string | null
          created_at?: string
          enrollment_status?: string | null
          gpa?: number | null
          id?: string
          sap_status?: string | null
          student_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_academic_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "students"
            referencedColumns: ["id"]
          },
        ]
      }
      student_current_aid: {
        Row: {
          created_at: string
          federal_direct_subsidized: number | null
          federal_direct_unsubsidized: number | null
          federal_pell_grant: number | null
          id: string
          institutional_aid: number | null
          state_aid: number | null
          student_id: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          federal_direct_subsidized?: number | null
          federal_direct_unsubsidized?: number | null
          federal_pell_grant?: number | null
          id?: string
          institutional_aid?: number | null
          state_aid?: number | null
          student_id: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          federal_direct_subsidized?: number | null
          federal_direct_unsubsidized?: number | null
          federal_pell_grant?: number | null
          id?: string
          institutional_aid?: number | null
          state_aid?: number | null
          student_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_current_aid_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "students"
            referencedColumns: ["id"]
          },
        ]
      }
      student_financial_aid: {
        Row: {
          award_status: string | null
          cost_of_attendance: number | null
          created_at: string
          dependency_status: string | null
          fafsa_submission_date: string | null
          id: string
          outstanding_requirements: string | null
          remaining_aid_eligibility: number | null
          student_id: string
          updated_at: string
        }
        Insert: {
          award_status?: string | null
          cost_of_attendance?: number | null
          created_at?: string
          dependency_status?: string | null
          fafsa_submission_date?: string | null
          id?: string
          outstanding_requirements?: string | null
          remaining_aid_eligibility?: number | null
          student_id: string
          updated_at?: string
        }
        Update: {
          award_status?: string | null
          cost_of_attendance?: number | null
          created_at?: string
          dependency_status?: string | null
          fafsa_submission_date?: string | null
          id?: string
          outstanding_requirements?: string | null
          remaining_aid_eligibility?: number | null
          student_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_fin_aid_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "students"
            referencedColumns: ["id"]
          },
        ]
      }
      student_interactions_summary: {
        Row: {
          created_at: string
          id: string
          interaction_link: string | null
          student_id: string
          summary: string | null
          updated_at: string
        }
        Insert: {
          created_at?: string
          id?: string
          interaction_link?: string | null
          student_id: string
          summary?: string | null
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          interaction_link?: string | null
          student_id?: string
          summary?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_interactions_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "students"
            referencedColumns: ["id"]
          },
        ]
      }
      student_loans: {
        Row: {
          acceptance_status: string | null
          amount: number | null
          created_at: string
          id: string
          loan_type: string
          student_id: string
          updated_at: string
        }
        Insert: {
          acceptance_status?: string | null
          amount?: number | null
          created_at?: string
          id?: string
          loan_type: string
          student_id: string
          updated_at?: string
        }
        Update: {
          acceptance_status?: string | null
          amount?: number | null
          created_at?: string
          id?: string
          loan_type?: string
          student_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_loans_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "students"
            referencedColumns: ["id"]
          },
        ]
      }
      student_payments: {
        Row: {
          authorized_payer: string | null
          created_at: string
          id: string
          payer_email: string | null
          payment_declined_reason: string | null
          payment_plan_date: string | null
          payment_plan_status: string | null
          student_id: string
          updated_at: string
        }
        Insert: {
          authorized_payer?: string | null
          created_at?: string
          id?: string
          payer_email?: string | null
          payment_declined_reason?: string | null
          payment_plan_date?: string | null
          payment_plan_status?: string | null
          student_id: string
          updated_at?: string
        }
        Update: {
          authorized_payer?: string | null
          created_at?: string
          id?: string
          payer_email?: string | null
          payment_declined_reason?: string | null
          payment_plan_date?: string | null
          payment_plan_status?: string | null
          student_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_payments_fkey"
            columns: ["student_id"]
            isOneToOne: false
            referencedRelation: "students"
            referencedColumns: ["id"]
          },
        ]
      }
      students: {
        Row: {
          banner_student_id: string | null
          citizenship_status: string | null
          created_at: string
          email: string | null
          first_name: string
          id: string
          last_name: string
          organization_id: string
          phone: string | null
          student_type: string | null
          updated_at: string
        }
        Insert: {
          banner_student_id?: string | null
          citizenship_status?: string | null
          created_at?: string
          email?: string | null
          first_name: string
          id?: string
          last_name: string
          organization_id: string
          phone?: string | null
          student_type?: string | null
          updated_at?: string
        }
        Update: {
          banner_student_id?: string | null
          citizenship_status?: string | null
          created_at?: string
          email?: string | null
          first_name?: string
          id?: string
          last_name?: string
          organization_id?: string
          phone?: string | null
          student_type?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "students_org_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      studentstest: {
        Row: {
          created_at: string
          email_address: string
          first_name: string
          id: string
          last_name: string
          original_id: string
        }
        Insert: {
          created_at?: string
          email_address: string
          first_name: string
          id?: string
          last_name: string
          original_id: string
        }
        Update: {
          created_at?: string
          email_address?: string
          first_name?: string
          id?: string
          last_name?: string
          original_id?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      current_user_org_id: {
        Args: Record<PropertyKey, never>
        Returns: string
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DefaultSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const


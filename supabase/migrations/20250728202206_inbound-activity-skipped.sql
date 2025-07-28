-- ============================================
-- Migration: Add skipped_evaluation action to organization_inbound_messages_activity
-- ============================================

ALTER TABLE public.organization_inbound_messages_activity
  DROP CONSTRAINT organization_inbound_messages_activity_action_check;

ALTER TABLE public.organization_inbound_messages_activity
  ADD CONSTRAINT organization_inbound_messages_activity_action_check
    CHECK (
      action IN (
        'interpreted_request',
        'summarized_question',
        'suggested_next_actions',
        'suggested_next_questions',
        'skipped_evaluation'
      )
    );

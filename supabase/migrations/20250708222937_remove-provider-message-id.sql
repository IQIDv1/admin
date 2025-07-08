-- ============================================
-- Migration: Remove provider_message_id from organization_outbound_messages
-- ============================================

ALTER TABLE public.organization_outbound_messages
  DROP COLUMN IF EXISTS provider_message_id CASCADE;

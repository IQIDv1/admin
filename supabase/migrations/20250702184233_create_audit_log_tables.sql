-- ============================================
-- Migration: Create agent and user activity tables + RLS
-- ============================================

-- 1) Agent activity on inbound messages
CREATE TABLE public.organization_inbound_messages_activity (
  id                   uuid        NOT NULL DEFAULT gen_random_uuid(),
  inbound_message_id   uuid        NOT NULL,
  action               text        NOT NULL CHECK (action IN ('interpreted_request', 'summarized_question', 'suggested_next_actions', 'suggested_next_questions')),
  action_data          jsonb       NULL,
  created_at           timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT organization_inbound_messages_activity_pkey
    PRIMARY KEY (id),
  CONSTRAINT organization_inbound_messages_activity_inbound_message_id_fkey
    FOREIGN KEY (inbound_message_id)
    REFERENCES public.organization_inbound_messages(id)
    ON DELETE CASCADE
);

ALTER TABLE public.organization_inbound_messages_activity
  ENABLE ROW LEVEL SECURITY;

-- Agent activity policies
CREATE POLICY org_read_inbound_activity
  ON public.organization_inbound_messages_activity
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
        FROM public.organization_inbound_messages m
      WHERE m.id = inbound_message_id
        AND m.organization_id = (
          SELECT organization_id
            FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_insert_inbound_activity
  ON public.organization_inbound_messages_activity
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
        FROM public.organization_inbound_messages m
      WHERE m.id = inbound_message_id
        AND m.organization_id = (
          SELECT organization_id
            FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_update_inbound_activity
  ON public.organization_inbound_messages_activity
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
        FROM public.organization_inbound_messages m
      WHERE m.id = inbound_message_id
        AND m.organization_id = (
          SELECT organization_id
            FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_delete_inbound_activity
  ON public.organization_inbound_messages_activity
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1
        FROM public.organization_inbound_messages m
      WHERE m.id = inbound_message_id
        AND m.organization_id = (
          SELECT organization_id
            FROM public.members
          WHERE id = auth.uid()
        )
    )
  );


-- 2) User activity on outbound messages
CREATE TABLE public.organization_outbound_messages_activity (
  id                   uuid        NOT NULL DEFAULT gen_random_uuid(),
  outbound_message_id  uuid        NOT NULL,
  action               text        NOT NULL CHECK (action IN ('copied', 'edited', 'discarded')),
  action_data          jsonb       NOT NULL,
  created_at           timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT organization_outbound_messages_activity_pkey
    PRIMARY KEY (id),
  CONSTRAINT organization_outbound_messages_activity_obm_id_fkey
    FOREIGN KEY (outbound_message_id)
    REFERENCES public.organization_outbound_messages(id)
    ON DELETE CASCADE
);

ALTER TABLE public.organization_outbound_messages_activity
  ENABLE ROW LEVEL SECURITY;

-- User activity policies
CREATE POLICY org_read_outbound_activity
  ON public.organization_outbound_messages_activity
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
        FROM public.organization_outbound_messages m
      WHERE m.id = outbound_message_id
        AND m.organization_id = (
          SELECT organization_id
            FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_insert_outbound_activity
  ON public.organization_outbound_messages_activity
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
        FROM public.organization_outbound_messages m
      WHERE m.id = outbound_message_id
        AND m.organization_id = (
          SELECT organization_id
            FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_update_outbound_activity
  ON public.organization_outbound_messages_activity
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
        FROM public.organization_outbound_messages m
      WHERE m.id = outbound_message_id
        AND m.organization_id = (
          SELECT organization_id
            FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_delete_outbound_activity
  ON public.organization_outbound_messages_activity
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1
        FROM public.organization_outbound_messages m
      WHERE m.id = outbound_message_id
        AND m.organization_id = (
          SELECT organization_id
            FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

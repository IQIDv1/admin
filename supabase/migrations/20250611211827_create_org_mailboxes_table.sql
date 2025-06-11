-- ============================================
-- Migration: Create organization_mailboxes + RLS
-- ============================================

-- 1. Create the table
CREATE TABLE public.organization_mailboxes (
  id                   uuid            NOT NULL DEFAULT gen_random_uuid(),
  organization_id      uuid            NOT NULL,
  provider             text            NOT NULL
                            CHECK (provider = ANY (ARRAY['google','microsoft'])),
  email_address        text            NOT NULL,
  connection_settings  jsonb           NOT NULL,  -- e.g. { client_id, client_secret, tenant_id, group_id, scopes }
  is_active            boolean         NOT NULL DEFAULT true,
  last_synced_at       timestamptz,
  created_at           timestamptz     NOT NULL DEFAULT now(),
  updated_at           timestamptz     NOT NULL DEFAULT now(),
  CONSTRAINT organization_mailboxes_pkey
    PRIMARY KEY (id),
  CONSTRAINT organization_mailboxes_org_fkey
    FOREIGN KEY (organization_id)
      REFERENCES public.organizations(id) ON DELETE CASCADE
);

-- 2. Enable RLS
ALTER TABLE public.organization_mailboxes
  ENABLE ROW LEVEL SECURITY;

-- 3. Policies

-- a) Read: only if org matches
CREATE POLICY org_read_organization_mailboxes
  ON public.organization_mailboxes
  FOR SELECT
  USING (
    organization_id = (
      SELECT organization_id
      FROM public.members
      WHERE id = auth.uid()
    )
  );

-- b) Insert: only insert rows for your own org
CREATE POLICY org_insert_organization_mailboxes
  ON public.organization_mailboxes
  FOR INSERT
  WITH CHECK (
    organization_id = (
      SELECT organization_id
      FROM public.members
      WHERE id = auth.uid()
    )
  );

-- c) Update: only update rows for your own org
CREATE POLICY org_update_organization_mailboxes
  ON public.organization_mailboxes
  FOR UPDATE
  WITH CHECK (
    organization_id = (
      SELECT organization_id
      FROM public.members
      WHERE id = auth.uid()
    )
  );

-- d) (Optional) Delete: only delete rows for your own org
CREATE POLICY org_delete_organization_mailboxes
  ON public.organization_mailboxes
  FOR DELETE
  USING (
    organization_id = (
      SELECT organization_id
      FROM public.members
      WHERE id = auth.uid()
    )
  );

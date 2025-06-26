ALTER TABLE public.student_financial_aid
  ADD COLUMN fulfilled_requirements text;

-- ============================================
-- Migration: Create student_eab_match table + RLS
-- ============================================

CREATE TABLE public.student_eab_match (
  id                 uuid            NOT NULL DEFAULT gen_random_uuid(),
  student_id         uuid            NOT NULL REFERENCES public.students(id) ON DELETE CASCADE,
  profile_complete   boolean         NOT NULL,
  transcript_upload  boolean         NOT NULL,
  college_offers     text[]          NULL,   -- e.g. ARRAY['Montevallo','Huntsville','North Alabama']
  college_match      text[]          NULL,   -- e.g. ARRAY['Montevallo','Troy']
  enrollment_status  text            NULL,
  intended_major     text            NULL,
  created_at         timestamptz     NOT NULL DEFAULT now(),
  updated_at         timestamptz     NOT NULL DEFAULT now(),
  CONSTRAINT student_eab_match_pkey PRIMARY KEY (id)
);

-- Enable RLS
ALTER TABLE public.student_eab_match ENABLE ROW LEVEL SECURITY;

-- Only allow members of the same org to SELECT
CREATE POLICY org_read_eab_match
  ON public.student_eab_match
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_eab_match.student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

-- Only allow INSERT for your org’s students
CREATE POLICY org_insert_eab_match
  ON public.student_eab_match
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_eab_match.student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

-- Only allow UPDATE for your org’s students
CREATE POLICY org_update_eab_match
  ON public.student_eab_match
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_eab_match.student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

-- d) DELETE (optional): only allow deleting rows for students in your org
CREATE POLICY org_delete_eab_match
  ON public.student_eab_match
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_eab_match.student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );



-- ============================================
-- Migration: Add current_high_school + student_relationships + RLS
-- ============================================

-- 1) Add high-school to students
ALTER TABLE public.students
  ADD COLUMN current_high_school text;

-- 2) Create student_relationships
CREATE TABLE public.student_relationships (
  id                uuid        NOT NULL DEFAULT gen_random_uuid(),
  student_id        uuid        NOT NULL REFERENCES public.students(id) ON DELETE CASCADE,
  name              text        NOT NULL,
  relationship_type text        NOT NULL CHECK (relationship_type = ANY (ARRAY['parent','guardian','emergency_contact','other'])),
  email             text,
  ferpa_approved    boolean     NOT NULL DEFAULT false,
  created_at        timestamptz NOT NULL DEFAULT now(),
  updated_at        timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT student_relationships_pkey PRIMARY KEY (id)
);

-- 3) Enable Row Level Security
ALTER TABLE public.student_relationships
  ENABLE ROW LEVEL SECURITY;

-- 4) RLS Policies

-- a) SELECT: only see relationships for students in your org
CREATE POLICY org_read_student_relationships
  ON public.student_relationships
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_relationships.student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

-- b) INSERT: only add relationships for students in your org
CREATE POLICY org_insert_student_relationships
  ON public.student_relationships
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_relationships.student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

-- c) UPDATE: only update relationships for students in your org
CREATE POLICY org_update_student_relationships
  ON public.student_relationships
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_relationships.student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

-- d) DELETE: only remove relationships for students in your org
CREATE POLICY org_delete_student_relationships
  ON public.student_relationships
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_relationships.student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

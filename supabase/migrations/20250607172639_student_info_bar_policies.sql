-- ============================================
-- ROW LEVEL SECURITY POLICIES
-- ============================================

-- Students
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;

CREATE POLICY org_read_students
  ON public.students
  FOR SELECT
  USING (
    organization_id = (
      SELECT organization_id
      FROM public.members
      WHERE id = auth.uid()
    )
  );

CREATE POLICY org_insert_students
  ON public.students
  FOR INSERT
  WITH CHECK (
    organization_id = (
      SELECT organization_id
      FROM public.members
      WHERE id = auth.uid()
    )
  );

CREATE POLICY org_update_students
  ON public.students
  FOR UPDATE
  WITH CHECK (
    organization_id = (
      SELECT organization_id
      FROM public.members
      WHERE id = auth.uid()
    )
  );


-- Student Academic Info
ALTER TABLE public.student_academic ENABLE ROW LEVEL SECURITY;

CREATE POLICY org_read_academic
  ON public.student_academic
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_insert_academic
  ON public.student_academic
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_update_academic
  ON public.student_academic
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );


-- Student Financial Aid
ALTER TABLE public.student_financial_aid ENABLE ROW LEVEL SECURITY;

CREATE POLICY org_read_financial_aid
  ON public.student_financial_aid
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_insert_financial_aid
  ON public.student_financial_aid
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_update_financial_aid
  ON public.student_financial_aid
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );


-- Student Current Aid
ALTER TABLE public.student_current_aid ENABLE ROW LEVEL SECURITY;

CREATE POLICY org_read_current_aid
  ON public.student_current_aid
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_insert_current_aid
  ON public.student_current_aid
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_update_current_aid
  ON public.student_current_aid
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );


-- Student Loans
ALTER TABLE public.student_loans ENABLE ROW LEVEL SECURITY;

CREATE POLICY org_read_loans
  ON public.student_loans
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_insert_loans
  ON public.student_loans
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_update_loans
  ON public.student_loans
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );


-- Student Payments
ALTER TABLE public.student_payments ENABLE ROW LEVEL SECURITY;

CREATE POLICY org_read_payments
  ON public.student_payments
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_insert_payments
  ON public.student_payments
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_update_payments
  ON public.student_payments
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );


-- Student Interactions Summary
ALTER TABLE public.student_interactions_summary ENABLE ROW LEVEL SECURITY;

CREATE POLICY org_read_interactions
  ON public.student_interactions_summary
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_insert_interactions
  ON public.student_interactions_summary
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

CREATE POLICY org_update_interactions
  ON public.student_interactions_summary
  FOR UPDATE
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.students s
      WHERE s.id = student_id
        AND s.organization_id = (
          SELECT organization_id
          FROM public.members
          WHERE id = auth.uid()
        )
    )
  );

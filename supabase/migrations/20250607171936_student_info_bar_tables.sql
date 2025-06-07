-- 1. STUDENTS (already has id)
CREATE TABLE public.students (
  id                     uuid            NOT NULL DEFAULT gen_random_uuid(),
  organization_id        uuid            NOT NULL,
  banner_student_id      text            UNIQUE,
  first_name             text            NOT NULL,
  last_name              text            NOT NULL,
  email                  text,
  phone                  text,
  student_type           text,
  citizenship_status     text,
  created_at             timestamptz     NOT NULL DEFAULT now(),
  updated_at             timestamptz     NOT NULL DEFAULT now(),
  CONSTRAINT students_pkey        PRIMARY KEY (id),
  CONSTRAINT students_org_fkey    FOREIGN KEY (organization_id) REFERENCES public.organizations(id)
);

-- 2. ACADEMIC INFO
CREATE TABLE public.student_academic (
  id                     uuid            NOT NULL DEFAULT gen_random_uuid(),
  student_id             uuid            NOT NULL,
  enrollment_status      text,
  academic_program       text,
  academic_standing      text,
  gpa                    numeric(4,2),
  sap_status             text,
  created_at             timestamptz     NOT NULL DEFAULT now(),
  updated_at             timestamptz     NOT NULL DEFAULT now(),
  CONSTRAINT student_academic_pkey     PRIMARY KEY (id),
  CONSTRAINT student_academic_fkey     FOREIGN KEY (student_id) REFERENCES public.students(id)
);

-- 3. FINANCIAL AID INFO
CREATE TABLE public.student_financial_aid (
  id                     uuid            NOT NULL DEFAULT gen_random_uuid(),
  student_id             uuid            NOT NULL,
  fafsa_submission_date  date,
  dependency_status      text,
  cost_of_attendance     numeric,
  remaining_aid_eligibility numeric,
  award_status           text,
  outstanding_requirements text,
  created_at             timestamptz     NOT NULL DEFAULT now(),
  updated_at             timestamptz     NOT NULL DEFAULT now(),
  CONSTRAINT student_fin_aid_pkey      PRIMARY KEY (id),
  CONSTRAINT student_fin_aid_fkey      FOREIGN KEY (student_id) REFERENCES public.students(id)
);

-- 4. CURRENT AID STATUS
CREATE TABLE public.student_current_aid (
  id                     uuid            NOT NULL DEFAULT gen_random_uuid(),
  student_id             uuid            NOT NULL,
  federal_pell_grant     numeric,
  federal_direct_subsidized   numeric,
  federal_direct_unsubsidized numeric,
  institutional_aid      numeric,
  state_aid              numeric,
  created_at             timestamptz     NOT NULL DEFAULT now(),
  updated_at             timestamptz     NOT NULL DEFAULT now(),
  CONSTRAINT student_current_aid_pkey  PRIMARY KEY (id),
  CONSTRAINT student_current_aid_fkey  FOREIGN KEY (student_id) REFERENCES public.students(id)
);

-- 5. LOAN DETAILS (already had id)
CREATE TABLE public.student_loans (
  id                     uuid        NOT NULL DEFAULT gen_random_uuid(),
  student_id             uuid        NOT NULL,
  loan_type              text        NOT NULL,
  acceptance_status      text,
  amount                 numeric,
  created_at             timestamptz NOT NULL DEFAULT now(),
  updated_at             timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT student_loans_pkey         PRIMARY KEY (id),
  CONSTRAINT student_loans_fkey         FOREIGN KEY (student_id) REFERENCES public.students(id)
);

-- 6. PAYMENT PLANS & AUTH PAYER
CREATE TABLE public.student_payments (
  id                     uuid        NOT NULL DEFAULT gen_random_uuid(),
  student_id             uuid        NOT NULL,
  authorized_payer       text,
  payer_email            text,
  payment_plan_date      date,
  payment_plan_status    text,
  payment_declined_reason text,
  created_at             timestamptz NOT NULL DEFAULT now(),
  updated_at             timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT student_payments_pkey     PRIMARY KEY (id),
  CONSTRAINT student_payments_fkey     FOREIGN KEY (student_id) REFERENCES public.students(id)
);

-- 7. INTERACTIONS SUMMARY
CREATE TABLE public.student_interactions_summary (
  id                     uuid        NOT NULL DEFAULT gen_random_uuid(),
  student_id             uuid        NOT NULL,
  summary                text,
  interaction_link       text,
  created_at             timestamptz NOT NULL DEFAULT now(),
  updated_at             timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT student_interactions_pkey PRIMARY KEY (id),
  CONSTRAINT student_interactions_fkey FOREIGN KEY (student_id) REFERENCES public.students(id)
);

-- RLS policies remain the same: they all check the student_id’s org against auth.uid()
-- (no change needed there)

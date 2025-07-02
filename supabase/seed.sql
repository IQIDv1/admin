-- SQL script to create tables for local dev
-- You will need to create an auth user first using scripts/create_local_user.js,
-- and then use the auth.users.id in the inserts below.

INSERT INTO public.organizations (
  id,
  name,
  domain,
  sso_provider_id,
  sso_provider_name
) VALUES (
  '55a9b012-8dba-48c6-9cc6-ec3b774287d9',

  -- org name
  'Local IQID Dev',

  -- domain (must be UNIQUE)
  'iqid.io',

  -- sso_provider_id (just a placeholder)
  gen_random_uuid(),

  -- sso_provider_name must be 'google' or 'microsoft'
  'google'
);



INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  recovery_sent_at,
  last_sign_in_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at,
  confirmation_token,
  email_change,
  email_change_token_new,
  recovery_token
) VALUES (
  '00000000-0000-0000-0000-000000000000',
  '43a275eb-611d-46e7-b91a-5e4489ee042c',
  'authenticated',
  'authenticated',
  'local.developer@iqid.io',
  crypt('Testing123!', gen_salt('bf')),
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP,
  '{"provider":"email","providers":["email"]}',
  '{}',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP,
  '',
  '',
  '',
  ''
);

INSERT INTO auth.identities(
  id,
  user_id,
  provider_id,
  identity_data,
  provider,
  last_sign_in_at,
  created_at,
  updated_at)(
  SELECT
    uuid_generate_v4(),
    id,
    id,
    format('{"sub":"%s","email":"%s"}', id::text, email)::jsonb,
    'email',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
  FROM
    auth.users);

INSERT INTO public.members (
  id,
  organization_id,
  email,
  first_name,
  last_name,
  display_name,
  role,
  active,
  settings
) VALUES (
  -- this must match auth.users.id
  '43a275eb-611d-46e7-b91a-5e4489ee042c',

  -- the org we just made
  '55a9b012-8dba-48c6-9cc6-ec3b774287d9',
  'local.developer@iqid.io',
  'Local',
  'Dev',
  'Local Dev',

  -- CHECK (role = ANY (['admin','staff','owner']))
  'owner',

  -- mark active
  true,

  -- default settings
  '{}'::jsonb
);

INSERT INTO public.invites (
  id,
  organization_id,
  email,
  role,
  invited_by,
  accepted,
  expires_at
) VALUES (
  gen_random_uuid(),

  -- same org
  '55a9b012-8dba-48c6-9cc6-ec3b774287d9',

  -- who you’re “inviting”
  'another.dev@iqid.io',

  -- one of ['owner','admin','staff']
  'admin',

  -- must be an existing members.id
  '43a275eb-611d-46e7-b91a-5e4489ee042c',

  -- not yet accepted
  false,
  now() + interval '7 days'
);

-- Update the connection_settings for the organization_mailboxes table
-- Before running the seed, the CLIENT_ID, CLIENT_SECRET, TENANT_ID, and GROUP_ID
-- variables have to be manually edited in the SQL file.
INSERT INTO public.organization_mailboxes (
  organization_id, provider, email_address, connection_settings
) VALUES (
  '55a9b012-8dba-48c6-9cc6-ec3b774287d9',
  'microsoft',
  'Eric@acceleratedequityinsights.com',
  '{
    "client_id":     "${MAIL_CLIENT_ID}",
    "client_secret": "${MAIL_CLIENT_SECRET}",
    "tenant_id":     "${MAIL_TENANT_ID}",
    "group_id":      "${MAIL_GROUP_ID}"
  }'::jsonb
);

-- Auto-generated seed for Quiddy Project

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('78381907-b7ad-4c1d-881e-a3cd0ca092dd', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '2066309', 'Parker', 'Williams', 'parker.williams73@example.edu', '+1-462-841-9826', 'graduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('b5fc5a1f-095e-40fd-9744-7f0ae1479cc4', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '4154934', 'Casey', 'Martinez', 'casey.martinez47@example.edu', '+1-676-348-6568', 'undergraduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('14c0fa81-2347-410c-9182-910107145267', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '3648109', 'Finley', 'Jackson', 'finley.jackson49@example.edu', '+1-311-818-9866', 'graduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('f711290a-4d23-40dd-8010-e8c0d681b074', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '3236543', 'Emerson', 'White', 'emerson.white59@example.edu', '+1-735-350-1615', 'graduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('25560219-73f8-4f7b-98ae-96b0a9e1986f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '8339409', 'Micah', 'Lopez', 'micah.lopez20@example.edu', '+1-550-824-8453', 'undergraduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('71f26f96-af68-4a9a-89c3-1186c2bed0e6', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '6478006', 'Parker', 'Davis', 'parker.davis52@example.edu', '+1-773-405-3283', 'graduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('a870439b-ccf2-48ef-b635-9026027a1177', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '2121201', 'Taylor', 'Thompson', 'taylor.thompson60@example.edu', '+1-707-762-1885', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('6256be68-0512-42e9-afc2-8c2627cee1e7', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '9751247', 'Kerry', 'Johnson', 'kerry.johnson14@example.edu', '+1-670-593-7972', 'undergraduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('c8bf63c3-f60c-4fc5-a8fd-cb9363993b99', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '4547608', 'Dakota', 'Anderson', 'dakota.anderson41@example.edu', '+1-374-524-8972', 'undergraduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('7843791b-2a55-415c-9962-558938f63d28', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '5904665', 'Riley', 'Smith', 'riley.smith97@example.edu', '+1-456-633-4474', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('cd446011-69e2-45ef-8f89-1a91493b155a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '8322436', 'Dakota', 'Davis', 'dakota.davis89@example.edu', '+1-397-387-8891', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('a77f5ad7-6092-47e7-9e0b-000b9094bd80', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '1540758', 'Leslie', 'Lopez', 'leslie.lopez93@example.edu', '+1-785-396-2708', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('ab36b734-ef45-45ad-9483-1643af7768f1', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '2049670', 'Leslie', 'Miller', 'leslie.miller68@example.edu', '+1-689-427-9967', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('83cc8593-4f9b-4d78-9942-92eb99486c6b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '5579013', 'Parker', 'Thomas', 'parker.thomas53@example.edu', '+1-712-508-4208', 'undergraduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('fac3051c-471f-4bde-a5f9-d86f615d932d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '5273151', 'Finley', 'Rodriguez', 'finley.rodriguez44@example.edu', '+1-670-541-8381', 'graduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('aa67903f-a3a5-41e4-9884-187f98bf5075', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '7262579', 'Taylor', 'Martin', 'taylor.martin42@example.edu', '+1-632-861-1091', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('2dbc553a-6f35-4dd7-82e0-da1ac04b9c3f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '7382538', 'Riley', 'Martinez', 'riley.martinez79@example.edu', '+1-584-631-3591', 'graduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('ba84d896-8be0-4d88-a67d-5256588c7244', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '3818886', 'Riley', 'Davis', 'riley.davis21@example.edu', '+1-255-478-2066', 'graduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('951e1c44-03f8-4989-a3ac-ed94dbc8b709', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '9271293', 'Parker', 'Jones', 'parker.jones59@example.edu', '+1-581-994-5567', 'undergraduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('9fdb9dd4-d58f-4ccc-b229-aec0af57d384', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '6398917', 'Dana', 'Williams', 'dana.williams89@example.edu', '+1-900-960-1523', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('9e6a7b4b-ba63-409b-a483-107e6679a671', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '2382513', 'Jamie', 'Miller', 'jamie.miller28@example.edu', '+1-431-290-4467', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('1ab2f65e-89e1-4620-84b1-6fc30bb00a19', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '9227884', 'Cameron', 'Wilson', 'cameron.wilson42@example.edu', '+1-681-419-1656', 'graduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('6b7bddc7-b2cf-4730-baab-4b96dd04f786', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '9942225', 'Harper', 'Martin', 'harper.martin62@example.edu', '+1-234-958-4879', 'graduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('a3dbe56d-7c8e-4f91-9023-43ee0e035e49', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '2762508', 'Leslie', 'Hernandez', 'leslie.hernandez58@example.edu', '+1-508-610-6025', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('52a01e29-30d7-431f-9969-bfdff409f2f4', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '3843891', 'Dana', 'Davis', 'dana.davis96@example.edu', '+1-559-661-8202', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('6a94c8e0-ddec-493f-865f-bb5770f64b7a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '6176005', 'Finley', 'Garcia', 'finley.garcia83@example.edu', '+1-792-706-1489', 'graduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('fd6b2cf9-2fe1-4ad0-ad00-02bd546c887b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '6261838', 'Cameron', 'White', 'cameron.white52@example.edu', '+1-567-952-6483', 'undergraduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('5cb92517-0905-4c66-b4a3-3fbaff480cf9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '9976998', 'Jordan', 'Moore', 'jordan.moore13@example.edu', '+1-955-639-5058', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('6411819f-3c4a-4406-b7e0-1d047ed08e31', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '4399886', 'Kerry', 'Jones', 'kerry.jones32@example.edu', '+1-741-963-6041', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('f2c52cfe-abb1-460a-9c8c-c5699b29489f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '7565270', 'Alex', 'Garcia', 'alex.garcia32@example.edu', '+1-449-807-1659', 'graduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('75cf61ae-a79d-4f20-8fd2-ebbc5015a287', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '2521885', 'Leslie', 'Garcia', 'leslie.garcia31@example.edu', '+1-272-708-2676', 'undergraduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('94e5facc-f4ce-470c-b7e2-5382e1342756', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '7997310', 'Jamie', 'Martin', 'jamie.martin50@example.edu', '+1-519-286-5058', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('13ec0732-97fc-4160-ac82-9e9bc8cda710', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '9772935', 'Finley', 'White', 'finley.white31@example.edu', '+1-631-487-4738', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('05fca9b9-eb5a-4dd3-ae79-cadff8075d72', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '9396165', 'Leslie', 'Rodriguez', 'leslie.rodriguez85@example.edu', '+1-770-666-3393', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('47c7b3f4-6431-492c-9c12-8085a74596e4', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '6086318', 'Emerson', 'White', 'emerson.white53@example.edu', '+1-724-586-4773', 'undergraduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('6aebbdc8-6ad2-4cf2-b530-d68010f5ad4f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '5025660', 'Emerson', 'Martin', 'emerson.martin55@example.edu', '+1-616-862-1648', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('f9f78453-b85a-4efb-8568-40c934d9c21a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '9574973', 'Leslie', 'Lopez', 'leslie.lopez31@example.edu', '+1-688-986-8493', 'graduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('d7015043-1c03-4857-a167-e476032ddf08', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '7913038', 'Kendall', 'Thomas', 'kendall.thomas54@example.edu', '+1-965-423-8302', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('984c74cb-06b5-4b7b-acad-438e925a6ca5', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '2525425', 'Kendall', 'Williams', 'kendall.williams79@example.edu', '+1-527-885-3632', 'undergraduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('71f82f9c-4df2-4c20-901c-e78b57c916e1', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '7366963', 'Taylor', 'Anderson', 'taylor.anderson91@example.edu', '+1-592-877-2889', 'graduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('375e9102-fd40-4bc8-9677-342a18732738', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '1205685', 'Dakota', 'Garcia', 'dakota.garcia10@example.edu', '+1-358-691-6286', 'undergraduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('8c978b72-39f9-4cd5-a373-0cdfa0192b19', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '5775290', 'Parker', 'Moore', 'parker.moore40@example.edu', '+1-206-593-7852', 'undergraduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('48847e7a-17a4-4b1d-9a0d-20ff40baaf33', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '7061683', 'Emerson', 'Garcia', 'emerson.garcia69@example.edu', '+1-754-806-9556', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('7aebeb78-2764-40a5-9117-bb69decad69f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '4007400', 'Kendall', 'Martinez', 'kendall.martinez18@example.edu', '+1-350-721-5318', 'undergraduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('419ecd16-9b90-4899-a6eb-6a3a333d89d8', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '6155305', 'Cameron', 'Hernandez', 'cameron.hernandez81@example.edu', '+1-684-407-3082', 'undergraduate', 'US Citizen')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('05baa3eb-935c-4480-bc5a-16546bd9ef63', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '5309094', 'Quinn', 'Thomas', 'quinn.thomas3@example.edu', '+1-273-347-7164', 'graduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('850bc0cb-4f9d-404d-a164-842195638fda', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '9027315', 'Kerry', 'Rodriguez', 'kerry.rodriguez46@example.edu', '+1-291-459-6708', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('9c0a1f47-8c3c-49b1-87b3-ef31702f6876', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '7399148', 'Emerson', 'Miller', 'emerson.miller37@example.edu', '+1-860-927-8831', 'graduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('25349102-c149-4731-bcfb-18a5a9ef103f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '6385672', 'Emerson', 'Anderson', 'emerson.anderson97@example.edu', '+1-212-276-8720', 'graduate', 'Permanent Resident')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.students (id, organization_id, banner_student_id, first_name, last_name, email, phone, student_type, citizenship_status)
VALUES ('ebf71b92-c913-48db-8e29-9bae35dae51e', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', '1762975', 'Riley', 'Moore', 'riley.moore13@example.edu', '+1-552-727-3349', 'undergraduate', 'International')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('f80c2ee5-b1d4-4197-a494-7c42f5a35902', '78381907-b7ad-4c1d-881e-a3cd0ca092dd', 'Morgan Williams', 'guardian', 'morgan.williams@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('c41e9b4a-bba7-41e6-86eb-3ff0f37047ec', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4', 'Riley Martin', 'parent', 'riley.martin@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('352b6c75-a3c6-48fd-8500-a14ced62b1e4', '14c0fa81-2347-410c-9182-910107145267', 'Micah Garcia', 'emergency_contact', 'micah.garcia@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('0f5dd589-a06f-409b-9f8f-0e7849c0fd7e', 'f711290a-4d23-40dd-8010-e8c0d681b074', 'Morgan Lopez', 'guardian', 'morgan.lopez@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('8f439191-173e-4a26-bcad-d90cae7bec4c', '25560219-73f8-4f7b-98ae-96b0a9e1986f', 'Taylor Anderson', 'emergency_contact', 'taylor.anderson@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('08afce3f-581a-4c0d-b679-3f05c4fb4eea', '71f26f96-af68-4a9a-89c3-1186c2bed0e6', 'Cameron Davis', 'parent', 'cameron.davis@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('4d1d7f6f-fbc1-44c9-aa20-8b2adb977b68', 'a870439b-ccf2-48ef-b635-9026027a1177', 'Finley Jackson', 'parent', 'finley.jackson@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('1c0e6808-0d2b-4c70-9cc2-7849eec198d3', '6256be68-0512-42e9-afc2-8c2627cee1e7', 'Jordan White', 'guardian', 'jordan.white@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('442a5342-449f-464a-be36-abdc2ea17343', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99', 'Harper Martinez', 'emergency_contact', 'harper.martinez@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('d75431ee-c91c-47c9-8c80-2ac97346907d', '7843791b-2a55-415c-9962-558938f63d28', 'Leslie White', 'guardian', 'leslie.white@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('3195982b-024b-4281-b441-5c0fccbc5afc', 'cd446011-69e2-45ef-8f89-1a91493b155a', 'Cameron Williams', 'parent', 'cameron.williams@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('b850a27c-90b0-409f-8759-39ce1e747aa8', 'a77f5ad7-6092-47e7-9e0b-000b9094bd80', 'Jordan Johnson', 'emergency_contact', 'jordan.johnson@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('2202c510-0849-490f-88c6-bfa5655c48fd', 'ab36b734-ef45-45ad-9483-1643af7768f1', 'Parker Moore', 'parent', 'parker.moore@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('78b8ea27-ec0d-4e11-82dc-f461da146d9b', '83cc8593-4f9b-4d78-9942-92eb99486c6b', 'Taylor White', 'guardian', 'taylor.white@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('a6c64774-1248-4866-83c4-ab89d6341aff', 'fac3051c-471f-4bde-a5f9-d86f615d932d', 'Dakota Miller', 'guardian', 'dakota.miller@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('bbb054d8-7248-4c32-ab3b-a0e6f6de9e32', 'aa67903f-a3a5-41e4-9884-187f98bf5075', 'Riley Thompson', 'emergency_contact', 'riley.thompson@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('be5d4ac3-2aa1-4e90-878e-6eedfbae6aab', '2dbc553a-6f35-4dd7-82e0-da1ac04b9c3f', 'Cameron Moore', 'guardian', 'cameron.moore@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('5c2db6dc-3f53-4af8-860d-90324b13836a', 'ba84d896-8be0-4d88-a67d-5256588c7244', 'Jordan Jackson', 'guardian', 'jordan.jackson@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('e5a5ff48-8cbb-4f4e-a31c-32d1491e0677', '951e1c44-03f8-4989-a3ac-ed94dbc8b709', 'Harper Martinez', 'parent', 'harper.martinez@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('fef9f90a-c50c-4100-bd0d-66643b286cc0', '9fdb9dd4-d58f-4ccc-b229-aec0af57d384', 'Casey Thomas', 'emergency_contact', 'casey.thomas@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('b0b79837-e3be-4a4a-941d-d00662636568', '9e6a7b4b-ba63-409b-a483-107e6679a671', 'Dakota Thompson', 'emergency_contact', 'dakota.thompson@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('5946bab3-e783-4689-a189-f23e0923c0a2', '1ab2f65e-89e1-4620-84b1-6fc30bb00a19', 'Harper Johnson', 'emergency_contact', 'harper.johnson@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('71951d1f-240b-4572-96e0-7abff1f40062', '6b7bddc7-b2cf-4730-baab-4b96dd04f786', 'Taylor Williams', 'guardian', 'taylor.williams@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('b917c2e5-8433-41a6-8ce8-a8ac4ff8fb70', 'a3dbe56d-7c8e-4f91-9023-43ee0e035e49', 'Dana Smith', 'emergency_contact', 'dana.smith@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('106f23ae-8f56-40af-af8c-9316d05da831', '52a01e29-30d7-431f-9969-bfdff409f2f4', 'Dakota Thompson', 'parent', 'dakota.thompson@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('28c66e35-db02-4fb7-8adb-f08fb4a1c602', '6a94c8e0-ddec-493f-865f-bb5770f64b7a', 'Riley Miller', 'emergency_contact', 'riley.miller@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('6cb974e1-bab0-409a-bf3e-70be74eae080', 'fd6b2cf9-2fe1-4ad0-ad00-02bd546c887b', 'Cameron Davis', 'parent', 'cameron.davis@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('ac2577f1-696e-49f9-8402-d471836fd6de', '5cb92517-0905-4c66-b4a3-3fbaff480cf9', 'Riley Wilson', 'parent', 'riley.wilson@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('f73ef6a1-95ac-4130-a8d1-555b4ffb66d2', '6411819f-3c4a-4406-b7e0-1d047ed08e31', 'Dakota Thomas', 'parent', 'dakota.thomas@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('bc1c4550-b3d0-4e6a-a3fe-6a265d1c08c9', 'f2c52cfe-abb1-460a-9c8c-c5699b29489f', 'Finley Wilson', 'guardian', 'finley.wilson@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('aa15be66-e863-4deb-a022-6da0ab3c5885', '75cf61ae-a79d-4f20-8fd2-ebbc5015a287', 'Jamie Garcia', 'parent', 'jamie.garcia@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('6ccd4cbf-7fbb-4366-8b97-08839aa021a5', '94e5facc-f4ce-470c-b7e2-5382e1342756', 'Dakota Thompson', 'emergency_contact', 'dakota.thompson@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('eb08ed9b-6bd3-4227-a644-b07f380acecd', '13ec0732-97fc-4160-ac82-9e9bc8cda710', 'Dana Jackson', 'emergency_contact', 'dana.jackson@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('6443f16f-a9db-403c-ae98-0e7c1cb9a7b6', '05fca9b9-eb5a-4dd3-ae79-cadff8075d72', 'Harper Wilson', 'guardian', 'harper.wilson@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('4263db22-c35a-4c8f-8394-18a802c50186', '47c7b3f4-6431-492c-9c12-8085a74596e4', 'Casey Brown', 'emergency_contact', 'casey.brown@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('b86962ca-4604-4d62-8f3f-841a0153fdd1', '6aebbdc8-6ad2-4cf2-b530-d68010f5ad4f', 'Morgan Davis', 'emergency_contact', 'morgan.davis@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('adfa9cfb-3269-4dab-aab4-0fc4decf343c', 'f9f78453-b85a-4efb-8568-40c934d9c21a', 'Riley Brown', 'guardian', 'riley.brown@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('b64782d5-8f08-4dec-91a1-929b5ae94e4f', 'd7015043-1c03-4857-a167-e476032ddf08', 'Micah Moore', 'parent', 'micah.moore@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('699e0deb-54ab-41a5-bddb-85780291166c', '984c74cb-06b5-4b7b-acad-438e925a6ca5', 'Cameron Thompson', 'parent', 'cameron.thompson@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('50b8370f-f495-4a0a-8e7a-a21c7bd56db9', '71f82f9c-4df2-4c20-901c-e78b57c916e1', 'Alex White', 'guardian', 'alex.white@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('6e152ba6-f5fa-4e14-9bb3-da1a80feef1b', '375e9102-fd40-4bc8-9677-342a18732738', 'Cameron Smith', 'emergency_contact', 'cameron.smith@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('ba6abbbc-ba6b-44c8-a249-f668add1ff33', '8c978b72-39f9-4cd5-a373-0cdfa0192b19', 'Jamie Jackson', 'emergency_contact', 'jamie.jackson@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('b54e17b2-491f-4731-a82c-a3cbccbfd86a', '48847e7a-17a4-4b1d-9a0d-20ff40baaf33', 'Casey Rodriguez', 'emergency_contact', 'casey.rodriguez@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('4227896d-7561-4c68-94d8-20aaebea5ea5', '7aebeb78-2764-40a5-9117-bb69decad69f', 'Finley Brown', 'guardian', 'finley.brown@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('bdce6824-3ddf-4c97-bf18-a30f7c64fbb9', '419ecd16-9b90-4899-a6eb-6a3a333d89d8', 'Quinn Johnson', 'emergency_contact', 'quinn.johnson@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('82eb7671-6986-4bd9-a93c-7308f74fd054', '05baa3eb-935c-4480-bc5a-16546bd9ef63', 'Morgan Jackson', 'emergency_contact', 'morgan.jackson@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('6dbeefe1-8c5d-410c-b8fa-ec57b43f911d', '850bc0cb-4f9d-404d-a164-842195638fda', 'Kerry Miller', 'emergency_contact', 'kerry.miller@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('da487429-8e26-445c-b8da-5d7957433339', '9c0a1f47-8c3c-49b1-87b3-ef31702f6876', 'Dakota Moore', 'emergency_contact', 'dakota.moore@family.com', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('5b5b6642-a136-41bd-961d-019ba93bbe37', '25349102-c149-4731-bcfb-18a5a9ef103f', 'Dana Williams', 'emergency_contact', 'dana.williams@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_relationships (id, student_id, name, relationship_type, email, ferpa_approved)
VALUES ('725186a7-ebf2-4893-b28b-ef7527edc9e4', 'ebf71b92-c913-48db-8e29-9bae35dae51e', 'Parker Moore', 'emergency_contact', 'parker.moore@family.com', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('fdc805fc-6d76-4195-a2ab-6ff8f7c5519d', '78381907-b7ad-4c1d-881e-a3cd0ca092dd', 'Federal Direct Unsubsidized', 'Rejected', 18006)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('5c13f5b9-b507-46c7-9702-2c814048fd93', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4', 'Federal Direct Subsidized', 'Rejected', 3049)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('42164cdb-9b4d-4246-808b-7b16a9f4a444', '14c0fa81-2347-410c-9182-910107145267', 'Federal Direct Unsubsidized', 'Rejected', 12349)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('93e3574a-9555-4aea-a528-c8a5992e4fc1', 'f711290a-4d23-40dd-8010-e8c0d681b074', 'Private Loan', 'Rejected', 10068)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('a2f4f762-ddcf-4cf0-8828-869817b61994', '25560219-73f8-4f7b-98ae-96b0a9e1986f', 'Federal Direct Unsubsidized', 'Accepted', 6103)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('46aa78af-2da4-42e7-ad6c-2ca4ca940bc1', '71f26f96-af68-4a9a-89c3-1186c2bed0e6', 'Federal Direct Unsubsidized', 'Accepted', 19513)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('40958ca0-66b7-40f1-ab7d-d7444e55c62c', 'a870439b-ccf2-48ef-b635-9026027a1177', 'Private Loan', 'Rejected', 12024)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('5016a9c8-51d9-4a58-a454-2be2af7637bf', '6256be68-0512-42e9-afc2-8c2627cee1e7', 'Federal Direct Subsidized', 'Rejected', 7630)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('4e905f3e-3b8e-45a6-b84a-e66c7c25d1b3', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99', 'Federal Direct Subsidized', 'Rejected', 8064)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('f619929c-8fe5-4f08-ac36-6a38e122582a', '7843791b-2a55-415c-9962-558938f63d28', 'Private Loan', 'Accepted', 6265)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('783e55bd-3f15-4e88-bb04-39e6e3de0e5d', 'cd446011-69e2-45ef-8f89-1a91493b155a', 'Federal Direct Subsidized', 'Rejected', 6149)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('62f107ff-44f6-4372-bd71-59242f8a06d6', 'a77f5ad7-6092-47e7-9e0b-000b9094bd80', 'Private Loan', 'Rejected', 11329)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('68ab6e85-1149-4222-9080-58e647ad4918', 'ab36b734-ef45-45ad-9483-1643af7768f1', 'Private Loan', 'Rejected', 2047)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('b6ec13c2-8143-40b6-b061-9d5c5332583d', '83cc8593-4f9b-4d78-9942-92eb99486c6b', 'Federal Direct Unsubsidized', 'Accepted', 12979)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('9e0ec5cc-f2a8-4034-a54f-f0611eebb133', 'fac3051c-471f-4bde-a5f9-d86f615d932d', 'Federal Direct Unsubsidized', 'Pending', 14516)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('33ee7975-3c34-4673-897a-973ec01ca29f', 'aa67903f-a3a5-41e4-9884-187f98bf5075', 'Private Loan', 'Rejected', 9703)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('076c9c2a-5a7d-4fd0-89d7-e808edf35b18', '2dbc553a-6f35-4dd7-82e0-da1ac04b9c3f', 'Federal Direct Subsidized', 'Pending', 4052)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('d4bab442-4c6c-4aeb-aed5-ddbc9048c5d5', 'ba84d896-8be0-4d88-a67d-5256588c7244', 'Federal Direct Unsubsidized', 'Pending', 8447)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('5c6a4051-6654-4ce1-8f82-f113b39cc9e7', '951e1c44-03f8-4989-a3ac-ed94dbc8b709', 'Federal Direct Unsubsidized', 'Rejected', 9991)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('6fdc4282-00eb-428d-8b91-148c6537c278', '9fdb9dd4-d58f-4ccc-b229-aec0af57d384', 'Federal Direct Subsidized', 'Rejected', 3065)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('2b3aee16-e865-4818-b718-8b4f41e00388', '9e6a7b4b-ba63-409b-a483-107e6679a671', 'Federal Direct Subsidized', 'Pending', 13010)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('a0aa6dce-ec93-4ffe-8eb9-e72ccaf252a5', '1ab2f65e-89e1-4620-84b1-6fc30bb00a19', 'Federal Direct Unsubsidized', 'Accepted', 9697)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('4235d679-be85-4838-a1c2-c0a3476e1bb0', '6b7bddc7-b2cf-4730-baab-4b96dd04f786', 'Private Loan', 'Rejected', 9442)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('3d06e4f5-d916-42ea-90bb-921cc1a35063', 'a3dbe56d-7c8e-4f91-9023-43ee0e035e49', 'Federal Direct Unsubsidized', 'Rejected', 13645)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('03d31c2d-1f68-4e5c-83e6-69c01abe0140', '52a01e29-30d7-431f-9969-bfdff409f2f4', 'Private Loan', 'Pending', 9328)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('3e3f88cd-ad5b-4601-8190-25ad7ec501d6', '6a94c8e0-ddec-493f-865f-bb5770f64b7a', 'Federal Direct Subsidized', 'Accepted', 2255)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('112a5b1e-aa4d-4a08-8b39-c3d9ac1b787f', 'fd6b2cf9-2fe1-4ad0-ad00-02bd546c887b', 'Federal Direct Subsidized', 'Accepted', 1700)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('5096204c-203b-4c57-b0f2-905159d33a35', '5cb92517-0905-4c66-b4a3-3fbaff480cf9', 'Federal Direct Unsubsidized', 'Rejected', 14065)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('463d896c-09aa-448c-9930-d50662878533', '6411819f-3c4a-4406-b7e0-1d047ed08e31', 'Federal Direct Subsidized', 'Pending', 8671)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('9e689fe2-61a7-458c-85ca-434c4f6104e8', 'f2c52cfe-abb1-460a-9c8c-c5699b29489f', 'Federal Direct Unsubsidized', 'Accepted', 9473)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('ad906e0c-6361-4b50-b819-7dc26e9d45ac', '75cf61ae-a79d-4f20-8fd2-ebbc5015a287', 'Federal Direct Subsidized', 'Pending', 11531)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('054905b3-2f4a-4e0f-adb4-a5db1a26a5a6', '94e5facc-f4ce-470c-b7e2-5382e1342756', 'Federal Direct Subsidized', 'Accepted', 1690)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('f3f1f518-b4e2-4f59-a197-100211b6450e', '13ec0732-97fc-4160-ac82-9e9bc8cda710', 'Federal Direct Subsidized', 'Pending', 7962)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('39bd3c41-0241-482c-9a66-d06f9cafb2bf', '05fca9b9-eb5a-4dd3-ae79-cadff8075d72', 'Federal Direct Subsidized', 'Accepted', 3979)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('37c8d50d-851a-4135-a624-7adf2ab04040', '47c7b3f4-6431-492c-9c12-8085a74596e4', 'Private Loan', 'Accepted', 7864)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('beed0170-fd01-49ba-affd-3dae692542d1', '6aebbdc8-6ad2-4cf2-b530-d68010f5ad4f', 'Federal Direct Subsidized', 'Rejected', 16553)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('ae7f3e06-7624-436e-9963-ac8d9e77490c', 'f9f78453-b85a-4efb-8568-40c934d9c21a', 'Private Loan', 'Rejected', 2575)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('b6c9db17-5fe0-4aeb-b471-606170b4e4ad', 'd7015043-1c03-4857-a167-e476032ddf08', 'Private Loan', 'Rejected', 9154)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('23e4279c-baff-46ca-b5af-e098a8d4d45a', '984c74cb-06b5-4b7b-acad-438e925a6ca5', 'Federal Direct Subsidized', 'Pending', 8930)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('9bbd6151-5af3-45c4-8e5a-bd00cf6626d8', '71f82f9c-4df2-4c20-901c-e78b57c916e1', 'Federal Direct Subsidized', 'Pending', 16326)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('6ce7cdfa-46ef-4265-8f4d-ef3e4bcf4898', '375e9102-fd40-4bc8-9677-342a18732738', 'Federal Direct Subsidized', 'Pending', 6897)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('6155fefd-c1ce-494f-8835-2900abdb431b', '8c978b72-39f9-4cd5-a373-0cdfa0192b19', 'Private Loan', 'Accepted', 17880)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('ed1eb281-6fa8-4f80-a0bd-a5ee5f72bdbe', '48847e7a-17a4-4b1d-9a0d-20ff40baaf33', 'Federal Direct Subsidized', 'Pending', 5549)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('d40efe35-a159-4e4f-9279-667e527338fe', '7aebeb78-2764-40a5-9117-bb69decad69f', 'Federal Direct Unsubsidized', 'Accepted', 13532)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('87c2c60d-853a-4d80-aa0a-19718c7c25a6', '419ecd16-9b90-4899-a6eb-6a3a333d89d8', 'Federal Direct Subsidized', 'Rejected', 11911)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('a00c4edd-2a72-4386-a95a-9fbfb6f28a0e', '05baa3eb-935c-4480-bc5a-16546bd9ef63', 'Federal Direct Subsidized', 'Pending', 10684)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('33b87fd6-44d2-4981-9f79-dfacc111ff9e', '850bc0cb-4f9d-404d-a164-842195638fda', 'Federal Direct Subsidized', 'Pending', 12627)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('10e310ed-1e52-44ed-a358-c7f4239ed850', '9c0a1f47-8c3c-49b1-87b3-ef31702f6876', 'Private Loan', 'Rejected', 11777)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('342dd54b-7f64-41c1-bb24-491cb367227e', '25349102-c149-4731-bcfb-18a5a9ef103f', 'Federal Direct Subsidized', 'Rejected', 12673)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_loans (id, student_id, loan_type, acceptance_status, amount)
VALUES ('ccf845ce-7e62-4bd6-aa94-614ece37002b', 'ebf71b92-c913-48db-8e29-9bae35dae51e', 'Federal Direct Subsidized', 'Pending', 7628)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('89c59266-db62-4950-abd0-8737b5800eff', '78381907-b7ad-4c1d-881e-a3cd0ca092dd', 'Meeting scheduled with advisor', 'https://app.quiddy.com/interactions/89c59266-db62-4950-abd0-8737b5800eff')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('b1e279ba-00c8-46c1-b6b0-0a6f22dc2015', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/b1e279ba-00c8-46c1-b6b0-0a6f22dc2015')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('9026d40f-e83a-4ff1-b361-2317b206d617', '14c0fa81-2347-410c-9182-910107145267', 'Called regarding FAFSA requirement', 'https://app.quiddy.com/interactions/9026d40f-e83a-4ff1-b361-2317b206d617')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('8246decb-53c6-4f7e-8461-150b43e71b98', 'f711290a-4d23-40dd-8010-e8c0d681b074', 'Called regarding FAFSA requirement', 'https://app.quiddy.com/interactions/8246decb-53c6-4f7e-8461-150b43e71b98')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('fdcaea75-a033-4390-9bd6-9c3f14cbbb57', '25560219-73f8-4f7b-98ae-96b0a9e1986f', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/fdcaea75-a033-4390-9bd6-9c3f14cbbb57')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('a5717476-26a3-4a84-8be3-84c881860945', '71f26f96-af68-4a9a-89c3-1186c2bed0e6', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/a5717476-26a3-4a84-8be3-84c881860945')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('ad96ef80-9a20-48b5-87ca-4413cb82d2b1', 'a870439b-ccf2-48ef-b635-9026027a1177', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/ad96ef80-9a20-48b5-87ca-4413cb82d2b1')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('97e3323a-bf3b-4ea8-82e8-651cc032bc65', '6256be68-0512-42e9-afc2-8c2627cee1e7', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/97e3323a-bf3b-4ea8-82e8-651cc032bc65')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('3e8ac75e-8a24-44a6-80bb-d217e19b55d3', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/3e8ac75e-8a24-44a6-80bb-d217e19b55d3')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('05b9d15e-9c18-4d10-832e-a6f2d1f201ef', '7843791b-2a55-415c-9962-558938f63d28', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/05b9d15e-9c18-4d10-832e-a6f2d1f201ef')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('a6450ded-f00f-4260-9c89-a1be7a4372a4', 'cd446011-69e2-45ef-8f89-1a91493b155a', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/a6450ded-f00f-4260-9c89-a1be7a4372a4')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('81bd31e0-a67a-41cb-bb92-5a34e6ab463d', 'a77f5ad7-6092-47e7-9e0b-000b9094bd80', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/81bd31e0-a67a-41cb-bb92-5a34e6ab463d')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('4cab4f64-f3fc-4a87-a9dc-085126e83532', 'ab36b734-ef45-45ad-9483-1643af7768f1', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/4cab4f64-f3fc-4a87-a9dc-085126e83532')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('f31d3c0c-3f1a-42f3-b074-efe8179a347b', '83cc8593-4f9b-4d78-9942-92eb99486c6b', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/f31d3c0c-3f1a-42f3-b074-efe8179a347b')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('48c21ea1-49e0-44dc-b1db-721f644b68d1', 'fac3051c-471f-4bde-a5f9-d86f615d932d', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/48c21ea1-49e0-44dc-b1db-721f644b68d1')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('d02cea9e-a9c0-4baf-a090-13d46b92d582', 'aa67903f-a3a5-41e4-9884-187f98bf5075', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/d02cea9e-a9c0-4baf-a090-13d46b92d582')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('a853a293-aba0-417e-8a4c-40eb33ed7631', '2dbc553a-6f35-4dd7-82e0-da1ac04b9c3f', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/a853a293-aba0-417e-8a4c-40eb33ed7631')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('a9821152-2444-4cde-a70d-1d043dd6865a', 'ba84d896-8be0-4d88-a67d-5256588c7244', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/a9821152-2444-4cde-a70d-1d043dd6865a')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('9c23016a-5c9a-4675-9834-cc9db1d7a99f', '951e1c44-03f8-4989-a3ac-ed94dbc8b709', 'Called regarding FAFSA requirement', 'https://app.quiddy.com/interactions/9c23016a-5c9a-4675-9834-cc9db1d7a99f')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('f0f1168d-ca76-4a45-8a10-7f6ea912a116', '9fdb9dd4-d58f-4ccc-b229-aec0af57d384', 'Meeting scheduled with advisor', 'https://app.quiddy.com/interactions/f0f1168d-ca76-4a45-8a10-7f6ea912a116')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('cf447434-562b-4ac7-9945-44973b8342a4', '9e6a7b4b-ba63-409b-a483-107e6679a671', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/cf447434-562b-4ac7-9945-44973b8342a4')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('0d602474-03ed-4b1f-afe5-689a2570967c', '1ab2f65e-89e1-4620-84b1-6fc30bb00a19', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/0d602474-03ed-4b1f-afe5-689a2570967c')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('303777e6-febe-4551-8412-68a6acb994e9', '6b7bddc7-b2cf-4730-baab-4b96dd04f786', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/303777e6-febe-4551-8412-68a6acb994e9')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('4949cdab-ad91-436d-8b57-f00e500138aa', 'a3dbe56d-7c8e-4f91-9023-43ee0e035e49', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/4949cdab-ad91-436d-8b57-f00e500138aa')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('b9ecccbd-1881-4005-966d-6702def70e62', '52a01e29-30d7-431f-9969-bfdff409f2f4', 'Meeting scheduled with advisor', 'https://app.quiddy.com/interactions/b9ecccbd-1881-4005-966d-6702def70e62')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('a129e032-d377-4dc4-b087-32d4a8a28f46', '6a94c8e0-ddec-493f-865f-bb5770f64b7a', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/a129e032-d377-4dc4-b087-32d4a8a28f46')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('a47cf4ca-4026-40eb-a910-fb0969715262', 'fd6b2cf9-2fe1-4ad0-ad00-02bd546c887b', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/a47cf4ca-4026-40eb-a910-fb0969715262')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('50a2adf3-9acf-4a33-9d73-2492c24f23a1', '5cb92517-0905-4c66-b4a3-3fbaff480cf9', 'Meeting scheduled with advisor', 'https://app.quiddy.com/interactions/50a2adf3-9acf-4a33-9d73-2492c24f23a1')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('202e8e3d-b795-4acd-a966-a017aae9e8c9', '6411819f-3c4a-4406-b7e0-1d047ed08e31', 'Called regarding FAFSA requirement', 'https://app.quiddy.com/interactions/202e8e3d-b795-4acd-a966-a017aae9e8c9')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('fbe39fbe-ba7d-468a-aae8-174506038ad7', 'f2c52cfe-abb1-460a-9c8c-c5699b29489f', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/fbe39fbe-ba7d-468a-aae8-174506038ad7')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('edccc33d-d252-4092-ad17-7a7b3042b7b1', '75cf61ae-a79d-4f20-8fd2-ebbc5015a287', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/edccc33d-d252-4092-ad17-7a7b3042b7b1')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('3c3578ed-fbc9-4d8c-a4c3-d6ecd650d48c', '94e5facc-f4ce-470c-b7e2-5382e1342756', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/3c3578ed-fbc9-4d8c-a4c3-d6ecd650d48c')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('cc6988f9-7da1-4ef7-9931-7adced95bee9', '13ec0732-97fc-4160-ac82-9e9bc8cda710', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/cc6988f9-7da1-4ef7-9931-7adced95bee9')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('2caeb01d-ece5-4962-8692-040ab49b5237', '05fca9b9-eb5a-4dd3-ae79-cadff8075d72', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/2caeb01d-ece5-4962-8692-040ab49b5237')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('f42692c6-25f8-4b18-8e77-76b1ffe8ecba', '47c7b3f4-6431-492c-9c12-8085a74596e4', 'Called regarding FAFSA requirement', 'https://app.quiddy.com/interactions/f42692c6-25f8-4b18-8e77-76b1ffe8ecba')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('a2ae4b8d-ac51-4a57-a29e-b1bf70836ce1', '6aebbdc8-6ad2-4cf2-b530-d68010f5ad4f', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/a2ae4b8d-ac51-4a57-a29e-b1bf70836ce1')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('b2c46fe1-0930-4c4a-8310-afd3eba62827', 'f9f78453-b85a-4efb-8568-40c934d9c21a', 'Called regarding FAFSA requirement', 'https://app.quiddy.com/interactions/b2c46fe1-0930-4c4a-8310-afd3eba62827')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('eaa3e802-28e4-4d01-9a13-08eac2966333', 'd7015043-1c03-4857-a167-e476032ddf08', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/eaa3e802-28e4-4d01-9a13-08eac2966333')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('e8e91f1d-d81b-422e-b570-d4c6b92da338', '984c74cb-06b5-4b7b-acad-438e925a6ca5', 'Called regarding FAFSA requirement', 'https://app.quiddy.com/interactions/e8e91f1d-d81b-422e-b570-d4c6b92da338')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('c2f2bc35-e2cd-4e53-b83d-91ddd589a3de', '71f82f9c-4df2-4c20-901c-e78b57c916e1', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/c2f2bc35-e2cd-4e53-b83d-91ddd589a3de')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('5a530ab1-f9de-43bc-a9af-ea2302e986b4', '375e9102-fd40-4bc8-9677-342a18732738', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/5a530ab1-f9de-43bc-a9af-ea2302e986b4')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('6fa44168-38f0-4ea9-992f-5883a02b31e3', '8c978b72-39f9-4cd5-a373-0cdfa0192b19', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/6fa44168-38f0-4ea9-992f-5883a02b31e3')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('aca57554-e54d-4eba-bdaa-092b4e8edea4', '48847e7a-17a4-4b1d-9a0d-20ff40baaf33', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/aca57554-e54d-4eba-bdaa-092b4e8edea4')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('7adb02fc-a065-40fc-9090-60c98270a1e5', '7aebeb78-2764-40a5-9117-bb69decad69f', 'Follow-up on missing documents', 'https://app.quiddy.com/interactions/7adb02fc-a065-40fc-9090-60c98270a1e5')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('72218711-a55d-4b9e-b51e-c24829609ccd', '419ecd16-9b90-4899-a6eb-6a3a333d89d8', 'Called regarding FAFSA requirement', 'https://app.quiddy.com/interactions/72218711-a55d-4b9e-b51e-c24829609ccd')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('88687475-4fa6-4e49-81f9-57c00920b372', '05baa3eb-935c-4480-bc5a-16546bd9ef63', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/88687475-4fa6-4e49-81f9-57c00920b372')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('6cbc50e9-4c89-4cc3-8e4d-ab98255ee50b', '850bc0cb-4f9d-404d-a164-842195638fda', 'Called regarding FAFSA requirement', 'https://app.quiddy.com/interactions/6cbc50e9-4c89-4cc3-8e4d-ab98255ee50b')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('f5b6f575-2fdc-4965-9ce9-7cf87c0aee25', '9c0a1f47-8c3c-49b1-87b3-ef31702f6876', 'Left voicemail regarding tuition', 'https://app.quiddy.com/interactions/f5b6f575-2fdc-4965-9ce9-7cf87c0aee25')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('35c6ccd5-d7a5-447d-bd6e-2eacd2c6e95d', '25349102-c149-4731-bcfb-18a5a9ef103f', 'Sent email about enrollment status', 'https://app.quiddy.com/interactions/35c6ccd5-d7a5-447d-bd6e-2eacd2c6e95d')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_interactions_summary (id, student_id, summary, interaction_link)
VALUES ('a832df94-0e0f-4f8d-b2ad-04305364528a', 'ebf71b92-c913-48db-8e29-9bae35dae51e', 'Meeting scheduled with advisor', 'https://app.quiddy.com/interactions/a832df94-0e0f-4f8d-b2ad-04305364528a')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('33d07c72-2b96-4298-81f2-d1d48c0b6ee0', '78381907-b7ad-4c1d-881e-a3cd0ca092dd', '2024-05-07', 'Independent', 48847, 9684, 'Pending', 'Verification form, Proof of residency', 'Enrollment deposit')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('f6a46648-9475-40e0-9192-69be172430d8', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4', '2024-07-17', 'Dependent', 20283, 4324, 'Awarded', 'Proof of residency, Enrollment deposit, Verification form', 'Verification form, Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('84dc2518-64f4-4d44-8a07-9a7b6c056774', '14c0fa81-2347-410c-9182-910107145267', '2024-01-04', 'Dependent', 23567, 3175, 'Pending', 'Tax transcripts', 'Tax transcripts, Enrollment deposit')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('7b366ac1-605c-4f79-aac3-82fc2d2170e7', 'f711290a-4d23-40dd-8010-e8c0d681b074', '2025-01-28', 'Dependent', 47164, 1846, 'Pending', 'Enrollment deposit', 'Verification form, Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('37c9c12b-0794-46d4-be21-5c662b9efaaa', '25560219-73f8-4f7b-98ae-96b0a9e1986f', '2025-04-15', 'Dependent', 47554, 656, 'Pending', 'Tax transcripts, Enrollment deposit, Verification form', 'Enrollment deposit, Proof of residency')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('e04b7c73-8fd1-48a1-b262-53b1fea0fd6c', '71f26f96-af68-4a9a-89c3-1186c2bed0e6', '2024-03-06', 'Independent', 45119, 1994, 'Pending', 'Proof of residency, Enrollment deposit, Tax transcripts', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('22697267-d3bf-4089-ab84-15eebaef0a5f', 'a870439b-ccf2-48ef-b635-9026027a1177', '2024-10-09', 'Independent', 48596, 8526, 'Pending', 'Enrollment deposit, Tax transcripts', 'Proof of residency, Verification form')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('5bcc3e77-4883-424d-a75f-04b4ccf948f2', '6256be68-0512-42e9-afc2-8c2627cee1e7', '2025-01-19', 'Independent', 44877, 480, 'Rejected', 'Tax transcripts, Enrollment deposit', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('11c2d34b-ad8e-4201-8d27-39879069a2f3', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99', '2024-02-05', 'Dependent', 43199, 8603, 'Pending', 'Tax transcripts, Enrollment deposit', 'Enrollment deposit')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('a12ef3b4-ab6e-4300-8304-77f9e248babf', '7843791b-2a55-415c-9962-558938f63d28', '2025-04-06', 'Dependent', 44508, 6985, 'Rejected', 'Enrollment deposit, Proof of residency', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('f312848e-f221-434e-90f7-92fe57845cba', 'cd446011-69e2-45ef-8f89-1a91493b155a', '2024-08-29', 'Independent', 20439, 9494, 'Pending', 'Tax transcripts, Enrollment deposit, Proof of residency', 'Enrollment deposit, Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('d72fb27a-57bf-4d8a-8054-35401f515a2b', 'a77f5ad7-6092-47e7-9e0b-000b9094bd80', '2025-05-20', 'Dependent', 35430, 7230, 'Rejected', 'Proof of residency, Tax transcripts, Enrollment deposit', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('eb03971f-dd51-47ec-a539-f23578ef9cac', 'ab36b734-ef45-45ad-9483-1643af7768f1', '2024-03-15', 'Dependent', 44074, 896, 'Rejected', 'Tax transcripts', 'Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('271fab43-b2e5-4880-b83f-c07603d6957f', '83cc8593-4f9b-4d78-9942-92eb99486c6b', '2024-07-16', 'Independent', 34415, 5715, 'Rejected', 'Proof of residency', 'Verification form')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('c2592798-25a3-47e9-84ec-cfbd2fea907c', 'fac3051c-471f-4bde-a5f9-d86f615d932d', '2025-03-17', 'Dependent', 42454, 7092, 'Rejected', 'Tax transcripts, Verification form', 'Proof of residency, Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('092f7326-7a3e-4eb7-8dd8-65d403eda5de', 'aa67903f-a3a5-41e4-9884-187f98bf5075', '2025-03-14', 'Independent', 41180, 4304, 'Rejected', 'Proof of residency, Tax transcripts', 'Verification form, Enrollment deposit')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('0452e3b3-c2ba-412a-a4fb-48c44565845c', '2dbc553a-6f35-4dd7-82e0-da1ac04b9c3f', '2024-03-19', 'Dependent', 25934, 8647, 'Rejected', 'Enrollment deposit', 'Verification form')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('3e668b08-bbe5-4825-a167-0e4f463fd726', 'ba84d896-8be0-4d88-a67d-5256588c7244', '2025-02-08', 'Dependent', 24080, 8001, 'Awarded', 'Verification form, Proof of residency, Enrollment deposit', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('b7660fde-cf04-412b-b031-365da36e4196', '951e1c44-03f8-4989-a3ac-ed94dbc8b709', '2024-09-25', 'Dependent', 34903, 5235, 'Awarded', 'Proof of residency', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('e16ef6fe-6faa-46e5-997a-a641acab4154', '9fdb9dd4-d58f-4ccc-b229-aec0af57d384', '2024-11-07', 'Independent', 34399, 4829, 'Awarded', 'Proof of residency, Tax transcripts', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('e0b4d768-f092-43d9-8be4-eac9485963b4', '9e6a7b4b-ba63-409b-a483-107e6679a671', '2024-01-14', 'Dependent', 35246, 3845, 'Awarded', 'Verification form, Proof of residency', 'Proof of residency, Verification form')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('59884c42-a608-46a3-8566-79db10676001', '1ab2f65e-89e1-4620-84b1-6fc30bb00a19', '2025-02-01', 'Independent', 24224, 8908, 'Awarded', 'Proof of residency, Verification form, Enrollment deposit', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('18ecd6d4-c2df-4094-b456-c3a95488c8fa', '6b7bddc7-b2cf-4730-baab-4b96dd04f786', '2024-07-06', 'Dependent', 28710, 8984, 'Rejected', 'Enrollment deposit, Proof of residency, Tax transcripts', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('cf62d16f-c905-4bba-8946-4543c01e4928', 'a3dbe56d-7c8e-4f91-9023-43ee0e035e49', '2024-04-15', 'Independent', 27690, 1334, 'Awarded', 'Verification form, Tax transcripts, Enrollment deposit', 'Verification form')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('7cccfcaa-07bc-4fbf-b62d-c6c93f96a189', '52a01e29-30d7-431f-9969-bfdff409f2f4', '2025-04-16', 'Independent', 25087, 6744, 'Awarded', 'Tax transcripts', 'Enrollment deposit, Proof of residency')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('34deb399-4273-44c9-abf5-6e263d5f343c', '6a94c8e0-ddec-493f-865f-bb5770f64b7a', '2024-03-04', 'Dependent', 47236, 3172, 'Awarded', 'Enrollment deposit, Tax transcripts', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('d884db87-e397-45fe-acd8-3d6d16f4b3b6', 'fd6b2cf9-2fe1-4ad0-ad00-02bd546c887b', '2025-03-31', 'Independent', 22650, 7966, 'Rejected', 'Enrollment deposit, Tax transcripts, Verification form', 'Proof of residency, Verification form')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('6cb5faf0-e8c1-43ba-8fdc-86be3b6519b3', '5cb92517-0905-4c66-b4a3-3fbaff480cf9', '2025-05-25', 'Dependent', 47312, 9726, 'Pending', 'Proof of residency', 'Proof of residency')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('3f7d0a40-0373-4ea7-bddd-39be201055c4', '6411819f-3c4a-4406-b7e0-1d047ed08e31', '2024-08-27', 'Dependent', 49618, 1557, 'Rejected', 'Tax transcripts', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('8d4cd686-6099-4141-9263-5579554d8c21', 'f2c52cfe-abb1-460a-9c8c-c5699b29489f', '2025-06-02', 'Independent', 29284, 1669, 'Pending', 'Proof of residency, Tax transcripts, Enrollment deposit', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('44ddedda-3097-4392-a40e-7590d550cfb8', '75cf61ae-a79d-4f20-8fd2-ebbc5015a287', '2024-01-20', 'Independent', 27088, 5550, 'Awarded', 'Enrollment deposit, Proof of residency, Verification form', 'Proof of residency')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('0102c116-4647-41be-bcb5-7f3b6d7a8165', '94e5facc-f4ce-470c-b7e2-5382e1342756', '2024-05-13', 'Dependent', 40820, 6120, 'Pending', 'Verification form, Enrollment deposit, Proof of residency', 'Proof of residency')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('0806435e-109e-4090-9b36-df291b217849', '13ec0732-97fc-4160-ac82-9e9bc8cda710', '2025-03-12', 'Independent', 28380, 4365, 'Rejected', 'Enrollment deposit, Proof of residency, Tax transcripts', 'Enrollment deposit')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('7ddb5a3f-f641-4948-b0cf-8bb80dc88bf6', '05fca9b9-eb5a-4dd3-ae79-cadff8075d72', '2024-04-13', 'Independent', 28515, 5781, 'Awarded', 'Verification form, Enrollment deposit', 'Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('35dd1e69-b829-4053-a3ba-d2b9cd47665c', '47c7b3f4-6431-492c-9c12-8085a74596e4', '2024-11-12', 'Dependent', 33391, 9114, 'Pending', 'Tax transcripts, Proof of residency, Enrollment deposit', 'Enrollment deposit')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('008519ee-f478-4f5f-bcd2-007961660f10', '6aebbdc8-6ad2-4cf2-b530-d68010f5ad4f', '2025-04-20', 'Dependent', 25104, 2982, 'Rejected', 'Verification form, Tax transcripts', 'Enrollment deposit, Proof of residency')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('0482375e-13ce-4c8c-a51a-d266a842f09d', 'f9f78453-b85a-4efb-8568-40c934d9c21a', '2025-04-02', 'Independent', 24307, 3610, 'Awarded', 'Proof of residency, Enrollment deposit, Verification form', 'Enrollment deposit, Proof of residency')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('c94a445b-45ca-446f-9485-65365f1e3ac2', 'd7015043-1c03-4857-a167-e476032ddf08', '2025-03-14', 'Independent', 25278, 3722, 'Rejected', 'Verification form', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('f10f6c67-f996-42e1-883f-e16a84999a9d', '984c74cb-06b5-4b7b-acad-438e925a6ca5', '2024-09-25', 'Dependent', 20425, 5803, 'Rejected', 'Verification form, Proof of residency, Tax transcripts', 'Verification form, Enrollment deposit')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('f969b85e-5272-424f-9414-64277ea0ee5d', '71f82f9c-4df2-4c20-901c-e78b57c916e1', '2025-03-18', 'Dependent', 24232, 3402, 'Rejected', 'Tax transcripts', 'Proof of residency')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('d50fe57a-7734-4ce1-aea6-601f9e41f8f8', '375e9102-fd40-4bc8-9677-342a18732738', '2024-10-03', 'Independent', 32181, 9388, 'Pending', 'Proof of residency', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('1dfd6bf7-e738-45a1-b8a6-fc3d0b0d9fb7', '8c978b72-39f9-4cd5-a373-0cdfa0192b19', '2024-05-26', 'Independent', 46567, 9060, 'Pending', 'Tax transcripts', 'Tax transcripts, Enrollment deposit')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('e9da026c-3793-4f6d-8969-e76f7ab87cd1', '48847e7a-17a4-4b1d-9a0d-20ff40baaf33', '2024-12-04', 'Dependent', 27786, 5639, 'Rejected', 'Enrollment deposit, Proof of residency', 'Enrollment deposit, Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('a8fb0d53-997b-4c23-b8fc-86934ab3acd7', '7aebeb78-2764-40a5-9117-bb69decad69f', '2024-01-05', 'Independent', 24924, 1568, 'Awarded', 'Proof of residency, Tax transcripts', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('5bcabe19-d469-4d71-ae6c-15fc6cbf8bcb', '419ecd16-9b90-4899-a6eb-6a3a333d89d8', '2024-05-23', 'Dependent', 25628, 4210, 'Awarded', 'Proof of residency, Enrollment deposit, Tax transcripts', 'Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('9ae09eb6-bd15-430e-b9e4-c54805e57f7a', '05baa3eb-935c-4480-bc5a-16546bd9ef63', '2024-04-19', 'Dependent', 38914, 3216, 'Pending', 'Enrollment deposit, Proof of residency', 'Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('84675ffe-8299-4580-be67-b73e6664226c', '850bc0cb-4f9d-404d-a164-842195638fda', '2024-05-21', 'Independent', 31177, 7422, 'Awarded', 'Tax transcripts, Verification form, Proof of residency', 'Verification form, Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('e4c86b9f-a5a3-4e0f-a87c-9958d76eb05e', '9c0a1f47-8c3c-49b1-87b3-ef31702f6876', '2024-05-17', 'Dependent', 20768, 4522, 'Rejected', 'Proof of residency', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('dd9e6582-fa6a-4e87-a928-fea12d05adaf', '25349102-c149-4731-bcfb-18a5a9ef103f', '2025-04-18', 'Independent', 44760, 210, 'Awarded', 'Proof of residency', '')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_financial_aid (id, student_id, fafsa_submission_date, dependency_status, cost_of_attendance, remaining_aid_eligibility, award_status, outstanding_requirements, fulfilled_requirements)
VALUES ('213b6591-c28c-41c7-87e3-68a548b951a2', 'ebf71b92-c913-48db-8e29-9bae35dae51e', '2024-12-27', 'Independent', 30874, 9803, 'Awarded', 'Proof of residency', 'Verification form, Tax transcripts')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('43fd948b-0d61-47d3-af92-409234cfa46a', '78381907-b7ad-4c1d-881e-a3cd0ca092dd', 1685, 9891, 6612, 8551, 7152)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('20c8b9a8-0cde-4b34-98d4-6b48acb6486e', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4', 6174, 1701, 6525, 8643, 149)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('0e712d23-7de1-4169-be4a-9560d08d0e52', '14c0fa81-2347-410c-9182-910107145267', 1792, 3453, 9743, 9598, 3705)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('f7bb0aa9-9c0d-459a-b7d6-95aa276cd2d6', 'f711290a-4d23-40dd-8010-e8c0d681b074', 3550, 4617, 9447, 1948, 939)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('89068e7b-bc6b-4827-b290-f8e84094f6b3', '25560219-73f8-4f7b-98ae-96b0a9e1986f', 2094, 3743, 4875, 4770, 6889)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('4fa1ffae-81fe-4992-a974-f30c07669f21', '71f26f96-af68-4a9a-89c3-1186c2bed0e6', 1329, 7202, 8168, 1843, 6521)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('56f54956-48bf-4981-a87b-061c52b8474d', 'a870439b-ccf2-48ef-b635-9026027a1177', 2019, 2161, 2979, 1989, 4196)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('14752017-5411-48ef-8666-bd8e417474be', '6256be68-0512-42e9-afc2-8c2627cee1e7', 506, 8908, 3631, 9447, 806)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('7fb06fae-0a52-4c1e-88f2-0d16c021d693', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99', 8120, 5211, 1723, 6709, 2783)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('2b259ba8-0ee7-4238-87be-5555dae68c0e', '7843791b-2a55-415c-9962-558938f63d28', 4144, 2615, 3234, 711, 8988)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('daf4c460-d9f2-4920-8b47-bb47c383ad6f', 'cd446011-69e2-45ef-8f89-1a91493b155a', 6961, 5604, 5384, 6217, 9032)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('085820a6-2b75-4230-abad-450e80040e50', 'a77f5ad7-6092-47e7-9e0b-000b9094bd80', 1438, 4799, 7595, 353, 5828)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('b05ab3f8-8bce-4e0c-a033-302a9bb97ebc', 'ab36b734-ef45-45ad-9483-1643af7768f1', 7622, 391, 8367, 9313, 8685)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('5f04af2e-bbae-43d9-9f74-f5fd62cb3da7', '83cc8593-4f9b-4d78-9942-92eb99486c6b', 3407, 554, 8731, 5927, 1394)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('fdea47db-d329-47a7-aa3a-d6f14d61b210', 'fac3051c-471f-4bde-a5f9-d86f615d932d', 1719, 667, 4231, 2108, 8669)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('8ccbf752-1e70-4259-871f-e8fe12ca6623', 'aa67903f-a3a5-41e4-9884-187f98bf5075', 6482, 8325, 9082, 1742, 2822)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('ae5067a6-623a-4834-8492-b053e930e382', '2dbc553a-6f35-4dd7-82e0-da1ac04b9c3f', 6696, 6116, 5640, 653, 1141)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('b392748f-cb1d-4863-a6db-8a994a6dc317', 'ba84d896-8be0-4d88-a67d-5256588c7244', 4272, 2762, 2229, 1463, 2205)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('ae092e1a-10cf-4c90-8ab5-1fd0e0e8936e', '951e1c44-03f8-4989-a3ac-ed94dbc8b709', 2751, 2746, 2405, 6365, 3870)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('c2bb458c-b94d-4a1d-8305-1819cb9cd569', '9fdb9dd4-d58f-4ccc-b229-aec0af57d384', 4243, 904, 4134, 4492, 1295)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('63481271-7432-44f6-98bc-48517eb4e826', '9e6a7b4b-ba63-409b-a483-107e6679a671', 7563, 9132, 658, 3927, 6927)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('ea043b3c-b8bc-43a2-baf3-7ccba62eb44a', '1ab2f65e-89e1-4620-84b1-6fc30bb00a19', 1052, 5671, 7698, 3606, 5973)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('4e50407b-1c80-45fa-b6c5-98fb23e76981', '6b7bddc7-b2cf-4730-baab-4b96dd04f786', 1571, 9440, 6652, 6036, 4347)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('c005ec76-0a9d-4fe2-a4c4-13dd6d146b15', 'a3dbe56d-7c8e-4f91-9023-43ee0e035e49', 4089, 5254, 4522, 5632, 6821)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('f01e02c0-fa89-49ce-8f01-86a34530e7cf', '52a01e29-30d7-431f-9969-bfdff409f2f4', 921, 3511, 2729, 516, 1296)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('5092ec97-43a2-4db8-8fa3-ab8a14906a18', '6a94c8e0-ddec-493f-865f-bb5770f64b7a', 2961, 5132, 9333, 2505, 5947)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('1c073d0a-3a41-46c3-834f-13c5eb39cf8e', 'fd6b2cf9-2fe1-4ad0-ad00-02bd546c887b', 5297, 6233, 5682, 7787, 7249)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('c565bbcf-430a-4156-a23d-ed6e00a909bf', '5cb92517-0905-4c66-b4a3-3fbaff480cf9', 3176, 6127, 4471, 4031, 8011)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('feff9c95-c0d3-41d5-ae88-4c03cce71810', '6411819f-3c4a-4406-b7e0-1d047ed08e31', 1640, 588, 6595, 2182, 8774)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('4ea43430-0847-42d0-8acb-72ca9679193e', 'f2c52cfe-abb1-460a-9c8c-c5699b29489f', 2727, 3741, 3427, 9883, 385)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('da1b9835-0e79-40ff-833d-290dadc3faa3', '75cf61ae-a79d-4f20-8fd2-ebbc5015a287', 727, 767, 5141, 1631, 7720)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('86ea22d6-0ae7-473c-be19-914d172a2268', '94e5facc-f4ce-470c-b7e2-5382e1342756', 1403, 3107, 8484, 7811, 5195)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('fa224f89-7f36-4a11-ab89-499bce3e4e9b', '13ec0732-97fc-4160-ac82-9e9bc8cda710', 5813, 4105, 6723, 7024, 4226)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('5eedd53c-2275-48c3-b08e-0a552238cab6', '05fca9b9-eb5a-4dd3-ae79-cadff8075d72', 1670, 81, 6541, 398, 6694)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('83521873-08a3-4159-8304-6c217835505e', '47c7b3f4-6431-492c-9c12-8085a74596e4', 2199, 5951, 6519, 1679, 8844)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('efdd7814-ca48-45ad-834a-31f5984db84b', '6aebbdc8-6ad2-4cf2-b530-d68010f5ad4f', 2629, 6894, 2358, 4851, 2205)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('e1936b00-9645-4a92-b116-6b2a23e6fb12', 'f9f78453-b85a-4efb-8568-40c934d9c21a', 1830, 5245, 9705, 6228, 1124)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('17d16986-f525-4d94-b904-df3eada9d5ff', 'd7015043-1c03-4857-a167-e476032ddf08', 6790, 6350, 4947, 1858, 7001)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('85d7d369-e02a-4d21-9534-a65f9599dc83', '984c74cb-06b5-4b7b-acad-438e925a6ca5', 874, 300, 2764, 9095, 8859)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('eabb5534-aa76-43f3-a2b5-abb6751a1308', '71f82f9c-4df2-4c20-901c-e78b57c916e1', 2486, 7253, 6282, 593, 4697)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('982fdf60-6869-433f-8287-6ca1013fb51b', '375e9102-fd40-4bc8-9677-342a18732738', 2842, 563, 4887, 1058, 2176)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('05817c51-5605-4cc0-9286-3ae9799b4416', '8c978b72-39f9-4cd5-a373-0cdfa0192b19', 1039, 3186, 7163, 2515, 5112)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('3226bded-08a9-499c-a741-3d049c727417', '48847e7a-17a4-4b1d-9a0d-20ff40baaf33', 7409, 6064, 4363, 9459, 5505)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('9d31c735-092a-4d41-a00c-f25f5f882f1c', '7aebeb78-2764-40a5-9117-bb69decad69f', 4317, 1225, 8313, 8703, 4931)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('501b4fc1-002f-4a32-8489-015f51f0097a', '419ecd16-9b90-4899-a6eb-6a3a333d89d8', 4513, 8284, 7542, 1909, 7334)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('f40f9d13-318a-4b99-b003-c15e6915dade', '05baa3eb-935c-4480-bc5a-16546bd9ef63', 9005, 3771, 3158, 2287, 2256)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('e95c406c-269a-4b5c-84fb-e88000b3cd0c', '850bc0cb-4f9d-404d-a164-842195638fda', 5540, 4749, 8968, 9577, 3960)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('c56e01a3-7482-4b10-a110-99a6882b393e', '9c0a1f47-8c3c-49b1-87b3-ef31702f6876', 5207, 6286, 24, 2683, 1030)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('8179151d-55ab-4429-a293-ec2f9206e490', '25349102-c149-4731-bcfb-18a5a9ef103f', 3341, 1804, 8143, 9815, 1789)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_current_aid (id, student_id, federal_pell_grant, federal_direct_subsidized, federal_direct_unsubsidized, institutional_aid, state_aid)
VALUES ('f3a8be77-f05d-47c5-a243-c630db061b87', 'ebf71b92-c913-48db-8e29-9bae35dae51e', 1376, 8410, 254, 4348, 1646)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('b8edcf4c-75a1-42b8-b077-c241811e4c31', '78381907-b7ad-4c1d-881e-a3cd0ca092dd', FALSE, TRUE, NULL, NULL, 'Accepted', 'Spanish')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('4a8f4522-1664-486f-b695-646c04c9a373', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4', FALSE, FALSE, ARRAY['Auburn'], NULL, 'Accepted', 'Economics')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('7462f911-1471-44e7-a1e7-1505ff7a0993', '14c0fa81-2347-410c-9182-910107145267', TRUE, FALSE, NULL, NULL, 'Enrolled', 'Business')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('405de0d0-d5d8-4350-a7b7-8bdaf9da94dd', 'f711290a-4d23-40dd-8010-e8c0d681b074', FALSE, FALSE, NULL, NULL, NULL, 'Psychology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('a9873f56-9edd-4ce3-9f28-f62d53232912', '25560219-73f8-4f7b-98ae-96b0a9e1986f', TRUE, TRUE, ARRAY['Jacksonville'], ARRAY['Jacksonville'], 'Applied', 'Economics')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('3c99c24f-6856-43d0-9f5e-1976e51ddc2a', '71f26f96-af68-4a9a-89c3-1186c2bed0e6', FALSE, FALSE, ARRAY['Huntsville', 'Montevallo', 'Jacksonville', 'North Alabama'], ARRAY['Jacksonville', 'Huntsville', 'Montevallo'], 'Rejected', 'English')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('10ea0f33-07b8-4c3c-a2b9-7fe24614f7d2', 'a870439b-ccf2-48ef-b635-9026027a1177', TRUE, FALSE, ARRAY['Jacksonville', 'Jacksonville State'], ARRAY['Jacksonville', 'Jacksonville State'], NULL, 'Art')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('5cd9a589-9deb-4146-b895-0442369c2a9f', '6256be68-0512-42e9-afc2-8c2627cee1e7', FALSE, TRUE, ARRAY['A&M', 'Montevallo'], ARRAY['A&M', 'Montevallo'], NULL, 'Economics')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('74e139eb-a40d-4fa2-be4c-b7835cc1c904', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99', TRUE, TRUE, ARRAY['U of Alabama', 'Jacksonville State', 'Troy'], ARRAY['Jacksonville State', 'U of Alabama', 'Troy'], NULL, 'Business')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('4cd4d321-eceb-4dff-a7b2-9a0d1335f3b3', '7843791b-2a55-415c-9962-558938f63d28', TRUE, TRUE, ARRAY['Auburn Montgomery', 'Jacksonville', 'North Alabama'], ARRAY['Jacksonville'], 'Accepted', 'Engineering')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('acf80107-0ea0-402d-8ce7-3935b6cb6187', 'cd446011-69e2-45ef-8f89-1a91493b155a', TRUE, TRUE, ARRAY['Troy', 'MTSU'], ARRAY['MTSU'], 'Rejected', 'Economics')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('656cc423-85b3-4895-ab82-dc8cb6c94ef4', 'a77f5ad7-6092-47e7-9e0b-000b9094bd80', TRUE, TRUE, ARRAY['MTSU', 'Huntsville'], NULL, 'Accepted', 'Biology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('2b4a85c3-9422-4439-bb95-1b26931b63d1', 'ab36b734-ef45-45ad-9483-1643af7768f1', TRUE, FALSE, ARRAY['A&M', 'Huntsville', 'North Alabama'], ARRAY['A&M', 'Huntsville', 'North Alabama'], 'Accepted', 'Engineering')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('352d9add-8bd7-485e-80e8-96b731fa070d', '83cc8593-4f9b-4d78-9942-92eb99486c6b', TRUE, FALSE, NULL, NULL, 'Accepted', 'Biology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('1232929b-91a2-48e5-9ef3-64334aa9bfb1', 'fac3051c-471f-4bde-a5f9-d86f615d932d', TRUE, TRUE, ARRAY['Troy', 'Montevallo', 'UA-Birmingham'], ARRAY['Troy', 'UA-Birmingham', 'Montevallo'], 'Accepted', 'Biology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('5ac38b75-9560-4c0a-b6a4-8266a818f53b', 'aa67903f-a3a5-41e4-9884-187f98bf5075', TRUE, FALSE, ARRAY['Troy'], ARRAY['Troy'], 'Rejected', 'Art')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('12b4adb2-4273-42a7-96dd-77693622cd64', '2dbc553a-6f35-4dd7-82e0-da1ac04b9c3f', FALSE, FALSE, ARRAY['North Alabama', 'Montevallo', 'Jacksonville State', 'Jacksonville'], NULL, 'Applied', 'Psychology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('4a3e5497-f852-4901-9471-d6afae73d6a4', 'ba84d896-8be0-4d88-a67d-5256588c7244', FALSE, TRUE, NULL, NULL, NULL, 'Psychology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('f4b8d54b-0487-4874-a7da-756aa350eee0', '951e1c44-03f8-4989-a3ac-ed94dbc8b709', FALSE, TRUE, ARRAY['A&M', 'U of Alabama'], ARRAY['A&M', 'U of Alabama'], 'Accepted', 'Spanish')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('ab311ccd-60f4-4631-a6fc-63474f70cde1', '9fdb9dd4-d58f-4ccc-b229-aec0af57d384', TRUE, FALSE, ARRAY['North Alabama', 'Montevallo', 'Huntsville'], NULL, 'Rejected', 'Economics')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('bdfd2e31-5361-41f4-94a0-523f47cc7d89', '9e6a7b4b-ba63-409b-a483-107e6679a671', FALSE, FALSE, NULL, NULL, 'Rejected', 'Art')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('80c84b81-85e3-4c36-b4aa-c17878c456f9', '1ab2f65e-89e1-4620-84b1-6fc30bb00a19', TRUE, FALSE, ARRAY['Jacksonville', 'Jacksonville State'], NULL, 'Enrolled', 'English')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('0a04ae45-c05b-42b5-ae66-737c7ecad623', '6b7bddc7-b2cf-4730-baab-4b96dd04f786', TRUE, FALSE, NULL, NULL, NULL, 'Business')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('0dc01e07-23d3-4c99-b77d-27467d62462a', 'a3dbe56d-7c8e-4f91-9023-43ee0e035e49', TRUE, FALSE, ARRAY['MTSU'], NULL, 'Rejected', 'Economics')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('5b56d1ed-1e42-4eea-beb4-6c4fc389f197', '52a01e29-30d7-431f-9969-bfdff409f2f4', FALSE, TRUE, ARRAY['Auburn Montgomery', 'Auburn', 'U of Alabama'], NULL, 'Accepted', 'English')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('eedc8011-ccf6-413f-a694-4dc916f712fb', '6a94c8e0-ddec-493f-865f-bb5770f64b7a', FALSE, FALSE, ARRAY['Huntsville'], ARRAY['Huntsville'], 'Accepted', 'Biology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('e6e5e9bc-8eb3-45aa-a126-d229c1a58b66', 'fd6b2cf9-2fe1-4ad0-ad00-02bd546c887b', FALSE, TRUE, NULL, NULL, NULL, 'Art')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('3b04ce9a-44b9-4af4-999c-1743238a9873', '5cb92517-0905-4c66-b4a3-3fbaff480cf9', FALSE, TRUE, ARRAY['Troy', 'Huntsville', 'MTSU'], ARRAY['MTSU'], NULL, 'Economics')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('18d31b20-0ea7-4091-9ec5-e6b6cf7b396f', '6411819f-3c4a-4406-b7e0-1d047ed08e31', TRUE, FALSE, NULL, NULL, 'Accepted', 'Engineering')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('66c1d4e2-05bf-43bd-b3f0-506c74f50fe6', 'f2c52cfe-abb1-460a-9c8c-c5699b29489f', TRUE, TRUE, ARRAY['Jacksonville State', 'MTSU', 'Auburn'], NULL, NULL, 'Psychology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('38f57127-426b-4311-97b3-547b679e605a', '75cf61ae-a79d-4f20-8fd2-ebbc5015a287', TRUE, TRUE, ARRAY['Auburn', 'Jacksonville State'], NULL, 'Enrolled', 'Biology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('50c62849-73ca-4250-aead-db9101f84d4a', '94e5facc-f4ce-470c-b7e2-5382e1342756', FALSE, FALSE, ARRAY['UA-Birmingham'], ARRAY['UA-Birmingham'], 'Rejected', 'Economics')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('ca671cb4-5842-49a9-84a3-db5a99be16e4', '13ec0732-97fc-4160-ac82-9e9bc8cda710', FALSE, TRUE, ARRAY['Jacksonville', 'A&M'], NULL, 'Enrolled', 'Art')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('0a13175a-f739-4a08-93cd-3d47af0ed835', '05fca9b9-eb5a-4dd3-ae79-cadff8075d72', FALSE, FALSE, ARRAY['Jacksonville State', 'A&M'], ARRAY['Jacksonville State', 'A&M'], 'Rejected', 'Spanish')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('b55bed0f-168f-4af2-9f66-b0351e2a4553', '47c7b3f4-6431-492c-9c12-8085a74596e4', TRUE, TRUE, ARRAY['MTSU', 'Jacksonville State', 'Jacksonville', 'Huntsville'], ARRAY['MTSU', 'Jacksonville State', 'Huntsville'], 'Applied', 'Art')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('6ebde3aa-fe27-4b3e-a46e-6ce60dc30a83', '6aebbdc8-6ad2-4cf2-b530-d68010f5ad4f', TRUE, TRUE, ARRAY['U of Alabama', 'Jacksonville State', 'UA-Birmingham', 'Montevallo'], NULL, 'Rejected', 'Business')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('3a5ef55d-e8e7-4910-937a-6d62298062d6', 'f9f78453-b85a-4efb-8568-40c934d9c21a', FALSE, TRUE, NULL, NULL, 'Applied', 'Engineering')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('693bc9eb-e665-463f-8048-043dc4e604a3', 'd7015043-1c03-4857-a167-e476032ddf08', TRUE, TRUE, ARRAY['Auburn Montgomery', 'Jacksonville'], ARRAY['Jacksonville', 'Auburn Montgomery'], 'Rejected', 'Business')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('48222411-84d0-491e-bab3-0dc965029b42', '984c74cb-06b5-4b7b-acad-438e925a6ca5', TRUE, FALSE, ARRAY['Auburn Montgomery'], ARRAY['Auburn Montgomery'], 'Enrolled', 'Business')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('7eccffcf-fa86-456b-ae89-516c55e8c4e2', '71f82f9c-4df2-4c20-901c-e78b57c916e1', TRUE, TRUE, NULL, NULL, 'Accepted', 'History')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('5744f7ae-391a-48c2-bc9f-fb0c4464eefe', '375e9102-fd40-4bc8-9677-342a18732738', TRUE, TRUE, ARRAY['UA-Birmingham'], ARRAY['UA-Birmingham'], 'Applied', 'Engineering')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('fb0019f2-2010-41f4-adf4-b76ae6d99c2d', '8c978b72-39f9-4cd5-a373-0cdfa0192b19', TRUE, FALSE, ARRAY['UA-Birmingham'], ARRAY['UA-Birmingham'], 'Accepted', 'Art')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('f2780daf-2c1c-43d9-b658-d879a886e2d0', '48847e7a-17a4-4b1d-9a0d-20ff40baaf33', FALSE, TRUE, ARRAY['U of Alabama', 'Jacksonville State', 'Jacksonville', 'A&M'], ARRAY['Jacksonville State'], 'Applied', 'English')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('68f2dac3-c79f-4e9b-8df9-5531be59eb40', '7aebeb78-2764-40a5-9117-bb69decad69f', TRUE, FALSE, ARRAY['UA-Birmingham', 'North Alabama', 'U of Alabama'], ARRAY['North Alabama', 'UA-Birmingham'], 'Enrolled', 'Psychology')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('17e9a2eb-282f-45ab-b1d1-b602c6472019', '419ecd16-9b90-4899-a6eb-6a3a333d89d8', TRUE, TRUE, ARRAY['Troy', 'Huntsville', 'Auburn'], ARRAY['Huntsville'], 'Accepted', 'Engineering')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('ad20578a-b60d-40cc-bea4-3b9a523bb206', '05baa3eb-935c-4480-bc5a-16546bd9ef63', TRUE, FALSE, NULL, NULL, 'Rejected', 'History')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('e2379a5b-0a61-4d98-aded-88aaf81923b9', '850bc0cb-4f9d-404d-a164-842195638fda', FALSE, TRUE, NULL, NULL, 'Enrolled', 'Spanish')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('b6a2fcc1-c45b-437d-9223-d71a2b4addbf', '9c0a1f47-8c3c-49b1-87b3-ef31702f6876', FALSE, TRUE, ARRAY['U of Alabama', 'Auburn', 'Jacksonville State'], NULL, NULL, 'Economics')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('27fd56ae-1440-4770-91e7-0a8f701d7a2e', '25349102-c149-4731-bcfb-18a5a9ef103f', TRUE, TRUE, NULL, NULL, NULL, 'History')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_eab_match (id, student_id, profile_complete, transcript_upload, college_offers, college_match, enrollment_status, intended_major)
VALUES ('872d0a37-99bc-4387-8929-280f5b9b8feb', 'ebf71b92-c913-48db-8e29-9bae35dae51e', TRUE, TRUE, NULL, NULL, 'Accepted', 'Spanish')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('26935dd9-c8da-434b-88c4-eea2e78d607e', '78381907-b7ad-4c1d-881e-a3cd0ca092dd', 'Enrolled', 'English', 'Suspended', 2.86, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('aa3e6963-c242-4c62-b80b-f65945291df5', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4', 'Graduated', 'Computer Science', 'Good Standing', 1.46, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('be87d9a9-69fa-492c-88df-6f922931acab', '14c0fa81-2347-410c-9182-910107145267', 'Enrolled', 'Economics', 'Suspended', 1.02, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('ad212c68-b025-42aa-b91a-9ac3fc881189', 'f711290a-4d23-40dd-8010-e8c0d681b074', 'Leave of Absence', 'Psychology', 'Suspended', 0.41, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('7e4583fb-c01a-4d51-99c2-d726122503ad', '25560219-73f8-4f7b-98ae-96b0a9e1986f', 'Leave of Absence', 'Biology', 'Suspended', 2.67, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('642af5f6-d52e-4935-8b70-18dfaf6f8749', '71f26f96-af68-4a9a-89c3-1186c2bed0e6', 'Enrolled', 'Art', 'Good Standing', 2.61, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('a35aa2d8-66d3-494e-afe8-150617b550a5', 'a870439b-ccf2-48ef-b635-9026027a1177', 'Dropped', 'Computer Science', 'Suspended', 2.84, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('a3758f2b-a991-4780-a856-90d377bb4c09', '6256be68-0512-42e9-afc2-8c2627cee1e7', 'Leave of Absence', 'Economics', 'Suspended', 2.85, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('687a5f3a-f950-4dff-b322-978fcf93077d', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99', 'Graduated', 'Engineering', 'Probation', 0.26, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('edb0926a-a315-43e3-8b51-ec2742f2a6cd', '7843791b-2a55-415c-9962-558938f63d28', 'Enrolled', 'Psychology', 'Good Standing', 1.43, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('43027935-da31-460a-be61-37a9169d3ccf', 'cd446011-69e2-45ef-8f89-1a91493b155a', 'Dropped', 'Business', 'Suspended', 3.68, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('5de361c0-89bb-43ce-be12-26f9bc7ba08f', 'a77f5ad7-6092-47e7-9e0b-000b9094bd80', 'Graduated', 'History', 'Good Standing', 2.99, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('5fa12ceb-82c6-443f-8fb2-49028a6a38bc', 'ab36b734-ef45-45ad-9483-1643af7768f1', 'Graduated', 'Business', 'Suspended', 3.66, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('63370282-42c6-448d-8f94-7407330ec203', '83cc8593-4f9b-4d78-9942-92eb99486c6b', 'Dropped', 'Spanish', 'Good Standing', 1.45, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('480f4880-7e60-45f4-a911-fe623c1dc85a', 'fac3051c-471f-4bde-a5f9-d86f615d932d', 'Dropped', 'Art', 'Suspended', 3.18, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('3c39e47a-6f89-4f91-b07b-42358004d7b1', 'aa67903f-a3a5-41e4-9884-187f98bf5075', 'Dropped', 'Art', 'Probation', 0.56, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('a3199620-b862-454b-9fac-6590fe807b4f', '2dbc553a-6f35-4dd7-82e0-da1ac04b9c3f', 'Leave of Absence', 'Computer Science', 'Probation', 0.59, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('9f85110e-da65-4008-aad9-04e33a686371', 'ba84d896-8be0-4d88-a67d-5256588c7244', 'Enrolled', 'Engineering', 'Probation', 2.04, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('4c52e100-c621-4bd6-8f72-e38fcf2ae604', '951e1c44-03f8-4989-a3ac-ed94dbc8b709', 'Enrolled', 'Business', 'Suspended', 1.29, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('468e0176-4598-4866-9967-3f795444d5f1', '9fdb9dd4-d58f-4ccc-b229-aec0af57d384', 'Graduated', 'Spanish', 'Good Standing', 0.74, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('062c156f-cd69-4dcd-8b08-7cac1a1a24d4', '9e6a7b4b-ba63-409b-a483-107e6679a671', 'Graduated', 'Psychology', 'Suspended', 2.09, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('02aaf6de-5389-4ee1-a55d-f9845b652adf', '1ab2f65e-89e1-4620-84b1-6fc30bb00a19', 'Enrolled', 'History', 'Suspended', 2.27, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('de4feea0-a40f-40a1-b0fb-6227c73f3844', '6b7bddc7-b2cf-4730-baab-4b96dd04f786', 'Enrolled', 'Biology', 'Good Standing', 3.69, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('88c7727a-2ee0-475d-a88f-312618e5220b', 'a3dbe56d-7c8e-4f91-9023-43ee0e035e49', 'Dropped', 'Biology', 'Probation', 3.79, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('aa3e83ad-276d-4482-9121-b73e1c39469b', '52a01e29-30d7-431f-9969-bfdff409f2f4', 'Dropped', 'Psychology', 'Suspended', 3.31, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('f931ece7-6674-4edc-9a93-27706c0cf3e0', '6a94c8e0-ddec-493f-865f-bb5770f64b7a', 'Dropped', 'Business', 'Probation', 1.67, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('8d7ba9b8-33cb-4af2-9a3d-2c0a0c1ccfd1', 'fd6b2cf9-2fe1-4ad0-ad00-02bd546c887b', 'Graduated', 'English', 'Probation', 3.08, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('08169f12-3d10-4364-b877-9dfa27e58642', '5cb92517-0905-4c66-b4a3-3fbaff480cf9', 'Enrolled', 'Computer Science', 'Good Standing', 1.31, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('770b4f02-49c8-4b5e-9678-b373e1ee2fa8', '6411819f-3c4a-4406-b7e0-1d047ed08e31', 'Dropped', 'Business', 'Good Standing', 1.62, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('35c86c72-3fb5-487d-80b9-3f41010413f0', 'f2c52cfe-abb1-460a-9c8c-c5699b29489f', 'Graduated', 'Economics', 'Probation', 1.75, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('e48bf8a3-ac5b-40a5-b01a-dd6e79066c0a', '75cf61ae-a79d-4f20-8fd2-ebbc5015a287', 'Leave of Absence', 'Computer Science', 'Probation', 1.97, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('9337b5d5-75b0-474c-b8cd-8d0f3b53a54b', '94e5facc-f4ce-470c-b7e2-5382e1342756', 'Dropped', 'Computer Science', 'Good Standing', 3.79, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('c622ea7a-6dcc-4090-9e88-a33dde555234', '13ec0732-97fc-4160-ac82-9e9bc8cda710', 'Graduated', 'Biology', 'Probation', 0.7, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('59bed933-0e50-4a50-b3a2-61e2529e2367', '05fca9b9-eb5a-4dd3-ae79-cadff8075d72', 'Dropped', 'English', 'Good Standing', 3.53, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('22475219-6202-4465-99f9-afbc9a5db7d9', '47c7b3f4-6431-492c-9c12-8085a74596e4', 'Dropped', 'English', 'Suspended', 1.37, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('cba98eb9-7bea-47c0-8ba4-fa4eb16cf00d', '6aebbdc8-6ad2-4cf2-b530-d68010f5ad4f', 'Graduated', 'English', 'Good Standing', 1.61, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('838e290d-47da-40b4-9b65-ef5513c6d510', 'f9f78453-b85a-4efb-8568-40c934d9c21a', 'Leave of Absence', 'Economics', 'Probation', 2.05, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('ab320d9f-cb98-42d6-b988-520d4c2ecbf6', 'd7015043-1c03-4857-a167-e476032ddf08', 'Dropped', 'English', 'Good Standing', 3.64, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('72776a75-db68-4371-a3f7-3217cad1b881', '984c74cb-06b5-4b7b-acad-438e925a6ca5', 'Leave of Absence', 'Economics', 'Probation', 1.13, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('4c99072c-16e7-458a-a16b-bf434496117c', '71f82f9c-4df2-4c20-901c-e78b57c916e1', 'Enrolled', 'Psychology', 'Probation', 3.04, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('b9d2d25b-1d4e-4315-97dc-4078e419d1de', '375e9102-fd40-4bc8-9677-342a18732738', 'Leave of Absence', 'Biology', 'Probation', 2.44, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('d30b84c4-e130-4398-8aef-1248e43de987', '8c978b72-39f9-4cd5-a373-0cdfa0192b19', 'Enrolled', 'Art', 'Good Standing', 2.92, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('55c4a88f-116f-4dfa-a6e2-6300cfbbfaa9', '48847e7a-17a4-4b1d-9a0d-20ff40baaf33', 'Dropped', 'Business', 'Probation', 0.22, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('304a28ee-2014-4b2c-a648-9c7c45c117a1', '7aebeb78-2764-40a5-9117-bb69decad69f', 'Dropped', 'Computer Science', 'Probation', 1.92, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('1e30178a-640b-430b-9ee4-d8b116649ea6', '419ecd16-9b90-4899-a6eb-6a3a333d89d8', 'Graduated', 'Computer Science', 'Probation', 3.52, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('3a6d8b9e-03cc-40da-9c39-cebefd6d92f6', '05baa3eb-935c-4480-bc5a-16546bd9ef63', 'Graduated', 'Computer Science', 'Probation', 2.03, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('bf5a8399-038e-46df-8535-70181e3cf635', '850bc0cb-4f9d-404d-a164-842195638fda', 'Leave of Absence', 'Art', 'Probation', 0.08, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('696aff81-6e9a-4780-a884-898a3702f6c5', '9c0a1f47-8c3c-49b1-87b3-ef31702f6876', 'Enrolled', 'History', 'Probation', 2.95, 'Not Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('cf439a15-db1f-4da2-a10b-80ffa3f4f3f7', '25349102-c149-4731-bcfb-18a5a9ef103f', 'Enrolled', 'Business', 'Suspended', 3.01, 'Met')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.student_academic (id, student_id, enrollment_status, academic_program, academic_standing, gpa, sap_status)
VALUES ('2e004d9a-ebc5-4d3c-813c-6b20d75fbb02', 'ebf71b92-c913-48db-8e29-9bae35dae51e', 'Graduated', 'Business', 'Suspended', 3.99, 'Met')
ON CONFLICT (id) DO NOTHING;

-- Auto-generated seed for inbound messages and student mappings

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '5737afb4-720d-4e4a-aebb-8c774a17303b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. I am reaching out regarding my financial aid application. I hope this message finds you well. Could you please provide me with an update on the current status?', 'microsoft', 'da1cac3e-5562-46ff-8596-7af12ff2cb6e', '7f58e557-b35a-4acd-a0b4-89edc1f7c13b', '2025-06-12T05:50:05.893960'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '5737afb4-720d-4e4a-aebb-8c774a17303b', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '8b546d1b-8b03-4f9f-ae13-2702d3090ab8', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. Could you please provide me with an update on the current status? Thank you for your time and assistance.', 'microsoft', '34eef03e-3ad2-41b0-9b77-6709bbf7944d', '79be1537-63da-41f7-a94e-8a857683fead', '2025-06-24T06:21:05.894714'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '8b546d1b-8b03-4f9f-ae13-2702d3090ab8', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '701365f0-bf57-4a4a-b34e-b97947c93864', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. Thank you for your time and assistance. Could you please provide me with an update on the current status? Feel free to contact me if you need further information.', 'microsoft', '898440be-e0b3-4ac8-9f34-78ab409eecdc', '40134389-3a07-4768-b2e8-ea12eff14c1e', '2025-06-30T16:20:05.895075'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '701365f0-bf57-4a4a-b34e-b97947c93864', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '6c3e5066-4b97-4077-9495-5853b82b639c', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Feel free to contact me if you need further information. Please let me know if there are any additional documents I need to submit. I hope this message finds you well. I am reaching out regarding my financial aid application.', 'microsoft', 'f20d6e4f-3153-4007-a8f9-4d2cc83419ac', '490d84db-18cd-4462-b3ca-fc1739cad54e', '2025-06-25T12:10:05.895180'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '6c3e5066-4b97-4077-9495-5853b82b639c', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'cff45859-e165-4f2d-93bf-a0840641ec56', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Feel free to contact me if you need further information. Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit. I am reaching out regarding my financial aid application.', 'microsoft', 'a1ac3c1e-f93a-418e-87dd-9f0206a623b3', '3f51eeca-c941-4529-99f4-12a8cea8d07b', '2025-06-22T14:42:05.895287'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'cff45859-e165-4f2d-93bf-a0840641ec56', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'f12ad570-5072-4b94-a1bf-89760a6ccae3', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Feel free to contact me if you need further information. I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit.', 'microsoft', '4237009c-43b2-4a6b-8e35-c3f50658429e', 'e0054d5d-f230-43d1-8264-255f6db0c4e8', '2025-06-12T14:37:05.895343'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'f12ad570-5072-4b94-a1bf-89760a6ccae3', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '5a2c8cba-28f5-42f4-ae1a-646b899eda3b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. I hope this message finds you well. I appreciate your help with this matter.', 'microsoft', '73637c65-cb0d-40d5-987d-8c6373c0a24d', '4bbed96a-c590-4ffc-aaf2-47b66a5b03c3', '2025-06-24T09:48:05.895378'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '5a2c8cba-28f5-42f4-ae1a-646b899eda3b', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ab0b5f91-5c12-42e1-8a2f-3d96ae34abe4', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Feel free to contact me if you need further information. I hope this message finds you well.', 'microsoft', 'ccc33930-6b3e-4409-9176-171285215b15', '3a11791d-34ab-4886-a2d5-170e94e040f8', '2025-06-10T15:49:05.895442'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ab0b5f91-5c12-42e1-8a2f-3d96ae34abe4', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'a7d0e690-a60e-4560-b5e4-8bd74f42102e', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I appreciate your help with this matter. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '4858fe7d-26cc-4416-9089-ecfd9884dda3', 'f391b6f2-0d5a-4860-a583-3ae11effaa61', '2025-07-01T08:46:05.895526'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'a7d0e690-a60e-4560-b5e4-8bd74f42102e', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '86fe6261-7610-461a-9ffe-a9794dda048a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Looking forward to your prompt response. Thank you for your time and assistance. I hope this message finds you well. Could you please provide me with an update on the current status?', 'microsoft', '0f7552c5-2171-4d03-8b3e-c4a0930a2e8d', '51051b85-0485-42fd-9314-34ac54092ece', '2025-06-30T04:32:05.895925'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '86fe6261-7610-461a-9ffe-a9794dda048a', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ef40bdba-5e87-429c-8177-a421979d40f4', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. I am reaching out regarding my financial aid application.', 'microsoft', '3021228e-15ea-4a2a-9fdd-bd0515f5a785', '9582b799-7ec4-43b1-9b7c-511218f9b2b0', '2025-06-13T08:01:05.896025'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ef40bdba-5e87-429c-8177-a421979d40f4', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1eff6aa1-d96c-4804-8b93-fabfed4672dd', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I hope this message finds you well. I appreciate your help with this matter. Looking forward to your prompt response. Feel free to contact me if you need further information.', 'microsoft', 'd7ffc8cf-70d3-4665-beaa-5d4b60f37239', '1b87395c-dec9-4fd8-94ae-e1d587a5f625', '2025-06-23T14:01:05.896126'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1eff6aa1-d96c-4804-8b93-fabfed4672dd', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'b64e10e8-212e-4a78-89f2-b8f94a5fe38d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Thank you for your time and assistance. Feel free to contact me if you need further information. Looking forward to your prompt response.', 'microsoft', '4fe297bc-ad83-42f4-8a72-be5c0ad2208d', '76a98105-8bea-475b-b011-3434ed1a155d', '2025-06-28T00:06:05.896201'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'b64e10e8-212e-4a78-89f2-b8f94a5fe38d', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ac666a2f-5735-4891-aece-2ad5d9f706da', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I am reaching out regarding my financial aid application. Could you please provide me with an update on the current status? Thank you for your time and assistance.', 'microsoft', '087d18f6-a26b-4525-bebc-e0fd84444538', 'be0c5c70-4267-4a21-8ff9-8b0f339a6eaa', '2025-06-27T21:23:05.896298'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ac666a2f-5735-4891-aece-2ad5d9f706da', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '94f5909e-1e71-4212-946d-55cb2d10c0ae', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit. Could you please provide me with an update on the current status? Thank you for your time and assistance.', 'microsoft', 'fe090e07-30ed-49e7-9688-2a128ce99889', '32da647c-5199-4ec0-853d-8a53f305e0b5', '2025-07-01T05:38:05.896362'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '94f5909e-1e71-4212-946d-55cb2d10c0ae', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'eb096c88-ea75-4eb7-a2ae-1912eb816005', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Feel free to contact me if you need further information. Thank you for your time and assistance. I appreciate your help with this matter. Could you please provide me with an update on the current status?', 'microsoft', '2f474d63-a783-4656-af10-4868d8a336c8', '6fd32e99-cddc-48c8-90da-a95618494d42', '2025-06-21T03:14:05.896417'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'eb096c88-ea75-4eb7-a2ae-1912eb816005', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '56e4a381-1e66-42cf-aa03-db8bbf41f200', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance. Could you please provide me with an update on the current status?', 'microsoft', 'f454620f-cd1e-4e8e-ab9e-2fb16c52a9c6', '6de4868c-cc84-4f52-a006-ae7146f82f0f', '2025-06-10T16:15:05.896490'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '56e4a381-1e66-42cf-aa03-db8bbf41f200', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '926a71f2-7d70-4fd4-b5ef-a11b9f4e51a1', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Could you please provide me with an update on the current status? Please let me know if there are any additional documents I need to submit. I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', 'b07d25ad-f33a-483e-b701-be1ef796a66a', '390b77e0-2143-4baa-9357-9f51307c56d0', '2025-06-17T23:20:05.896531'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '926a71f2-7d70-4fd4-b5ef-a11b9f4e51a1', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'f5bede58-6898-4d5a-8008-c704e7e46990', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Thank you for your time and assistance. I appreciate your help with this matter. Could you please provide me with an update on the current status? I hope this message finds you well.', 'microsoft', '518d330f-6852-48b1-b6dc-7af9f12f1a33', '2018438d-263e-48a6-b7cf-ecbc209c2c5b', '2025-06-20T16:02:05.896587'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'f5bede58-6898-4d5a-8008-c704e7e46990', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '623ea1ab-63ea-4518-9c14-dc38767ef3a5', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I am reaching out regarding my financial aid application. Could you please provide me with an update on the current status? Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance.', 'microsoft', 'bca0e938-05f6-4679-830d-1fb7f296aa87', '06cae338-bd95-445c-a6f2-e1698f6b6c5e', '2025-06-19T23:03:05.897194'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '623ea1ab-63ea-4518-9c14-dc38767ef3a5', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '30bca1e2-3f28-48e1-8d01-22b085114be5', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. I appreciate your help with this matter. Thank you for your time and assistance. I hope this message finds you well.', 'microsoft', '94519684-43ab-4e11-8d37-56ff3604541d', '64994127-93aa-44df-8d69-6b21d493c311', '2025-06-17T22:55:05.897264'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '30bca1e2-3f28-48e1-8d01-22b085114be5', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'd8fd28f5-5088-4847-ba2d-60cdaeabf3a5', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I appreciate your help with this matter. I am reaching out regarding my financial aid application. Could you please provide me with an update on the current status? I hope this message finds you well.', 'microsoft', '41cc6397-4940-402b-83c6-f97dd628ab03', 'd355a92a-14a7-4cca-9aa7-a941c21a8009', '2025-06-13T13:54:05.897596'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'd8fd28f5-5088-4847-ba2d-60cdaeabf3a5', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '4a400eaf-2a19-4efd-9390-7e4c05030ca3', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Could you please provide me with an update on the current status? I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', 'c741f6dc-126f-4329-86d4-c663ef032260', '14cdbca4-73f3-4a35-9618-7f68547810e1', '2025-06-11T01:49:05.898130'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '4a400eaf-2a19-4efd-9390-7e4c05030ca3', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '0242802d-2214-4815-be16-3182ffc7b3b1', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. Could you please provide me with an update on the current status? Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit.', 'microsoft', '3657c196-26bb-4fbd-9a99-0a2c4486b365', 'd8c99e28-1028-429b-ac64-dd515f498e18', '2025-06-15T12:20:05.898265'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '0242802d-2214-4815-be16-3182ffc7b3b1', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'c40fda45-8333-41cd-8b78-833526e7590d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I hope this message finds you well. Thank you for your time and assistance. Could you please provide me with an update on the current status? Feel free to contact me if you need further information.', 'microsoft', 'd1911a8c-9bbd-420a-bcd8-8dcf34fca1a3', '0aad5c79-97c6-449f-9065-647c45dd3a64', '2025-06-17T13:29:05.898343'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'c40fda45-8333-41cd-8b78-833526e7590d', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'f3c0f964-178a-4728-937d-86d3f26e2d0b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter. I hope this message finds you well.', 'microsoft', 'fac40b84-31a7-4c96-8dc4-d6de9b35b862', 'e7f8a4ec-1fc0-4efa-a37a-2e8419bffab1', '2025-06-12T12:20:05.898396'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'f3c0f964-178a-4728-937d-86d3f26e2d0b', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '488a315d-478d-4ad0-a14c-6cb2a5bbf199', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Could you please provide me with an update on the current status? I hope this message finds you well.', 'microsoft', 'd83aed08-5de8-4bc7-bd46-032524667e77', 'd4ebf23e-09c7-4abb-8886-2c2ce956d560', '2025-06-10T23:39:05.898471'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '488a315d-478d-4ad0-a14c-6cb2a5bbf199', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1ec4783d-ce87-46b1-8a23-ebbc3e461cb9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Feel free to contact me if you need further information. I appreciate your help with this matter. I hope this message finds you well.', 'microsoft', 'c125c6ea-751a-4baa-add9-a54d6de4361a', '39bdadb0-4959-4c53-821d-ebb1df8df8fe', '2025-06-28T01:00:05.898536'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1ec4783d-ce87-46b1-8a23-ebbc3e461cb9', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '26f507bc-bbed-45fa-a37a-0a222a821871', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I hope this message finds you well. I am reaching out regarding my financial aid application. I appreciate your help with this matter.', 'microsoft', 'f1091a50-9b08-43ad-a41e-74aba5e5e355', '269a2a0d-f6bb-45eb-9a07-b447e94b3a95', '2025-06-10T15:28:05.898744'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '26f507bc-bbed-45fa-a37a-0a222a821871', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '7aeb1790-89f6-4545-920b-7912eba8c824', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I am reaching out regarding my financial aid application. Thank you for your time and assistance. Feel free to contact me if you need further information. Looking forward to your prompt response.', 'microsoft', '61b6aa4f-6be2-44be-b6e9-47886bfbb458', '2d947bdb-fa3b-4d2c-ac71-6064620691b6', '2025-06-25T09:19:05.898816'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '7aeb1790-89f6-4545-920b-7912eba8c824', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '830001d9-4eb7-48ff-b13c-f03989ba063d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Please let me know if there are any additional documents I need to submit. I hope this message finds you well. I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', '47f50f00-e050-4aa3-9146-5e990549b573', 'c23ea20e-0aaa-4af4-8d5c-0357470802d3', '2025-06-20T13:42:05.898919'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '830001d9-4eb7-48ff-b13c-f03989ba063d', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'afd4e632-8067-4fd3-b2af-a993e9c13535', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I hope this message finds you well. Please let me know if there are any additional documents I need to submit. I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', 'f8682b8f-f010-4edb-ba64-97f306d7b05f', 'ad47f55f-e47c-4883-908e-cfc3138c27a5', '2025-06-10T17:38:05.899211'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'afd4e632-8067-4fd3-b2af-a993e9c13535', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '663287c0-c6a6-4662-98a8-72afef848cbb', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Please let me know if there are any additional documents I need to submit. Feel free to contact me if you need further information. I appreciate your help with this matter.', 'microsoft', 'ba715fcf-1e0e-4026-95ff-1e2fcb16e4de', '9977443a-8712-4d38-8286-53e92639b4ed', '2025-06-11T02:16:05.899308'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '663287c0-c6a6-4662-98a8-72afef848cbb', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'd2a16996-646e-4034-ac0b-c9fc19f893a2', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I appreciate your help with this matter. Looking forward to your prompt response. Thank you for your time and assistance.', 'microsoft', 'c66e1a3f-7295-420e-8004-f586588fd0d4', '8f414afa-7502-466d-be53-dc7a07184f83', '2025-06-25T04:59:05.899402'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'd2a16996-646e-4034-ac0b-c9fc19f893a2', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '97c9ce44-5b94-4dd2-aa37-fe809568e529', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I appreciate your help with this matter. Could you please provide me with an update on the current status? Feel free to contact me if you need further information.', 'microsoft', 'cebb7bf8-6616-4333-8709-d1129dec7d0f', 'b1b426c9-10b0-45c5-ac3b-7b42f6b5ae59', '2025-06-16T07:26:05.899458'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '97c9ce44-5b94-4dd2-aa37-fe809568e529', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ff377e79-f201-4379-992f-e96ddb0d8d10', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. Thank you for your time and assistance. I hope this message finds you well. Please let me know if there are any additional documents I need to submit.', 'microsoft', '2b2aa46e-7710-48e3-8740-14bb3cc034b7', 'c942672b-6ad5-4d99-9426-f50442291b1b', '2025-07-01T06:16:05.899502'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ff377e79-f201-4379-992f-e96ddb0d8d10', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '8eee71d1-8517-441a-b176-9c6ae0cc2803', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. I hope this message finds you well. Thank you for your time and assistance.', 'microsoft', '313e241b-6e2e-4ac5-9e53-535bb42ec996', 'bf414ea9-b770-4f15-803c-6ea92757d3d7', '2025-06-23T13:29:05.899550'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '8eee71d1-8517-441a-b176-9c6ae0cc2803', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '7adde74b-fd60-4388-9802-0021a8aefbb3', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Could you please provide me with an update on the current status? Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit.', 'microsoft', '5b99f6e0-f3a9-4c58-8f79-8f574d0cb463', '9f08bfd3-e9bf-429a-922b-7a8a1fe1d080', '2025-06-23T13:56:05.899744'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '7adde74b-fd60-4388-9802-0021a8aefbb3', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '561a03dd-b3f5-4790-be5e-de2551b502c0', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. I appreciate your help with this matter.', 'microsoft', '5e2ea757-80c5-498c-9656-38369745a35b', '2720ae55-61a4-4428-9fbd-6bce8ee23fdd', '2025-06-26T20:14:05.899817'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '561a03dd-b3f5-4790-be5e-de2551b502c0', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '331004d2-6d44-4054-9e1f-e0752f8576bd', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. Thank you for your time and assistance. Could you please provide me with an update on the current status? Feel free to contact me if you need further information.', 'microsoft', '05d837c2-5f9e-4de3-980f-2793aecdb126', '1a663b90-1088-4c29-8f01-33186122a086', '2025-06-19T15:46:05.899872'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '331004d2-6d44-4054-9e1f-e0752f8576bd', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '899e5fc0-0f93-48bd-9544-458b1ef9b908', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I appreciate your help with this matter. Feel free to contact me if you need further information. I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit.', 'microsoft', '9b8b0af9-50bf-4573-98e8-317462a9da66', '4ecaa076-e35c-4060-8b3e-dce16db2f406', '2025-06-30T06:53:05.899906'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '899e5fc0-0f93-48bd-9544-458b1ef9b908', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '29229093-5c09-4545-badc-07c32dfcd869', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I am reaching out regarding my financial aid application. Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter.', 'microsoft', 'b1a8d4fe-defe-4be5-a78c-279a8985f410', 'ece87393-d387-4913-9cbf-f4304053d19a', '2025-06-19T10:34:05.899972'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '29229093-5c09-4545-badc-07c32dfcd869', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '15242a17-f84e-42bc-b75d-efb48a709b36', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. I hope this message finds you well. Feel free to contact me if you need further information.', 'microsoft', 'c2a1bd24-98b2-4c50-ace3-f4c6ef76a776', 'd13859f3-e72b-453e-96e8-ce1f886c295c', '2025-06-13T00:29:05.900043'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '15242a17-f84e-42bc-b75d-efb48a709b36', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'b76dfc13-e5ba-4d1c-9fc0-284c150bde05', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Looking forward to your prompt response. I appreciate your help with this matter. Feel free to contact me if you need further information. Please let me know if there are any additional documents I need to submit.', 'microsoft', '8cac9864-3741-4426-8d12-7b58a85605c0', '5674395d-333a-46be-a205-d0bd06f77809', '2025-06-11T21:58:05.900443'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'b76dfc13-e5ba-4d1c-9fc0-284c150bde05', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '38be4f3a-0771-47fe-ab36-f1af8d891bdd', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Looking forward to your prompt response. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '102598a4-21f2-4859-b8e2-02a2665e488c', '64b97d83-32bd-4c37-a543-123001596c66', '2025-06-12T08:10:05.900518'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '38be4f3a-0771-47fe-ab36-f1af8d891bdd', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2d9caa18-fad0-4ac5-b3f7-c7ffc3ee3f55', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Thank you for your time and assistance. Could you please provide me with an update on the current status? Please let me know if there are any additional documents I need to submit.', 'microsoft', '99f149e4-6b5c-44c1-93e3-00e2f9602785', 'fb7be08f-7bd4-4da0-8b48-a00dc0847ad2', '2025-06-21T11:13:05.900553'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2d9caa18-fad0-4ac5-b3f7-c7ffc3ee3f55', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '96136def-70af-41c6-9bf4-ca1f4ebf3974', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit. Could you please provide me with an update on the current status?', 'microsoft', '3454f34d-6076-458d-bcd6-dfc9206f0992', '5c565189-1ba7-408e-9d75-430f4845af66', '2025-06-23T14:11:05.900685'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '96136def-70af-41c6-9bf4-ca1f4ebf3974', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '62a6c108-357e-40c3-84bf-142dca631a6d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.davis52@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Feel free to contact me if you need further information. Thank you for your time and assistance. Looking forward to your prompt response.', 'microsoft', '7ed0ce51-befd-49e5-ab16-6fdb7c4b02fa', '2ae59810-63b1-4ef1-8724-ef4d4fb64f57', '2025-06-21T04:39:05.900771'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '62a6c108-357e-40c3-84bf-142dca631a6d', '71f26f96-af68-4a9a-89c3-1186c2bed0e6'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '4907bfba-3710-42a6-b79d-638b6dd2ee24', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. I am reaching out regarding my financial aid application. I hope this message finds you well.', 'microsoft', '6b62e391-1b7c-4063-8161-b3b4062f6872', '6d891d94-b1b1-4899-a6d0-cf2e05ce1c09', '2025-06-19T12:02:05.900824'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '4907bfba-3710-42a6-b79d-638b6dd2ee24', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'f7d20f06-ce30-4ba7-85d6-0783c4dc2d5a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. I appreciate your help with this matter. I hope this message finds you well.', 'microsoft', '4a0c8a4b-79cf-4d4f-b276-dbcddceca157', 'd4788679-7f50-4c39-b104-23dc92aca84a', '2025-06-28T01:39:05.900892'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'f7d20f06-ce30-4ba7-85d6-0783c4dc2d5a', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '8de4a6f5-3c03-425e-8cb2-34c02ea77596', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.davis52@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Looking forward to your prompt response. I hope this message finds you well. Could you please provide me with an update on the current status? I appreciate your help with this matter.', 'microsoft', '3939c70f-53fb-4fbb-ac49-6dea90c0240d', 'b093b0f7-65da-44f0-b404-723a4307e78f', '2025-06-16T12:38:05.900945'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '8de4a6f5-3c03-425e-8cb2-34c02ea77596', '71f26f96-af68-4a9a-89c3-1186c2bed0e6'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ec16a318-b2de-4cb2-95fd-48984303afed', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I am reaching out regarding my financial aid application. I hope this message finds you well. I appreciate your help with this matter. Could you please provide me with an update on the current status?', 'microsoft', '78c962d3-9b0d-4caf-8c04-a1e9c28839d7', '8426e9e4-a5c5-42c5-b7a2-9c2e07189194', '2025-06-23T12:12:05.901021'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ec16a318-b2de-4cb2-95fd-48984303afed', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '4323b74f-7ab6-48ea-8c59-40bb69d77474', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. I hope this message finds you well.', 'microsoft', '5b6ddcc9-288c-4d8f-b48e-9e71e1d4c615', '3504e198-cdb0-42e4-b767-e917c0ba4a55', '2025-06-17T04:21:05.901057'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '4323b74f-7ab6-48ea-8c59-40bb69d77474', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'aa88377b-9c90-4462-a2f7-ba242a91b1d5', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. I hope this message finds you well. Feel free to contact me if you need further information.', 'microsoft', 'a46effe4-277e-4191-92d5-916334c4721d', 'e5bc5357-a822-4d10-8b6d-0e23b88e25a2', '2025-06-20T17:00:05.901096'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'aa88377b-9c90-4462-a2f7-ba242a91b1d5', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '561d1037-8699-40df-87c1-79348973b18a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. I hope this message finds you well. Thank you for your time and assistance. I am reaching out regarding my financial aid application.', 'microsoft', '5bdae544-dc84-4ac0-b880-313cdd9cac01', 'db0b97e8-67cf-4fae-980e-7c1d04ffec65', '2025-06-17T06:53:05.901492'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '561d1037-8699-40df-87c1-79348973b18a', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'a5b3b301-3235-433a-9b61-01a0a1cbae39', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Thank you for your time and assistance. I hope this message finds you well. Looking forward to your prompt response.', 'microsoft', 'a648022d-cc8d-4c6b-a7c3-391c6d8d846f', 'c7051fcc-5044-4607-99c2-185c4a321692', '2025-06-30T17:22:05.901782'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'a5b3b301-3235-433a-9b61-01a0a1cbae39', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '46bf6049-074f-4a92-af32-c405165f7ae8', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. I hope this message finds you well. Could you please provide me with an update on the current status?', 'microsoft', '8c5a30bb-34f5-4dbe-9ce7-7c629760ebf2', '5b4e5e46-14d2-4319-80e0-5b465eb96e74', '2025-06-21T18:12:05.901883'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '46bf6049-074f-4a92-af32-c405165f7ae8', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '4e23e999-3ba4-4ef3-ba93-ef4ab15fb2da', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.davis52@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Could you please provide me with an update on the current status? I hope this message finds you well.', 'microsoft', 'f5b669e8-8041-4eca-8e08-2dce747ba5d1', 'cf66cc74-679c-4108-b7fd-ae0e80e87566', '2025-07-01T13:27:05.901949'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '4e23e999-3ba4-4ef3-ba93-ef4ab15fb2da', '71f26f96-af68-4a9a-89c3-1186c2bed0e6'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1545a7e9-e843-4843-aa0c-03c568a0722c', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Looking forward to your prompt response. I appreciate your help with this matter. Thank you for your time and assistance. I am reaching out regarding my financial aid application.', 'microsoft', '9d3a9f18-5708-4751-bc6f-f3dcfc73923e', 'ce425ed0-1f4d-4dfe-990f-155daff3fd33', '2025-06-27T03:28:05.902222'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1545a7e9-e843-4843-aa0c-03c568a0722c', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '19ae249d-da5f-41ac-885c-21532e55261d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. Looking forward to your prompt response. I am reaching out regarding my financial aid application. I appreciate your help with this matter.', 'microsoft', '6a4e1e7b-be76-46d4-b4a6-36e6f0b30f48', '50cca010-e954-4584-8039-e0a6c8ef2b52', '2025-06-26T22:29:05.902593'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '19ae249d-da5f-41ac-885c-21532e55261d', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'c23d8b7f-7aaa-49c5-92c9-c6cced2711f8', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Thank you for your time and assistance. I am reaching out regarding my financial aid application. I hope this message finds you well. Looking forward to your prompt response.', 'microsoft', '00fbef63-fe87-4270-ac1d-e030d4883005', '971d485a-55cc-4572-8fc4-757f2618746b', '2025-06-18T19:35:05.902798'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'c23d8b7f-7aaa-49c5-92c9-c6cced2711f8', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1edf6ad1-986e-4345-ad64-73936e45a6f9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. Thank you for your time and assistance. Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit.', 'microsoft', '6c39ca23-f9d4-4e7b-bc3b-49d939856178', 'c73a3c84-8936-49fc-806c-bcea7835bdfe', '2025-06-11T02:18:05.902876'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1edf6ad1-986e-4345-ad64-73936e45a6f9', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '517db238-ce54-4580-94df-06e66091321d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Feel free to contact me if you need further information. Thank you for your time and assistance. I appreciate your help with this matter. Looking forward to your prompt response.', 'microsoft', '298ae7f8-60f0-4c14-999f-cd40d4010d17', '782cf967-4d88-4002-9e4e-34904afbe677', '2025-06-26T10:17:05.902915'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '517db238-ce54-4580-94df-06e66091321d', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '005dcbf6-f601-443d-83f4-c286b0493d75', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Feel free to contact me if you need further information. I am reaching out regarding my financial aid application. Could you please provide me with an update on the current status? Looking forward to your prompt response.', 'microsoft', '109bfe47-94c3-45d6-9634-50ff4acb8e63', 'f15f16a7-9db9-499b-8196-357f6c1ba883', '2025-06-16T09:25:05.902958'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '005dcbf6-f601-443d-83f4-c286b0493d75', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '249a83c1-a3d2-46bc-ac1b-cd948131366c', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Thank you for your time and assistance. Feel free to contact me if you need further information. I hope this message finds you well. Could you please provide me with an update on the current status?', 'microsoft', '21da52df-fb70-4b3f-aa8f-9813f984a103', 'cf24217d-013f-4027-a97d-2113cea23e95', '2025-06-29T09:11:05.903199'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '249a83c1-a3d2-46bc-ac1b-cd948131366c', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '563e2f76-6537-40c9-bdb6-5edeaf4f886e', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Could you please provide me with an update on the current status? I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', '3941b83d-55d3-465f-8688-4297922dffe1', 'acb5f5b7-fda1-4194-bf21-80704304dac1', '2025-06-30T06:15:05.903297'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '563e2f76-6537-40c9-bdb6-5edeaf4f886e', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1a45cfc6-f464-41e6-9a12-ec80991839e2', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. Thank you for your time and assistance.', 'microsoft', '90946821-8be3-425e-a649-b5ea6eb3dd22', '94125995-7179-4798-a743-f5eca720c150', '2025-06-12T19:36:05.903396'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1a45cfc6-f464-41e6-9a12-ec80991839e2', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '77fe0d54-5fda-4eac-b3bf-18d1afc2d5f7', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Looking forward to your prompt response. I hope this message finds you well. I appreciate your help with this matter.', 'microsoft', '73535457-4d66-467d-bd78-93395c1f6513', '9fd7a484-a2be-4f9d-8df6-28971598988b', '2025-06-12T03:24:05.903476'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '77fe0d54-5fda-4eac-b3bf-18d1afc2d5f7', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2f3b553d-a5f1-4479-bf78-a43047bcc6a3', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I hope this message finds you well. Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance.', 'microsoft', 'f75a5d53-6805-465d-a0a4-b55f51592025', '12768f4c-d4a6-4f1e-9537-bf1a5916cdfd', '2025-06-15T05:16:05.903539'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2f3b553d-a5f1-4479-bf78-a43047bcc6a3', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e3125f0f-bfdd-4d9a-a091-9ec33bfff59a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Could you please provide me with an update on the current status? Thank you for your time and assistance. I appreciate your help with this matter. Please let me know if there are any additional documents I need to submit.', 'microsoft', 'b68fce9f-4212-47cc-8f83-6e15eeec45fb', 'ac680ae3-8581-4ef0-9059-e06310e874c2', '2025-06-29T08:17:05.903606'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e3125f0f-bfdd-4d9a-a091-9ec33bfff59a', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'cebc0b30-0adb-443a-a9d4-432f70a94122', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I hope this message finds you well. Thank you for your time and assistance. Feel free to contact me if you need further information.', 'microsoft', '452b4892-6ea3-453c-9a1b-251120a89491', '0601a8c4-f824-444c-b45b-1cac2e4c6cf5', '2025-06-24T18:32:05.903676'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'cebc0b30-0adb-443a-a9d4-432f70a94122', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e32c83e9-379f-45de-ba98-be4375f0dc92', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter. I am reaching out regarding my financial aid application.', 'microsoft', 'c2665a6e-1268-4fa7-b174-9f45be60ddc9', '0272a707-47db-4660-9777-d8b86977cccb', '2025-06-23T13:46:05.903760'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e32c83e9-379f-45de-ba98-be4375f0dc92', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'dbc52561-0c55-4b2e-8d92-cc12547f886a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. Feel free to contact me if you need further information.', 'microsoft', 'd5339542-df8f-4c75-b480-d0524f51a6d2', '771fed9a-410a-4258-a0d3-1394680090b4', '2025-06-29T12:33:05.904193'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'dbc52561-0c55-4b2e-8d92-cc12547f886a', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e16d3b95-961f-4f1a-bdd4-8692b12cab02', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Could you please provide me with an update on the current status? I appreciate your help with this matter. I hope this message finds you well.', 'microsoft', '5070c870-3c0d-42e4-baa4-848991184c5e', '5b552727-3040-4e80-a4d7-8d69558034b6', '2025-06-11T08:02:05.904449'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e16d3b95-961f-4f1a-bdd4-8692b12cab02', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2630cdbd-5a3c-4e5d-ac15-b1c52bb36501', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter.', 'microsoft', '8f12b235-bcfd-49f2-b416-69294a776266', '9504a44c-c29a-4e15-8917-5d7c2016a22d', '2025-06-14T17:37:05.904514'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2630cdbd-5a3c-4e5d-ac15-b1c52bb36501', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e95944f9-9b50-41ab-b410-fe2bba132df0', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Could you please provide me with an update on the current status? I am reaching out regarding my financial aid application. Thank you for your time and assistance.', 'microsoft', '49c0dd71-8fea-406b-9fc2-730b3c5de8db', '44e3d977-971b-4367-8bf4-67e1e9925549', '2025-06-26T16:49:05.904559'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e95944f9-9b50-41ab-b410-fe2bba132df0', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e0a4bd53-b795-46c8-a99e-9c61e15158a9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. I hope this message finds you well. Thank you for your time and assistance.', 'microsoft', 'd1acd726-3742-4ddc-b3df-b41a1bc287f5', 'fe00cbea-fc1b-493d-98a1-5dbc325adbd2', '2025-06-23T08:17:05.904625'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e0a4bd53-b795-46c8-a99e-9c61e15158a9', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'bc45e22f-0c67-4b6a-b11f-fc31d2d92c02', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I appreciate your help with this matter. Feel free to contact me if you need further information. Thank you for your time and assistance.', 'microsoft', 'bd2d06d7-3608-432f-9b46-1342e1ea68e4', '287fb739-41f4-4726-b99e-5ea43315728c', '2025-06-19T06:43:05.904660'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'bc45e22f-0c67-4b6a-b11f-fc31d2d92c02', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2d2c44a9-82fe-44d3-bf70-2c17b47d04a8', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Feel free to contact me if you need further information. Looking forward to your prompt response. Could you please provide me with an update on the current status? Please let me know if there are any additional documents I need to submit.', 'microsoft', 'a9691ae6-8a30-4bc9-9d1c-1f4aab37407c', 'bdb7178c-0546-4313-befb-468a5578558b', '2025-06-30T03:35:05.904693'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2d2c44a9-82fe-44d3-bf70-2c17b47d04a8', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ed7a37a6-d0c8-41ad-9ec6-fbd753403f40', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I hope this message finds you well. Thank you for your time and assistance. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '27737e20-f8d2-4e40-91b3-1e1891f25bb1', '8209d924-0c9a-4ab3-9b8b-13686949d1d8', '2025-06-23T05:31:05.904728'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ed7a37a6-d0c8-41ad-9ec6-fbd753403f40', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'a66ea1ff-704e-4af8-b43c-686a19dbe799', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I hope this message finds you well. Looking forward to your prompt response. I appreciate your help with this matter.', 'microsoft', '0250ee11-3bff-43c8-a144-6265191e3b6b', '4febd48e-65ec-4740-acb2-3d77bd444ee6', '2025-06-18T10:30:05.904773'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'a66ea1ff-704e-4af8-b43c-686a19dbe799', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '506d6285-6f02-4629-bb89-e794a14e8bf0', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter. Feel free to contact me if you need further information.', 'microsoft', '1e92c931-c0cb-45d4-9b8c-477bba13f75c', '34688e72-feb4-4778-a01e-74c6a812ec1e', '2025-06-23T00:55:05.904804'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '506d6285-6f02-4629-bb89-e794a14e8bf0', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '604f2ed5-9be2-4c1d-8671-0061f1d3bd67', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Thank you for your time and assistance. Feel free to contact me if you need further information. Looking forward to your prompt response. I am reaching out regarding my financial aid application.', 'microsoft', '37c63180-dc7d-4fcf-aac6-01043ef43523', 'ee03cfa0-b307-44c8-b12c-abfd515182a6', '2025-06-14T04:23:05.904955'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '604f2ed5-9be2-4c1d-8671-0061f1d3bd67', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'b6038582-8b5d-4d24-9cea-7d0cf8fbde9f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.davis52@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I hope this message finds you well. Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. Could you please provide me with an update on the current status?', 'microsoft', '86f6ab42-c762-437b-a67a-d0925cdac4b1', '84dfe01d-7bd3-4fd3-9fde-9947df434ebe', '2025-06-29T23:31:05.905041'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'b6038582-8b5d-4d24-9cea-7d0cf8fbde9f', '71f26f96-af68-4a9a-89c3-1186c2bed0e6'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '87c7774a-a07f-492d-94dd-7c0d7bb065c9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I hope this message finds you well. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter.', 'microsoft', 'f6193693-6e18-4d98-aca8-c93e95b992ca', '6baca7e2-4ea2-4054-bdb2-1474e24de292', '2025-06-18T08:08:05.905083'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '87c7774a-a07f-492d-94dd-7c0d7bb065c9', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e2da47ef-6f06-4228-b019-f28be81683f9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Please let me know if there are any additional documents I need to submit. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '5cd7f1ea-093f-422d-8a85-bb562da78612', '6863a1b0-1764-4242-a0b5-b23c0f6ad022', '2025-06-13T13:40:05.905116'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e2da47ef-6f06-4228-b019-f28be81683f9', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '95e430c1-7200-4872-8af8-9bb42d4125ed', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Thank you for your time and assistance. I am reaching out regarding my financial aid application. I appreciate your help with this matter.', 'microsoft', '36f8a8fe-f761-4e25-8daf-a321d6ddfb90', '4538b047-4827-4fb9-8373-b0d4a818e9c6', '2025-06-13T19:42:05.905155'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '95e430c1-7200-4872-8af8-9bb42d4125ed', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e05708ca-74a5-426e-8032-f88fb1416bd9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Thank you for your time and assistance. I hope this message finds you well. Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit.', 'microsoft', '394c9963-054e-4199-8ea0-6e41fadcb275', 'ec657a25-07dc-4a57-a2b0-e582e1491920', '2025-06-12T08:45:05.905187'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e05708ca-74a5-426e-8032-f88fb1416bd9', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '220cfb8d-2488-476e-a8da-a71af9caa20d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Please let me know if there are any additional documents I need to submit. Feel free to contact me if you need further information. I appreciate your help with this matter.', 'microsoft', 'a8d2959e-529a-4126-ba0c-8509bf99c93e', '1cbdb8af-2454-448e-8e05-8eb713e51f82', '2025-07-01T07:38:05.905217'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '220cfb8d-2488-476e-a8da-a71af9caa20d', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '265927b4-1890-4ed0-87e7-30f57fd20a96', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Feel free to contact me if you need further information. I hope this message finds you well. I appreciate your help with this matter. Thank you for your time and assistance.', 'microsoft', '805eca1f-862e-4d68-a229-2e9f6a13e023', '8fa494d5-d87b-43e1-895e-8324d22543e1', '2025-06-22T03:23:05.905247'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '265927b4-1890-4ed0-87e7-30f57fd20a96', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '7abcfa10-cbfc-4e77-a89c-0ae70c8ea1a6', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter.', 'microsoft', '826b40c1-dc97-465a-8a64-25b69fcea9b4', '17dbcc3d-1301-4266-ae88-9c2b22e8a9b1', '2025-06-23T06:40:05.905278'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '7abcfa10-cbfc-4e77-a89c-0ae70c8ea1a6', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'a2a3cae8-6cea-4143-8826-7867cf0b4a7b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Thank you for your time and assistance. I appreciate your help with this matter. I am reaching out regarding my financial aid application. I hope this message finds you well.', 'microsoft', '48af8e7b-d0e1-4e8d-a71f-e78655fba978', '92c780ee-038d-4379-8e8b-5a1aaf2de6aa', '2025-06-15T15:36:05.905354'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'a2a3cae8-6cea-4143-8826-7867cf0b4a7b', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '063b591a-fb1e-4f9c-ba94-c7ee5a7fc259', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Thank you for your time and assistance. Could you please provide me with an update on the current status? I am reaching out regarding my financial aid application. I hope this message finds you well.', 'microsoft', 'b8d3e860-b9df-42c5-88ff-ca384604a2f8', '86aab0ef-74cf-408e-b942-2339a3b19c8e', '2025-06-15T19:34:05.905387'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '063b591a-fb1e-4f9c-ba94-c7ee5a7fc259', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ee900590-578d-4dde-9814-24a11b380af9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Could you please provide me with an update on the current status? Feel free to contact me if you need further information. Looking forward to your prompt response.', 'microsoft', '35b548ff-01b1-4ff2-bc0d-b883a3f461a8', '69d31444-0d62-46a8-bbfe-43a05b9d19c4', '2025-06-19T11:59:05.905418'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ee900590-578d-4dde-9814-24a11b380af9', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '57964835-9e27-4c68-a191-b4af9365f91c', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance. I hope this message finds you well.', 'microsoft', 'dc806f5d-1112-4dc2-9021-e39790b35c60', 'b72145fc-9e0a-40ef-b22e-05709ecebc0a', '2025-06-16T12:47:05.905449'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '57964835-9e27-4c68-a191-b4af9365f91c', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'dd32204b-0212-4572-9f31-d9587c691299', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance. I hope this message finds you well.', 'microsoft', 'a3d1ba6c-3acf-4d44-8d26-376358e8aee8', '3ed24f6d-14a5-47af-87f7-65ed63d9dc64', '2025-06-27T05:56:05.905480'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'dd32204b-0212-4572-9f31-d9587c691299', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1bba2be6-62b3-46d6-8e4f-290cd02819af', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Looking forward to your prompt response. I appreciate your help with this matter. Thank you for your time and assistance.', 'microsoft', '04fc2c19-5721-4d95-b6b9-e86d4004b1d8', 'b6ae4219-abb3-48ec-b694-ea569795152d', '2025-06-26T23:20:05.905511'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1bba2be6-62b3-46d6-8e4f-290cd02819af', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2d2c0172-5983-41ed-9295-e4cbc0143d4f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Please let me know if there are any additional documents I need to submit. I hope this message finds you well. Looking forward to your prompt response. Feel free to contact me if you need further information.', 'microsoft', 'f4c5367d-1b8b-473a-a692-9b17177b0ad2', '4d91c1b7-3363-40e9-8b95-8dfc51424a77', '2025-06-29T05:44:05.905544'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2d2c0172-5983-41ed-9295-e4cbc0143d4f', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'afe178e8-857e-412d-8c93-f95c482c9b2b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Thank you for your time and assistance. I am reaching out regarding my financial aid application. I appreciate your help with this matter.', 'microsoft', '18cf98ba-4cb7-4ee0-b2a1-3749d568d4b9', '76a6b217-7aa8-4cd2-a06b-5a660c95a550', '2025-06-21T18:55:05.905576'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'afe178e8-857e-412d-8c93-f95c482c9b2b', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'aecef0ab-b65c-4a22-8d5c-4faa33726942', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Thank you for your time and assistance. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '823b44e9-6ca3-4050-9a45-1305b46c3a0f', '99ad4052-a220-4c44-988e-7fbdae1e159d', '2025-06-18T20:39:05.905607'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'aecef0ab-b65c-4a22-8d5c-4faa33726942', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);


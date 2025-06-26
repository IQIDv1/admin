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


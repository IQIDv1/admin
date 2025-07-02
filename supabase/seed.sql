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

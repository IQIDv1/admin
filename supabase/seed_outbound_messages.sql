-- Auto-generated seed for outbound messages, versions & activity

-- 1) Outbound messages
INSERT INTO public.organization_outbound_messages (
  id, organization_id, inbound_message_id, is_sent, sent_at
) VALUES
  (
    'd1d2d3d4-d5d6-4d7d-8d9d-e1e2e3e4e5f6',
    '55a9b012-8dba-48c6-9cc6-ec3b774287d9',
    '5737afb4-720d-4e4a-aebb-8c774a17303b',
    TRUE,
    '2025-07-07T09:00:00Z'
  ),
  (
    'd2d2d2d2-d2d2-4d2d-8d2d-e2e2e2e2e2f2',
    '55a9b012-8dba-48c6-9cc6-ec3b774287d9',
    '8b546d1b-8b03-4f9f-ae13-2702d3090ab8',
    FALSE,
    NULL
  ),
  (
    'd3d3d3d3-d3d3-4d3d-8d3d-e3e3e3e3e3f3',
    '55a9b012-8dba-48c6-9cc6-ec3b774287d9',
    '701365f0-bf57-4a4a-b34e-b97947c93864',
    TRUE,
    '2025-07-06T14:30:00Z'
  )
ON CONFLICT (id) DO NOTHING;


-- 2) Outbound message versions
INSERT INTO public.organization_outbound_message_versions (
  id, outbound_message_id, version, subject, body
) VALUES
  (
    'f1f2f3f4-f5f6-5f7f-9f8f-a1a2a3a4a5a6',
    'd1d2d3d4-d5d6-4d7d-8d9d-e1e2e3e4e5f6',
    1,
    'Re: Question about FAFSA',
    'Hello, we’ve received your FAFSA question, and our team is on it. We’ll follow up as soon as we have an update.'
  ),
  (
    'f2f2f2f2-f2f2-5f2f-9f2f-a2a2a2a2a2a2',
    'd2d2d2d2-d2d2-4d2d-8d2d-e2e2e2e2e2f2',
    1,
    'Re: Missing documents notification',
    'Thanks for flagging the missing documents. Please upload your tax transcript and verification form at your earliest convenience.'
  ),
  (
    'f3f3f3f3-f3f3-5f3f-9f3f-a3a3a3a3a3a3',
    'd3d3d3d3-d3d3-4d3d-8d3d-e3e3e3e3e3f3',
    1,
    'Re: Transcript upload confirmation',
    'Your transcript has been uploaded successfully. We will review and let you know if anything further is needed.'
  )
ON CONFLICT (id) DO NOTHING;


-- 3) Outbound messages activity (“copied”)
INSERT INTO public.organization_outbound_messages_activity (
  id, outbound_message_id, action, action_data
) VALUES
  (
    'c1c2c3c4-c5c6-4c7c-8c9c-c1c2c3c4c5c6',
    'd1d2d3d4-d5d6-4d7d-8d9d-e1e2e3e4e5f6',
    'copied',
    '{"outbound_version_id":"f1f2f3f4-f5f6-5f7f-9f8f-a1a2a3a4a5a6","version":1}'::jsonb
  ),
  (
    'c2c2c2c2-c2c2-4c2c-8c2c-c2c2c2c2c2c2',
    'd3d3d3d3-d3d3-4d3d-8d3d-e3e3e3e3e3f3',
    'copied',
    '{"outbound_version_id":"f3f3f3f3-f3f3-5f3f-9f3f-a3a3a3a3a3a3","version":1}'::jsonb
  )
ON CONFLICT (id) DO NOTHING;

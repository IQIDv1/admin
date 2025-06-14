-- 1) Drop the old embedding column from inbound messages
ALTER TABLE public.organization_inbound_messages
DROP COLUMN IF EXISTS embedding;

-- 2) Drop the vector index on that column
-- Replace the index name below with your actual index name if different
DROP INDEX IF EXISTS organization_inbound_messages_embedding_idx;

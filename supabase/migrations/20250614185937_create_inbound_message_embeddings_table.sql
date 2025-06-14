-- Create a dedicated table for chunk‐level embeddings of inbound messages
CREATE TABLE public.inbound_message_embeddings (
  id            uuid            NOT NULL DEFAULT gen_random_uuid(),
  message_id    uuid            NOT NULL REFERENCES public.organization_inbound_messages(id) ON DELETE CASCADE,
  chunk_index   integer         NOT NULL,
  embedding     vector(1536)    NOT NULL,
  created_at    timestamp with time zone NOT NULL DEFAULT now(),
  updated_at    timestamp with time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
);

-- Creates an IVFFlat index for approximate nearest‐neighbor lookups
CREATE INDEX ON public.inbound_message_embeddings
  USING ivfflat (embedding vector_cosine_ops)
  WITH (lists = 100);


-- Enable Row Level Security
ALTER TABLE public.inbound_message_embeddings
  ENABLE ROW LEVEL SECURITY;

-- Only allow selecting embeddings for messages in orgs the user belongs to
CREATE POLICY select_inbound_message_embeddings
  ON public.inbound_message_embeddings
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM public.organization_inbound_messages oim
      JOIN public.members m
        ON m.organization_id = oim.organization_id
      WHERE oim.id = inbound_message_embeddings.message_id
        AND m.id = auth.uid()
    )
  );

-- Only allow inserting embeddings for messages in orgs the user belongs to
CREATE POLICY insert_inbound_message_embeddings
  ON public.inbound_message_embeddings
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.organization_inbound_messages oim
      JOIN public.members m
        ON m.organization_id = oim.organization_id
      WHERE oim.id = inbound_message_embeddings.message_id
        AND m.id = auth.uid()
    )
  );

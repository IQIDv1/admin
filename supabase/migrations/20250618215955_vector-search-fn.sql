-- Create the match_inbound_embeddings function with support for multiple embeddings
CREATE OR REPLACE FUNCTION public.match_inbound_embeddings(
  query_embeddings vector[],
  match_count integer,
  org_id uuid
)
RETURNS TABLE (
  message_id uuid,
  similarity float
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    ime.message_id,
    MAX(1 - (ime.embedding <=> query_embedding)) AS similarity
  FROM
    unnest(query_embeddings) AS query_embedding
  CROSS JOIN
    public.inbound_message_embeddings ime
  INNER JOIN
    public.organization_inbound_messages oim
    ON ime.message_id = oim.id
  WHERE
    oim.organization_id = org_id
  GROUP BY
    ime.message_id
  ORDER BY
    similarity DESC
  LIMIT
    match_count;
END;
$$ LANGUAGE plpgsql;

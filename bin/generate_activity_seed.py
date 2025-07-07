import re
import uuid
import json

# Adjust these paths if needed
seed_inbound = "supabase/seed_inbound_messages.sql"
seed_activity = "supabase/seed_inbound_messages_activity.sql"

# Load the inbound messages seed
with open(seed_inbound) as f:
    content = f.read()

# Extract unique inbound_message IDs
inbound_ids = re.findall(
    r"INSERT INTO public\.organization_inbound_messages.*?VALUES\s*\(\s*'([0-9a-f\\-]+)'",
    content, flags=re.DOTALL
)
seen = set()
inbound_ids = [mid for mid in inbound_ids if not (mid in seen or seen.add(mid))]

# Define the action_data values
summary_text = "The sender is asking for an update on the status of their financial aid application."
next_questions = [
    "Can you confirm if all submitted documents have been received?",
    "What is the expected timeline for processing financial aid applications?"
]
next_actions = [
    "Check the financial aid application status in the system.",
    "Verify receipt of all required documents.",
    "Send response to the sender with current status and next steps."
]

# Write the activity seed file
with open(seed_activity, "w") as out:
    out.write("-- Auto-generated seed for organization_inbound_messages_activity\n\n")
    for mid in inbound_ids:
        # interpreted_request (no action_data)
        out.write(f"""\
INSERT INTO public.organization_inbound_messages_activity (id, inbound_message_id, action, action_data)
VALUES ('{uuid.uuid4()}', '{mid}', 'interpreted_request', NULL)
ON CONFLICT (id) DO NOTHING;

""")
        # summarized_question (JSON string)
        out.write(f"""\
INSERT INTO public.organization_inbound_messages_activity (id, inbound_message_id, action, action_data)
VALUES ('{uuid.uuid4()}', '{mid}', 'summarized_question', '{json.dumps(summary_text)}'::jsonb)
ON CONFLICT (id) DO NOTHING;

""")
        # suggested_next_questions (JSON array)
        out.write(f"""\
INSERT INTO public.organization_inbound_messages_activity (id, inbound_message_id, action, action_data)
VALUES ('{uuid.uuid4()}', '{mid}', 'suggested_next_questions', '{json.dumps(next_questions)}'::jsonb)
ON CONFLICT (id) DO NOTHING;

""")
        # suggested_next_actions (JSON array)
        out.write(f"""\
INSERT INTO public.organization_inbound_messages_activity (id, inbound_message_id, action, action_data)
VALUES ('{uuid.uuid4()}', '{mid}', 'suggested_next_actions', '{json.dumps(next_actions)}'::jsonb)
ON CONFLICT (id) DO NOTHING;

""")

print(f"Generated {seed_activity} with {len(inbound_ids)} message activities")


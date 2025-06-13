-- inbound messages pulled from provider
create table if not exists public.organization_inbound_messages (
  id              uuid         not null default gen_random_uuid() primary key,
  organization_id uuid         not null references public.organizations(id),
  sender_address  text         not null,
  recipient_address text       not null,
  subject         text,
  body            text,
  embedding       vector(1536),             -- latest OpenAI embedding dim
  provider        text         not null,   -- e.g. 'google', 'microsoft'
  message_id      text         unique,     -- original provider message ID
  thread_id       text,                      -- provider’s thread/conversation ID
  received_at     timestamptz not null,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

-- join inbound messages to students (if we can resolve a student)
create table if not exists public.organization_inbound_messages_students (
  inbound_message_id uuid not null
    references public.organization_inbound_messages(id) on delete cascade,
  student_id         uuid not null
    references public.students(id) on delete cascade,
  created_at         timestamptz not null default now(),
  primary key (inbound_message_id, student_id)
);

-- outbound messages auto-drafted for a given inbound message
create table if not exists public.organization_outbound_messages (
  id                  uuid         not null default gen_random_uuid() primary key,
  organization_id     uuid         not null references public.organizations(id),
  inbound_message_id  uuid         not null
                       references public.organization_inbound_messages(id) on delete cascade,
  is_sent             boolean      not null default false,
  sent_at             timestamptz,                        -- when we actually dispatched
  provider_message_id text         unique,                 -- e.g. SMTP or Graph message ID
  created_at          timestamptz  not null default now(),
  updated_at          timestamptz  not null default now()
);

-- every time the draft is revised we insert a new version
create table if not exists public.organization_outbound_message_versions (
  id                   uuid         not null default gen_random_uuid() primary key,
  outbound_message_id  uuid         not null
                        references public.organization_outbound_messages(id) on delete cascade,
  version              integer      not null,
  subject              text,
  body                 text,
  embedding            vector(1536),            -- for similarity against inbounds
  liked                boolean,                 -- feedback: thumbs-up?
  feedback             text,                    -- optional freeform comment
  created_at           timestamptz  not null default now(),
  updated_at           timestamptz  not null default now(),
  unique (outbound_message_id, version)
);

-- vector indexes for fast ANN search
create index on public.organization_inbound_messages
  using ivfflat (embedding vector_l2_ops) with (lists = 100);

create index on public.organization_outbound_message_versions
  using ivfflat (embedding vector_l2_ops) with (lists = 100);

-- enable RLS on every new table
alter table public.organization_inbound_messages         enable row level security;
alter table public.organization_inbound_messages_students enable row level security;
alter table public.organization_outbound_messages        enable row level security;
alter table public.organization_outbound_message_versions enable row level security;

-- policies: only “active” members of the same org can read/write

-- inbound messages
create policy "inbound: select if member of org" on public.organization_inbound_messages
  for select using (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_inbound_messages.organization_id
    )
  );
create policy "inbound: insert if member of org" on public.organization_inbound_messages
  for insert with check (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_inbound_messages.organization_id
    )
  );
create policy "inbound: update if member of org" on public.organization_inbound_messages
  for update using (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_inbound_messages.organization_id
    )
  ) with check (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_inbound_messages.organization_id
    )
  );
create policy "inbound: delete if member of org" on public.organization_inbound_messages
  for delete using (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_inbound_messages.organization_id
    )
  );

-- inbound ↔ students join
create policy "inbound_students: select if member of org" on public.organization_inbound_messages_students
  for select using (
    exists (
      select 1
      from public.organization_inbound_messages im
      join public.members m on m.organization_id = im.organization_id
      where im.id = public.organization_inbound_messages_students.inbound_message_id
        and m.id = auth.uid()
        and m.active
    )
  );
create policy "inbound_students: insert if member of org" on public.organization_inbound_messages_students
  for insert with check (
    exists (
      select 1
      from public.organization_inbound_messages im
      join public.members m on m.organization_id = im.organization_id
      where im.id = inbound_message_id
        and m.id = auth.uid()
        and m.active
    )
  );
create policy "inbound_students: delete if member of org" on public.organization_inbound_messages_students
  for delete using (
    exists (
      select 1
      from public.organization_inbound_messages im
      join public.members m on m.organization_id = im.organization_id
      where im.id = public.organization_inbound_messages_students.inbound_message_id
        and m.id = auth.uid()
        and m.active
    )
  );

-- outbound messages
create policy "outbound: select if member of org" on public.organization_outbound_messages
  for select using (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_outbound_messages.organization_id
    )
  );
create policy "outbound: insert if member of org" on public.organization_outbound_messages
  for insert with check (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_outbound_messages.organization_id
    )
  );
create policy "outbound: update if member of org" on public.organization_outbound_messages
  for update using (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_outbound_messages.organization_id
    )
  ) with check (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_outbound_messages.organization_id
    )
  );
create policy "outbound: delete if member of org" on public.organization_outbound_messages
  for delete using (
    exists (
      select 1 from public.members m
      where m.id = auth.uid()
        and m.active
        and m.organization_id = public.organization_outbound_messages.organization_id
    )
  );

-- outbound message versions
create policy "versions: select if member of org" on public.organization_outbound_message_versions
  for select using (
    exists (
      select 1
      from public.organization_outbound_messages om
      join public.members m on m.organization_id = om.organization_id
      where om.id = public.organization_outbound_message_versions.outbound_message_id
        and m.id = auth.uid()
        and m.active
    )
  );
create policy "versions: insert if member of org" on public.organization_outbound_message_versions
  for insert with check (
    exists (
      select 1
      from public.organization_outbound_messages om
      join public.members m on m.organization_id = om.organization_id
      where om.id = outbound_message_id
        and m.id = auth.uid()
        and m.active
    )
  );
create policy "versions: update if member of org" on public.organization_outbound_message_versions
  for update using (
    exists (
      select 1
      from public.organization_outbound_messages om
      join public.members m on m.organization_id = om.organization_id
      where om.id = public.organization_outbound_message_versions.outbound_message_id
        and m.id = auth.uid()
        and m.active
    )
  ) with check (
    exists (
      select 1
      from public.organization_outbound_messages om
      join public.members m on m.organization_id = om.organization_id
      where om.id = public.organization_outbound_message_versions.outbound_message_id
        and m.id = auth.uid()
        and m.active
    )
  );
create policy "versions: delete if member of org" on public.organization_outbound_message_versions
  for delete using (
    exists (
      select 1
      from public.organization_outbound_messages om
      join public.members m on m.organization_id = om.organization_id
      where om.id = public.organization_outbound_message_versions.outbound_message_id
        and m.id = auth.uid()
        and m.active
    )
  );

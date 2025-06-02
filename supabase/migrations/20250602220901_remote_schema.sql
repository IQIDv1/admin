create table "public"."studentstest" (
    "id" uuid not null default gen_random_uuid(),
    "first_name" text not null,
    "last_name" text not null,
    "email_address" text not null,
    "created_at" timestamp with time zone not null default now(),
    "original_id" uuid not null
);


alter table "public"."studentstest" enable row level security;

CREATE UNIQUE INDEX studentstest_pkey ON public.studentstest USING btree (id);

alter table "public"."studentstest" add constraint "studentstest_pkey" PRIMARY KEY using index "studentstest_pkey";

grant delete on table "public"."studentstest" to "anon";

grant insert on table "public"."studentstest" to "anon";

grant references on table "public"."studentstest" to "anon";

grant select on table "public"."studentstest" to "anon";

grant trigger on table "public"."studentstest" to "anon";

grant truncate on table "public"."studentstest" to "anon";

grant update on table "public"."studentstest" to "anon";

grant delete on table "public"."studentstest" to "authenticated";

grant insert on table "public"."studentstest" to "authenticated";

grant references on table "public"."studentstest" to "authenticated";

grant select on table "public"."studentstest" to "authenticated";

grant trigger on table "public"."studentstest" to "authenticated";

grant truncate on table "public"."studentstest" to "authenticated";

grant update on table "public"."studentstest" to "authenticated";

grant delete on table "public"."studentstest" to "service_role";

grant insert on table "public"."studentstest" to "service_role";

grant references on table "public"."studentstest" to "service_role";

grant select on table "public"."studentstest" to "service_role";

grant trigger on table "public"."studentstest" to "service_role";

grant truncate on table "public"."studentstest" to "service_role";

grant update on table "public"."studentstest" to "service_role";

create policy "Enable all access to service_role"
on "public"."studentstest"
as permissive
for all
to service_role
using (true)
with check (true);




-- Job Prep Dashboard cloud storage setup
-- Run this entire script once in Supabase Dashboard > SQL Editor.
-- This creates one private JSON record per authenticated user.

create table if not exists public.job_prep_data (
  user_id uuid primary key references auth.users (id) on delete cascade,
  payload jsonb not null default '{"subjects":[],"sessions":[],"activeTimer":null,"preferences":{"theme":"system","accent":"#4e9b8d"}}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Keep the table inaccessible to anonymous visitors and enforce owner-only access.
alter table public.job_prep_data enable row level security;

revoke all on table public.job_prep_data from anon;
grant select, insert, update, delete on table public.job_prep_data to authenticated;

drop policy if exists "Users can read their own job prep data" on public.job_prep_data;
create policy "Users can read their own job prep data"
  on public.job_prep_data for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "Users can create their own job prep data" on public.job_prep_data;
create policy "Users can create their own job prep data"
  on public.job_prep_data for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "Users can update their own job prep data" on public.job_prep_data;
create policy "Users can update their own job prep data"
  on public.job_prep_data for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can delete their own job prep data" on public.job_prep_data;
create policy "Users can delete their own job prep data"
  on public.job_prep_data for delete
  to authenticated
  using (auth.uid() = user_id);
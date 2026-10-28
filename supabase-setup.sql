create table if not exists public.tasks (
  id text primary key,
  title text not null,
  description text not null default '',
  type text not null default 'Incident',
  priority text not null default 'Medium',
  status text not null default 'New',
  assignee text not null default '',
  requester text not null default '',
  due date,
  created timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.tasks enable row level security;
revoke all on public.tasks from anon;
grant select, insert, update, delete on public.tasks to authenticated;

drop policy if exists "Team members can view tasks" on public.tasks;
drop policy if exists "Team members can create tasks" on public.tasks;
drop policy if exists "Team members can update tasks" on public.tasks;
drop policy if exists "Team members can delete tasks" on public.tasks;
create policy "Team members can view tasks" on public.tasks for select to authenticated using (true);
create policy "Team members can create tasks" on public.tasks for insert to authenticated with check (true);
create policy "Team members can update tasks" on public.tasks for update to authenticated using (true) with check (true);
create policy "Team members can delete tasks" on public.tasks for delete to authenticated using (true);

-- Enable Realtime for cross-browser updates.
do $$
begin
  if not exists (select 1 from pg_publication_tables where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'tasks') then
    alter publication supabase_realtime add table public.tasks;
  end if;
end $$;

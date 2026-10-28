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
  updated_at timestamptz not null default now(),
  is_demo boolean not null default false
);

alter table public.tasks add column if not exists is_demo boolean not null default false;
alter table public.tasks enable row level security;
revoke all on public.tasks from anon;
grant select, insert, update, delete on public.tasks to authenticated;

drop policy if exists "Team members can view tasks" on public.tasks;
drop policy if exists "Team members can create tasks" on public.tasks;
drop policy if exists "Team members can update tasks" on public.tasks;
drop policy if exists "Team members can delete tasks" on public.tasks;
create policy "Team members can view tasks" on public.tasks for select to authenticated using (
  case when lower(coalesce(auth.jwt()->>'email', '')) = 'opsdesk-demo@example.com' then is_demo else not is_demo end
);
create policy "Team members can create tasks" on public.tasks for insert to authenticated with check (
  lower(coalesce(auth.jwt()->>'email', '')) <> 'opsdesk-demo@example.com' and not is_demo
);
create policy "Team members can update tasks" on public.tasks for update to authenticated using (
  lower(coalesce(auth.jwt()->>'email', '')) <> 'opsdesk-demo@example.com' and not is_demo
) with check (
  lower(coalesce(auth.jwt()->>'email', '')) <> 'opsdesk-demo@example.com' and not is_demo
);
create policy "Team members can delete tasks" on public.tasks for delete to authenticated using (
  lower(coalesce(auth.jwt()->>'email', '')) <> 'opsdesk-demo@example.com' and not is_demo
);

-- Seed a safe sample queue reserved for the shareable read-only demo login.
insert into public.tasks (id,title,description,type,priority,status,assignee,requester,due,created,is_demo) values
('DEMO-1042','VPN access failing for remote team','Several users report intermittent VPN disconnects after the latest client update.','Incident','Critical','In Progress','Jordan Lee','Sales team',current_date,now()-interval '1 hour',true),
('DEMO-1041','Provision laptop for new starter','Prepare and configure laptop, MFA, and standard applications for Monday start.','Service Request','High','New','Sam Patel','People Ops',current_date+1,now()-interval '2 hours',true),
('DEMO-1040','Review firewall rules for staging','Remove unused rules and confirm change with application owner.','Security','High','Waiting','Casey Nguyen','Engineering',current_date-1,now()-interval '3 hours',true),
('DEMO-1039','Restore shared drive permissions','Finance cannot access the Q4 reporting folder.','Access','Medium','In Progress','Jordan Lee','Finance',current_date+2,now()-interval '4 hours',true),
('DEMO-1038','Patch conference room display','Apply pending firmware update to the 4F meeting room display.','Maintenance','Low','New','Taylor Brooks','Workplace',current_date+4,now()-interval '5 hours',true),
('DEMO-1037','Set up MFA for contractor account','Temporary contractor account needs approved MFA enrollment.','Access','Medium','Done','Sam Patel','Design',current_date-2,now()-interval '6 hours',true),
('DEMO-1036','Investigate slow file server response','Users in the Manila office report slow file browsing in the afternoon.','Incident','High','In Progress','Casey Nguyen','Operations',current_date,now()-interval '7 hours',true)
on conflict (id) do update set title=excluded.title,description=excluded.description,type=excluded.type,priority=excluded.priority,status=excluded.status,assignee=excluded.assignee,requester=excluded.requester,due=excluded.due,created=excluded.created,is_demo=true;

-- Enable Realtime for cross-browser updates.
do $$
begin
  if not exists (select 1 from pg_publication_tables where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'tasks') then
    alter publication supabase_realtime add table public.tasks;
  end if;
end $$;

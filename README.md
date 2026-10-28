# OpsDesk IT shared task manager

**Live app:** https://dequchescsc.github.io/opsdesk-it/

OpsDesk is a browser-based IT task queue with an overview dashboard, filters, and a kanban board. Team tasks are stored in Supabase and sync between signed-in team accounts.

## Demo access

A read-only demonstration account is available for visitors:

- Email: `opsdesk-demo@example.com`
- Password: supplied directly by the project owner

The demo login sees only the sample queue. Database row-level security prevents it from reading team tasks or creating, editing, or deleting any tasks. Do not add the demo password to this public repository.

## Team access

Open sign-ups are disabled. The project owner can invite teammates in **Supabase -> Authentication -> Users -> Add user**. Teammates sign in to the live app with their own account. Team accounts can read, create, edit, and delete the team task queue.

The app uses a browser-safe Supabase publishable key. That key is public by design; row-level security enforces access. Never publish the Supabase database password or a secret/service-role API key.

## Database

The repository includes `supabase-setup.sql`, which creates the `public.tasks` table, row-level security policies, the isolated demo sample queue, and the Realtime publication entry. The setup has already been applied to the hosted Supabase project.

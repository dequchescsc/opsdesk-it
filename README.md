# OpsDesk IT task manager

**Live app:** https://dequchescsc.github.io/opsdesk-it/

OpsDesk is a browser-based IT task queue with an overview dashboard, filters, and a kanban board. The owner manages one shared task queue through a personal account.

## Owner access

The project owner signs in with their own account to create, edit, and delete tasks. Open sign-ups are disabled. The owner can add and update tasks at any time; signed-in sessions share changes through Supabase Realtime.

## Read-only viewer access

A read-only viewer login is available for sharing the owner's task queue: `opsdesk-demo@example.com`. Give its password directly to a viewer; never put that password in this public repository. Viewer access is read-only and limited by database row-level security to the owner's tasks. It cannot see demo seed rows or change tasks.

The app uses a browser-safe Supabase publishable key. That key is public by design; row-level security enforces access. Never publish the Supabase database password or a secret/service-role API key.

## Database

The repository includes `supabase-setup.sql`, which creates the `public.tasks` table, row-level security policies, a private sample seed queue, and the Realtime publication entry. The setup has been applied to the hosted Supabase project.

# OpsDesk IT shared task manager

**Live app:** https://dequchescsc.github.io/opsdesk-it/

OpsDesk is a browser based IT task queue with an overview dashboard, filters, and a kanban board. Tasks are stored in the dedicated Supabase project and sync between signed-in teammates.

## Team access

The app is connected to the OpsDesk IT Supabase project using its browser-safe publishable key. That key is public by design; database row-level security limits task access to authenticated users.

Open sign-ups should remain disabled. The project owner can invite teammates in **Supabase -> Authentication -> Users -> Add user**. Teammates open the live app and sign in with the invited email and password. Anyone invited into this dedicated project can read, create, edit, and delete its task queue.

Never publish the Supabase database password or a secret/service-role API key. Only the publishable key belongs in browser code.

## Database

The repository includes `supabase-setup.sql`, which creates the `public.tasks` table, authenticated-user policies, and Realtime publication entry. It has already been applied to the hosted Supabase project.
# OpsDesk shared setup

This folder contains a shared version of the IT task tracker and the SQL needed to store tasks centrally. Once connected, signed-in teammates use the same task list across browsers and devices.

## 1. Create the database

1. Create a Supabase project at [supabase.com](https://supabase.com/).
2. Open **SQL Editor** in the project.
3. Paste and run all of `supabase-setup.sql`.
4. In **Project Settings → API**, copy the Project URL and the publishable (anon) key.

The browser app uses the publishable key. Never put a Supabase secret or service-role key in a browser app.

## 2. Connect OpsDesk

Open `opsdesk-shared.html` in Chrome. On the sign-in screen, enter the Project URL and publishable key, click **Connect workspace**, then sign in or create an account. You can also save the connection later under **Settings & data**. Ask teammates to open the same app URL and sign in to the same Supabase project.

For an internal IT queue, use **Authentication → Providers / Signups** in Supabase to control who can create accounts. If you disable open sign-ups, invite teammates from the Supabase Auth users page. Anyone who can authenticate in this project can see and change this queue, so use a project dedicated to this team.

## 3. Put it online

Upload `opsdesk-shared.html` to an HTTPS static host such as your organization's internal web host, GitHub Pages, or Netlify, then share that hosted URL. Keep `supabase-setup.sql` as your database setup record; it does not need to be publicly served.

## Data notes

- Tasks are stored in Supabase Postgres and live updates are broadcast using Supabase Realtime.
- Sign-in sessions and the connection settings are saved in the current browser.
- The JSON export/import actions are useful for backups and moving tasks.
- Task access is granted to authenticated users in this dedicated Supabase project. The SQL applies row-level security and denies anonymous access.

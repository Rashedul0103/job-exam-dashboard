# Job Prep Dashboard — cloud setup

The dashboard uses GitHub Pages for the website and Supabase for the study database.

## 1. Create the Supabase project

1. Create a project at https://supabase.com.
2. Open the project's SQL Editor.
3. Paste and run the contents of `job-prep-supabase-setup.sql`.
4. In Project Settings → API, copy the Project URL and the **publishable key** (or legacy `anon` key). Do not use a `service_role` or secret key in the HTML.

## 2. Publish the dashboard

1. Put `index.html` in the root of the GitHub Pages publishing source.
2. In the repository, open Settings → Pages and enable publishing from the desired branch/folder.
3. Open the published site URL.

## 3. Connect the dashboard

1. Select **Cloud settings** in the dashboard.
2. Enter the Supabase Project URL and publishable key.
3. Create an account with your email and password. If email confirmation is enabled, confirm the message Supabase sends, then return to the dashboard and sign in.
4. Your topics, subjects, sessions and active stopwatch state will be stored in the Supabase table protected by Row Level Security.

If email confirmation is enabled, set the published GitHub Pages URL as the Supabase Auth Site URL (and add it to allowed redirect URLs if required).

## Data handling

- Study data is saved to Supabase, not local browser storage.
- Browser storage is used only for the Supabase connection details, Supabase's login session, and display preferences.
- The dashboard shows whether data is saving, synced, or in an error state.
- Export JSON backups regularly. The Supabase Free plan does not include automatic database backups and free projects may pause after a week of inactivity.
- The dashboard downloads a current backup before replacing or resetting cloud data.
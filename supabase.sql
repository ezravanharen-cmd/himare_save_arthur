-- Scorebord voor "Breng Arthur naar bed"
-- Plak dit in Supabase > SQL Editor en klik op Run.

create table if not exists public.scores (
  id         bigint generated always as identity primary key,
  name       text    not null check (char_length(name) between 1 and 7),
  score      integer not null check (score between 0 and 5000),
  won        boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.scores enable row level security;

-- Iedereen mag het scorebord lezen
create policy "scores lezen" on public.scores
  for select to anon using (true);

-- Iedereen mag een score toevoegen (niet wijzigen of verwijderen)
create policy "score toevoegen" on public.scores
  for insert to anon with check (true);

create index if not exists scores_score_idx on public.scores (score desc);

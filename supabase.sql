-- =========================================================
-- めばえ ― Supabase セットアップ用SQL
-- Supabase ダッシュボード → SQL Editor に貼り付けて「Run」
-- =========================================================

-- ユーザーごとのアプリ状態を1行で保存するテーブル
-- （タスク・メモ・予定・設定などをまとめて JSON で持つ）
create table if not exists public.app_state (
  user_id     uuid primary key references auth.users (id) on delete cascade,
  state       jsonb not null default '{}'::jsonb,
  updated_at  timestamptz not null default now()
);

-- 更新時に updated_at を自動で現在時刻にする
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists app_state_set_updated_at on public.app_state;
create trigger app_state_set_updated_at
before update on public.app_state
for each row execute function public.set_updated_at();

-- ---------------------------------------------------------
-- Row Level Security（RLS）
-- 「自分の行だけ読める・書ける」ようにする。
-- これを有効にしないと、公開キー(anon key)で他人のデータまで
-- 見えてしまうので必ず実行すること。
-- ---------------------------------------------------------
alter table public.app_state enable row level security;

drop policy if exists "own row: select" on public.app_state;
create policy "own row: select"
  on public.app_state for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "own row: insert" on public.app_state;
create policy "own row: insert"
  on public.app_state for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "own row: update" on public.app_state;
create policy "own row: update"
  on public.app_state for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "own row: delete" on public.app_state;
create policy "own row: delete"
  on public.app_state for delete
  to authenticated
  using ((select auth.uid()) = user_id);

-- Agenda Fotográfica: schema Supabase
-- Execute no SQL Editor do seu projeto Supabase.
create extension if not exists pgcrypto;

create table if not exists public.photo_sessions (
  id text primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  client_name text not null,
  phone text not null default '',
  session_type text not null,
  status text not null default 'Agendado'
    check (status in ('Agendado','Confirmado','Realizado','Cancelado')),
  contract_status text not null default 'Enviar'
    check (contract_status in ('Enviar','Enviado','Assinado')),
  session_date date not null,
  session_time time not null default '09:00',
  location text not null default '',
  package_value numeric(12,2) not null default 0 check (package_value >= 0),
  deposit numeric(12,2) not null default 0 check (deposit >= 0),
  extra_payments numeric(12,2) not null default 0 check (extra_payments >= 0),
  notes text not null default '',
  updated_at timestamptz not null default now()
);

-- Migration for projects where the table already exists.
alter table public.photo_sessions add column if not exists contract_status text not null default 'Enviar';

alter table public.photo_sessions enable row level security;

drop policy if exists "Users can read their own sessions" on public.photo_sessions;
create policy "Users can read their own sessions"
on public.photo_sessions for select to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users can insert their own sessions" on public.photo_sessions;
create policy "Users can insert their own sessions"
on public.photo_sessions for insert to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Users can update their own sessions" on public.photo_sessions;
create policy "Users can update their own sessions"
on public.photo_sessions for update to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete their own sessions" on public.photo_sessions;
create policy "Users can delete their own sessions"
on public.photo_sessions for delete to authenticated
using (auth.uid() = user_id);

create index if not exists photo_sessions_user_date_idx
on public.photo_sessions (user_id, session_date);

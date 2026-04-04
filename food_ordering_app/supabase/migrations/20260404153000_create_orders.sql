create extension if not exists pgcrypto;

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  order_code text not null unique,
  customer_email text,
  address text not null,
  payment_method text not null,
  payment_status text not null default 'pending',
  payment_reference text,
  status text not null default 'Preparing',
  subtotal numeric(10,2) not null,
  delivery_fee numeric(10,2) not null,
  total numeric(10,2) not null,
  items jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

drop trigger if exists orders_set_updated_at on public.orders;
create trigger orders_set_updated_at
before update on public.orders
for each row execute function public.set_updated_at();

alter table public.orders enable row level security;

drop policy if exists orders_select_all on public.orders;
create policy orders_select_all
on public.orders
for select
using (true);

drop policy if exists orders_insert_all on public.orders;
create policy orders_insert_all
on public.orders
for insert
with check (true);

drop policy if exists orders_update_all on public.orders;
create policy orders_update_all
on public.orders
for update
using (true)
with check (true);

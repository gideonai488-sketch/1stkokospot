create unique index if not exists orders_payment_reference_unique
on public.orders(payment_reference)
where payment_reference is not null;

create index if not exists orders_order_code_idx
on public.orders(order_code);

create index if not exists orders_payment_status_idx
on public.orders(payment_status);

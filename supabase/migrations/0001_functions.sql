-- وين فلوسي: sync backend. Each family (household) only ever sees its own rows.

-- Server time for every write; the client pulls rows newer than its cursor.
-- Last write wins per row: an update older than the stored row is ignored,
-- so a phone that was offline cannot overwrite a newer edit.
create or replace function public.stamp_row() returns trigger
language plpgsql as $$
begin
  if tg_op = 'UPDATE' and new.updated_at < old.updated_at then
    return null;
  end if;
  new.server_updated_at := clock_timestamp();
  return new;
end $$;

-- Membership checks used by every policy. security definer so the policy on
-- members does not recurse into itself.
create or replace function public.is_member(hid text) returns boolean
language plpgsql stable security definer set search_path = public as $$
begin
  return exists (
    select 1 from public.members m
    where m.household_id = hid and m.user_id = auth.uid()::text and m.deleted_at is null
  );
end $$;

create or replace function public.created_household(hid text) returns boolean
language plpgsql stable security definer set search_path = public as $$
begin
  return exists (select 1 from public.households h where h.id = hid and h.created_by = auth.uid());
end $$;

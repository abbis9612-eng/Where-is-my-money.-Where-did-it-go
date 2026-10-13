\set ON_ERROR_STOP 1
grant all on all tables in schema public to authenticated;
-- User A creates a family and pushes rows.
set role authenticated;
select set_config('request.jwt.claim.sub', '11111111-1111-1111-1111-111111111111', false);
insert into households (id, household_id, created_at, updated_at, name, base_currency, usd_rate, invite_code) values ('hA','hA',now(),now(),'بيت أ','IQD',1520,'WF-AAAA');
insert into members (id, household_id, created_at, updated_at, display_name, role, letter, color_index, user_id, free_allowance, sort_order) values ('mA','hA',now(),now(),'بابا','owner','ب',0,'11111111-1111-1111-1111-111111111111',0,0);
insert into txns (id, household_id, created_at, updated_at, kind, amount_minor, currency, fx_rate, amount_base, occurred_at, label, note, source, counts_in_week) values ('t1','hA',now(),now(),'expense',20000,'IQD',1,20000,now(),'مولدة','','voice',true);
select 'A sees own txns', count(*) from txns;
-- Last write wins: an older update is ignored.
update txns set amount_minor = 1, updated_at = now() - interval '1 day' where id = 't1';
select 'old update ignored', amount_minor from txns where id='t1';
-- User B (another family) sees nothing and cannot write into A.
select set_config('request.jwt.claim.sub', '22222222-2222-2222-2222-222222222222', false);
select 'B sees A txns', count(*) from txns;
select 'B sees A household', count(*) from households;
do $$ begin
  insert into txns (id, household_id, created_at, updated_at, kind, amount_minor, currency, fx_rate, amount_base, occurred_at, label, note, source, counts_in_week) values ('t2','hA',now(),now(),'expense',1,'IQD',1,1,now(),'x','','manual',true);
  raise exception 'B wrote into A';
exception when insufficient_privilege then raise notice 'B blocked from writing into A: ok';
end $$;
-- B joins with A's invite code, then sees A's rows.
select 'joined', * from join_household('wf-aaaa', 'ماما');
select 'B sees A txns after join', count(*) from txns;
-- C with a wrong code is refused.
select set_config('request.jwt.claim.sub', '33333333-3333-3333-3333-333333333333', false);
do $$ begin perform join_household('WF-ZZZZ', 'x'); raise exception 'joined with bad code';
exception when others then raise notice 'bad code refused: %', sqlerrm; end $$;
select 'C sees', count(*) from txns;

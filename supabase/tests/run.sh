#!/usr/bin/env bash
# Runs the migrations and the family-isolation test on a throwaway local Postgres.
# Usage: supabase/tests/run.sh   (needs Postgres 15+ binaries on PATH or PG_BIN)
set -euo pipefail
PG_BIN=${PG_BIN:-$(dirname "$(command -v initdb || echo /usr/lib/postgresql/16/bin/initdb)")}
DIR=$(mktemp -d)
cd "$(dirname "$0")/../.."
"$PG_BIN/initdb" -D "$DIR/data" -A trust -U postgres >/dev/null
"$PG_BIN/pg_ctl" -D "$DIR/data" -o "-p 54330 -k $DIR" -l "$DIR/log" start >/dev/null
trap '"$PG_BIN/pg_ctl" -D "$DIR/data" stop >/dev/null; rm -rf "$DIR"' EXIT
P=("$PG_BIN/psql" -h "$DIR" -p 54330 -U postgres -q -v ON_ERROR_STOP=1)
"$PG_BIN/createdb" -h "$DIR" -p 54330 -U postgres wf
"${P[@]}" -d wf -f supabase/tests/auth_stub.sql
for f in supabase/migrations/*.sql; do "${P[@]}" -d wf -f "$f"; done
"${P[@]}" -d wf -f supabase/tests/rls_test.sql

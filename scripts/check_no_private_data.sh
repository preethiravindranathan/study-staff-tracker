#!/usr/bin/env bash
# Blocks real study data, local trackers and secrets from being committed.
#   scripts/check_no_private_data.sh            # check staged files (used by the pre-commit hook)
#   scripts/check_no_private_data.sh --all      # check every tracked file
set -u
SELF="scripts/check_no_private_data.sh"

if [ "${1:-}" = "--all" ]; then
  FILES=$(git ls-files)
else
  FILES=$(git diff --cached --name-only --diff-filter=ACMR)
fi
[ -z "$FILES" ] && exit 0

fail=0
report() { echo "BLOCKED: $1 -> $2"; fail=1; }

# 1. File types and paths that only ever hold real data or local notes.
BLOCKED_PATH='\.(xlsx|xlsm|xls|csv|tsv|pdf|docx?|pptx|msg|eml|png|jpe?g|heic|tiff?|zip|pem|key|p12|pfx)$|^(data|input|output|exports|downloads|notes)/|(^|/)\.env($|\.)|(^|/)(STATUS|CHECKPOINT|GAPS|TASKS)\.md$|credentials.*\.json$|token.*\.json$'

# 2. Content patterns: keys, tokens, and personal identifiers.
SECRET_RE='-----BEGIN [A-Z ]*PRIVATE KEY-----|AKIA[0-9A-Z]{16}|gh[pousr]_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{20,}|xox[abpr]-[A-Za-z0-9-]{10,}|AIza[0-9A-Za-z_-]{35}|sk-[A-Za-z0-9_-]{20,}|"private_key"[[:space:]]*:|(client_secret|api_key|apikey|password|passwd)[[:space:]]*[:=][[:space:]]*["'"'"']?[^[:space:]"'"'"'<>{}$]{6,}'
SSN_RE='(^|[^0-9])[0-9]{3}-[0-9]{2}-[0-9]{4}([^0-9]|$)'
EMAIL_RE='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
EMAIL_OK='@(example\.(com|org|net)|users\.noreply\.github\.com)'

while IFS= read -r f; do
  [ -z "$f" ] && continue
  case "$f" in samples/*|.env.example) sample=1 ;; *) sample=0 ;; esac
  if [ $sample -eq 0 ] && echo "$f" | grep -Eiq -e "$BLOCKED_PATH"; then
    report "$f" "file type/path reserved for real data, secrets or local trackers"
    continue
  fi
  [ "$f" = "$SELF" ] && continue
  [ -f "$f" ] || continue
  # Read the staged version when checking staged files, the working copy for --all.
  if [ "${1:-}" = "--all" ]; then content=$(cat "$f" 2>/dev/null); else content=$(git show ":$f" 2>/dev/null); fi
  echo "$content" | grep -Eq -e "$SECRET_RE" && report "$f" "looks like a key, token or password"
  echo "$content" | grep -Eq -e "$SSN_RE" && report "$f" "looks like a US SSN"
  bad_email=$(echo "$content" | grep -Eo -e "$EMAIL_RE" | grep -Evi -e "$EMAIL_OK" | head -1)
  [ -n "$bad_email" ] && report "$f" "contains a real-looking email address ($bad_email); use name@example.com"
done <<< "$FILES"

if [ $fail -ne 0 ]; then
  echo
  echo "Commit stopped. Remove the data, or move test files into samples/ using made-up people."
  echo "Do not bypass with --no-verify unless you are sure the file holds no real data."
  exit 1
fi
exit 0

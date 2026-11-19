# CLAUDE.md — study-staff-tracker

## 1. What this project is

A tool that pulls clinical study staff information from documents (CVs, medical licenses, GCP training certificates, delegation logs) in a folder and fills in an Excel tracker. The folder can be local or in SharePoint, Box or Google Drive.

Out of scope for now: anything about study participants or patients. This tool tracks site staff only.

**The repository is public. Read `docs/data-handling.md` before adding any file.**

## 2. Tech stack

- Language: Python (planned; nothing installed yet)
- Dependencies: none yet. Add each one with a stated reason and the user's approval.
- No GitHub Actions. The user does not use them. Do not add `.github/workflows/`.

## 3. Verification commands

```bash
scripts/check_no_private_data.sh --all   # must print nothing and exit 0 before every push
```

Tests and lint commands will be added when code exists.

## 4. Schema → consumer audit targets

- Tracker column definitions (planned in `config/`). Consumers: `src/study_staff_tracker/extractors/` and `src/study_staff_tracker/tracker/`.

## 5. Definition of done

A feature is done when it runs end to end on the synthetic files in `samples/` and writes a correct tracker, and `scripts/check_no_private_data.sh --all` passes.

## 6. Do's and don'ts

- Never commit real documents, filled-in trackers, `.env` files or credential JSON.
- Test data goes in `samples/` and uses made-up people and `example.com` emails.
- STATUS.md, CHECKPOINT.md and TASKS.md are local-only and gitignored. Update them before every commit.
- Commit as `preethiravindranathan` (repo-local git config). Before pushing, run `gh auth switch -u preethiravindranathan`.

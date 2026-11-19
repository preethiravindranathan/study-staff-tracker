# Data handling

The repository is public. The data the tool processes is not. Study staff records can include names, contact details, license numbers, CVs and training records.

## Where things live

| Item | Location | Committed? |
|---|---|---|
| Tool source code | `src/` | Yes |
| Synthetic samples | `samples/` | Yes |
| Real source documents | the SharePoint, Box or Drive folder, or local `data/` / `input/` | No (ignored) |
| Filled-in tracker | outside the repo, or `output/` | No (ignored) |
| Connector credentials | `.env`, or credential JSON stored outside the repo | No (ignored) |
| Work trackers (STATUS.md, CHECKPOINT.md, TASKS.md) | repo root | No (ignored, local only) |

## Protections

1. **`.gitignore`** keeps data file types, `.env`, credential JSON and local trackers out of `git add`.
2. **Pre-commit hook** (`.githooks/pre-commit` → `scripts/check_no_private_data.sh`) blocks a commit when:
   - a staged file has a blocked type or path (this also catches `git add -f`), or
   - its text contains something that looks like a private key, cloud or API token, password assignment, US SSN, or an email address outside `example.com` and GitHub no-reply addresses.

   Turn it on once per clone with `scripts/setup_hooks.sh`.
3. **Manual full scan:** `scripts/check_no_private_data.sh --all` checks every tracked file.
4. **GitHub secret scanning with push protection** is enabled on the repository. It rejects pushes that contain known credential formats, on GitHub's side, as a second check.

## If something leaks

Deleting a file in a later commit does not remove it from git history or from forks and clones. Rotate any exposed credential immediately. For personal data, make the repo private, rewrite history (`git filter-repo`), and follow the study's data-incident procedure.

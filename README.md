# study-staff-tracker

A tool that pulls information about clinical study staff from documents in a folder and fills in an Excel tracker.

The folder can be local or in SharePoint, Box or Google Drive. The source documents include CVs, medical licenses, GCP training certificates and delegation logs. The tracker holds each person's role, credentials, expiry dates and related fields.

**Status:** planning. No extraction code yet.

## Data handling

This repository contains code only. It must never contain real study data.

- Real source documents and filled-in trackers stay outside the repo or in ignored folders (`data/`, `input/`, `output/`). `.gitignore` blocks spreadsheet, PDF, Word and image files.
- Example files in `samples/` are synthetic. They describe made-up people.
- Connector credentials (SharePoint, Box, Google Drive) go in a local `.env` file, which is never committed. `.env.example` lists the variable names with no values.

If real data is ever committed by mistake, deleting it in a later commit does not remove it from git history. Treat it as exposed and rewrite the history.

## Repository layout

```
src/study_staff_tracker/
  connectors/   list and download files: local folder, SharePoint, Box, Google Drive
  extractors/   turn CVs, licenses, GCP certificates into structured records
  tracker/      merge records into the Excel tracker
config/         tracker column definitions and matching rules (no secrets)
samples/        synthetic example files with made-up people
tests/          tests that read only from samples/
docs/           design notes and data-handling rules
scripts/        repo tooling, including the private-data check
.githooks/      pre-commit hook that runs the private-data check
.env.example    names of the connector settings; copy to .env locally
```

## Setup after cloning

```bash
scripts/setup_hooks.sh   # turns on the pre-commit private-data check
cp .env.example .env     # fill in locally; never committed
```

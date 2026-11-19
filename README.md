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

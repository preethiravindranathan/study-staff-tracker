# config/

Committed configuration that holds no secrets. Planned contents:

- Tracker column definitions: column name, type, required or optional, and which document type each field comes from.
- Field-matching rules for extractors.

Connector credentials do not belong here. They go in `.env`; see `.env.example`.

# samples/

Synthetic example documents and trackers for development and tests.

Every file here must describe made-up people. Use names like "Jane Testperson", emails at `example.com`, and license numbers that are obviously fake (for example `TEST-000123`). Never copy a real document here, even with the name changed. Other fields can still identify the person.

This is the only folder where `.gitignore` allows `.xlsx`, `.pdf` and `.docx` files. The pre-commit check skips the file-type check here but still scans text files for keys and real email addresses.

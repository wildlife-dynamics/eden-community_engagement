# Mock-IO data

Synthetic example returns for the IO tasks, used by the `mock_io` test cases in
`test-cases.yaml` (see `.github/workflows/test.yml`, which points the
`WT_TASK_MOCK_IO__…` environment variables at these files).

The data is **synthetic**. It has the same columns and types as real EarthRanger
`community_meeting_new` events. The choice-list values (meeting areas, villages and
convener organisations) are sampled with their real frequencies. Everything else is
made up: IDs, serial numbers, dates, attendance counts, team members, reporters,
topics and notes. Locations are random points inside the adjudication-area polygons
shipped with `ecoscope-workflows-ext-eden`.

| File | Mocks |
|---|---|
| `get-events.example-return.parquet` | `ecoscope.platform.tasks.io.get_events` (60 events: 48 resolved, 12 active) |
| `process-events-details.example-return.parquet` | `ecoscope.platform.tasks.io.process_events_details` (the 48 resolved events, with display titles) |

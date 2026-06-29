# Community Engagement Workflow

Community engagement is central to conservation success. Protected area managers and rangers hold regular meetings with local communities — to share information, resolve conflicts, gather intelligence, and build trust. Tracking these interactions consistently, and understanding patterns over time, is essential for adaptive management and donor reporting.

This workflow automates that process. It connects to your EarthRanger site, pulls your community meeting records, and produces structured reports and a dashboard that give you a clear picture of how engagement is progressing — who you're reaching, how participation is trending, which topics are coming up, and where meetings are concentrated across the landscape.

---

## What you get

Point this workflow at your EarthRanger site and configure your time range. It fetches all resolved community meeting events, processes the event details — participant counts, gender breakdown, topics discussed, meeting location — and groups them however makes sense for your reporting cycle: by quarter, by month, by location area, or any combination.

For each group you get:

- A **Word report** with a summary table (total meetings, total participants, median participants per meeting), a participant distribution box plot, a gender breakdown pie chart, a topics bar chart showing what communities are raising, and a choropleth map of meeting frequency across your adjudication areas, chiefdoms, or forest clusters.
- A **dashboard** that consolidates all the stats and charts across groups for a quick programme-level overview.

If you don't apply any groupers, you get a single report covering the full period — useful for annual or project-end summaries.

---

## Outputs

Everything is written to `ECOSCOPE_WORKFLOWS_RESULTS`:

| File | Description |
|------|-------------|
| `Community_Report_{period}_{location}.docx` | Word report — one per group |
| `*_box_plot.png` | Distribution of participants per meeting |
| `*_gender_pie_chart.png` | Participant breakdown by gender |
| `*_choropleth_map.png` | Meeting frequency across geographic areas |
| Dashboard | Stat cards + all charts merged across groups |

---

## Configuration

Edit `param.yaml` before running:

```yaml
er_client:
  data_source:
    name: "olokeri"             # your EarthRanger connection name

time_range:
  timezone:
    label: Africa/Nairobi
    tzCode: EAT
    name: Nairobi
    utc: +03:00
  since: "2000-01-01T00:00:00.000Z"
  until: "2026-12-31T23:59:59.000Z"

groupers:
  groupers:
    - temporal_index: "__quarter__"           # quarter | __semester__ | %Y | %Y-%m
  # - index_name: meeting_location_level_one  # group by location instead, or in addition

events:
  event_types:
    - "community_meeting_new"   # your EarthRanger event type name

generate_report:
  template_path: "/path/to/template.docx"    # local path or HTTPS URL
```

The report template at `resources/templates/community_engagement_report_template.docx` is a Jinja2-powered Word template. You can reference it by local path or host it and pass an HTTPS URL — the workflow downloads it automatically.

---

## Compile & run

```bash
# Recompile after any changes to spec.yaml
bash dev/recompile.sh --install

# Run
ECOSCOPE_WORKFLOWS_RESULTS="file:///tmp/output" \
  pixi run --manifest-path ecoscope-workflows-community-engagement-workflow/pixi.toml \
  ecoscope-workflows-community-engagement-workflow run \
  --config-file param.yaml \
  --execution-mode sequential \
  --no-mock-io
```

---

## Requirements

- [pixi](https://pixi.sh)
- EarthRanger connection configured via `ecoscope-workflows connections`

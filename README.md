# Community Engagement Workflow

An [ecoscope-workflows](https://github.com/wildlife-dynamics/ecoscope-workflows) workflow that turns your EarthRanger community meeting data into ready-to-share reports and a live dashboard — with no manual data wrangling.

---

## What you get

Point this workflow at your EarthRanger site and it will fetch all your resolved community meeting events for the period you choose. It processes the raw event data — pulling out participant counts, gender breakdowns, meeting topics, and locations — then groups everything however you like: by quarter, by month, by location, or any combination.

For each group, you get:

- A **Word report** (`.docx`) with a summary table (total meetings, total participants, median participants per meeting with IQR), a box plot of participant distribution, a gender pie chart, a topics bar chart, and a choropleth map showing meeting frequency across geographic areas such as adjudication areas, chiefdoms, or forest clusters.
- A **dashboard** that brings all the charts and stat cards together across groups — useful for a quick overview without opening individual reports.

If you don't configure any groupers, the workflow treats all your data as one group and produces a single report and dashboard.

---

## Outputs

Everything is written to `ECOSCOPE_WORKFLOWS_RESULTS`:

| File | Description |
|------|-------------|
| `Community_Report_{period}_{location}.docx` | Word report — one per group |
| `*_box_plot.png` | Distribution of participants per meeting |
| `*_gender_pie_chart.png` | Participant breakdown by gender |
| `*_choropleth_map.png` | Meeting frequency by geographic area |
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

The report template at `resources/templates/community_engagement_report_template.docx` is a Jinja2-powered Word template. You can reference it by local path or host it somewhere and pass an HTTPS URL — the workflow handles the download automatically.

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

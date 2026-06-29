# Community Engagement Workflow

An [ecoscope-workflows](https://github.com/wildlife-dynamics/ecoscope-workflows) workflow that connects to EarthRanger, pulls community meeting events, and produces a dashboard and per-group `.docx` reports.

---

## What it does

The workflow fetches resolved community meeting events for a configured time range, processes the event details (participants, gender breakdown, meeting topics, location), then groups and analyses the data. For each group it renders a box plot, gender pie chart, topics bar chart, and choropleth map — and assembles these into a Word report and a dashboard.

Groupers determine how many reports are produced. With a quarterly grouper, you get one report per quarter. With a location grouper, one per location. Groupers can be combined, or omitted entirely to produce a single report covering the full time range.

---

## Outputs

Written to `ECOSCOPE_WORKFLOWS_RESULTS`:

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
    name: "olokeri"             # EarthRanger connection name

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
    - temporal_index: "__quarter__"         # quarter | __semester__ | %Y | %Y-%m
  # - index_name: meeting_location_level_one  # or group by location

events:
  event_types:
    - "community_meeting_new"

generate_report:
  template_path: "/path/to/template.docx"  # local path or HTTPS URL
```

The default report template lives at `resources/templates/community_engagement_report_template.docx`. It is a Jinja2-powered Word template and can be referenced by local path or public HTTPS URL.

---

## Compile & run

```bash
# Recompile after changes to spec.yaml
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

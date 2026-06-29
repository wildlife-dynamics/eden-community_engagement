# Community Engagement Workflow

Pulls community meeting events from EarthRanger and generates a dashboard and `.docx` reports with meeting statistics, participant breakdowns, and a choropleth map of meeting locations.

Reports and dashboard widgets are produced per grouper combination — by quarter, month, location, or any combination. If no groupers are set, a single report covering the full time range is produced.

## Outputs

- `Community_Report_{period}_{location}.docx` — one per group
- **Dashboard** — stat cards (total meetings, participants, median), box plot, gender pie chart, topics bar chart, choropleth map
- Supporting chart images: box plot, gender pie chart, topics bar chart, choropleth map

## Configuration

Edit `param.yaml` before running:

- **`er_client`** — EarthRanger data source name
- **`time_range`** — `since` / `until` in ISO 8601
- **`groupers`** — how to slice the data (quarter, month, location, etc.) — optional
- **`events.event_types`** — EarthRanger event type(s) to fetch
- **`generate_report.template_path`** — path to the `.docx` Jinja2 template; accepts a local path or HTTPS URL

The default template is at `resources/templates/community_engagement_report_template.docx`.

## Compile & run

```bash
# Recompile after editing spec.yaml
bash dev/recompile.sh --install

# Run
ECOSCOPE_WORKFLOWS_RESULTS="file:///tmp/output" \
  pixi run --manifest-path ecoscope-workflows-community-engagement-workflow/pixi.toml \
  ecoscope-workflows-community-engagement-workflow run \
  --config-file param.yaml --execution-mode sequential --no-mock-io
```

## Requirements

- [pixi](https://pixi.sh)
- EarthRanger connection configured via `ecoscope-workflows connections`

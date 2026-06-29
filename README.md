# Community Engagement Workflow

Generates per-period community engagement reports from EarthRanger event data. For each grouper combination (e.g. quarter), the workflow produces a `.docx` report with meeting statistics, participant breakdowns, and a choropleth map.

## Outputs

- **DOCX reports** — one per group (e.g. `Community_Report_2026_Q1_Olokeri.docx`)
- **Charts** — box plot, gender pie chart, topic bar chart, choropleth map

## Quickstart

```bash
# Compile
bash dev/recompile.sh --install

# Run
ECOSCOPE_WORKFLOWS_RESULTS="file:///tmp/output" \
  pixi run --manifest-path ecoscope-workflows-community-engagement-workflow/pixi.toml \
  ecoscope-workflows-community-engagement-workflow run \
  --config-file param.yaml --execution-mode sequential --no-mock-io
```

## Configuration

Edit `param.yaml` to set the EarthRanger data source, time range, event types, groupers, and report template path.

The report template (`resources/templates/community_engagement_report_template.docx`) is a Jinja2 DOCX template — the `template_path` parameter accepts a local path or HTTPS URL.

## Requirements

- [pixi](https://pixi.sh)
- EarthRanger connection configured via `ecoscope-workflows` connections

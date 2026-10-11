# Agent guidance

## Purpose

This repository contains application workflows built with [Zigflow](https://zigflow.dev).
Zigflow runs declarative YAML workflows on Temporal and supplies the worker.
Develop workflow definitions and their supporting clients here; this is not the
Zigflow engine repository.

The hello-world workflow demonstrates the project structure. Extend or replace
it as requirements evolve. Read the current README, Makefile and Compose
configuration before making changes; these instructions describe the starter
and should evolve with the project.

## Authoritative information

Use current Zigflow resources when authoring workflows:

- [Documentation](https://zigflow.dev): workflow syntax, concepts, examples,
  deployment and CLI usage.
- [AI reference](https://zigflow.dev/llms.txt): concise guidance for assistants.
- [Zigflow MCP server](https://mcp.zigflow.dev): supported examples, schema,
  task documentation and workflow validation.
- [MCP documentation](https://zigflow.dev/docs/cli/mcp-server/): connection and
  tool usage.
- [Temporal documentation](https://docs.temporal.io): client SDKs and Temporal
  operations. Use Zigflow documentation for the workflow DSL itself.

MCP connection settings are included in `.mcp.json` and `.vscode/mcp.json`.
Their presence does not guarantee your client has connected. If the Zigflow
tools are available, use `list_examples` and `get_example` to find a relevant
pattern, `get_schema` and `get_task_docs` to check supported syntax, and
`validate_workflow` to check generated YAML. That tool accepts the complete
YAML text, not a file path. The server provides documentation and validation;
it does not run workflows.

If MCP is unavailable, use the documentation, schema, examples and local CLI.
Check compatibility with the installed Zigflow version: the hosted server may
reflect a different version. The matching schema and implementation determine
what is supported; resolve discrepancies rather than guessing.

## Workflow conventions

- Prefer `workflows/<workflow-name>/workflow.yaml`, following the existing
  example. Use clear names for workflows and tasks.
- All `.yaml`, `.yml` and `.json` files under `workflows/` are discovered
  recursively and treated as workflow definitions. Keep supporting data and
  standalone schemas outside that directory.
- Keep each client's workflow type and task queue aligned with
  `document.workflowType` and `document.taskQueue`.
- A `trigger.sh` beside a definition is an optional command-line client.
  Applications can use any appropriate Temporal SDK; follow the project's
  chosen language rather than introducing an SDK just to trigger a workflow.
- Use the Zigflow-supported DSL. Do not assume every Open Workflow
  Specification construct is implemented or borrow syntax from other engines.
- Check expression and data-flow semantics against the documentation.
  Zigflow expressions use jq inside `${ ... }`; distinguish task output from
  exported context. Check determinism requirements when generating identifiers
  or timestamps.
- Preserve established input/output contracts and consider existing callers
  and running executions when changing workflow behaviour.

## Development and verification

Use the repository's existing commands:

```sh
make validate                 # Static workflow validation; no Temporal needed
pre-commit run --all-files     # Configured repository checks
```

For local execution, `make temporal` starts the development server and
`make dev` starts Zigflow in watch mode. Run them in separate terminals.
`make hello-world` triggers the included example.

For Compose, run these in separate terminals:

```sh
docker compose up zigflow
docker compose run --rm hello-world
```

Compose starts Temporal as a dependency. Workflow files are mounted into the
worker and watched for changes. Add corresponding Make targets or Compose
trigger services when useful, following existing conventions.

Validate changed workflows and run the relevant lint checks. Structural
validation does not prove business behaviour; perform targeted execution
checks when needed for the change. Consider external calls and side effects
before executing a workflow. Starter CI validates definitions without
executing workflows or asserting example outputs.

Preserve the existing linting and version-selection choices unless the task
requires changing them. Commit messages follow Conventional Commits.
Update documentation when commands, configuration or workflow contracts change.
Keep changes focused, and report what was checked and any verification limits.

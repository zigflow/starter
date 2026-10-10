# Zigflow starter

A starting point for building, running and validating [Zigflow](https://zigflow.dev)
workflows. Extend the included example or replace it with your own.

<!-- toc -->

* [About Zigflow](#about-zigflow)
* [Project layout](#project-layout)
* [Run the example](#run-the-example)
  * [Locally](#locally)
  * [With Docker Compose](#with-docker-compose)
* [Extend the starter](#extend-the-starter)
  * [Add a workflow](#add-a-workflow)
  * [Add a trigger](#add-a-trigger)
  * [Make it your own](#make-it-your-own)
* [Validate workflows](#validate-workflows)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## About Zigflow

Zigflow runs durable [Temporal](https://temporal.io) workflows defined in YAML.
It provides the worker, so you can focus on your workflow definitions.

See the Zigflow documentation for
[installation](https://zigflow.dev/docs/getting-started/installation),
[workflow syntax](https://zigflow.dev/docs/dsl/intro) and
[concepts](https://zigflow.dev/docs/concepts/overview).

## Project layout

| Path | Purpose |
| --- | --- |
| [`workflows/hello-world/workflow.yaml`](workflows/hello-world/workflow.yaml) | Example workflow |
| [`workflows/hello-world/trigger.sh`](workflows/hello-world/trigger.sh) | Starts the example using the Temporal CLI |
| [`Makefile`](Makefile) | Local development, validation and trigger commands |
| [`compose.yml`](compose.yml) | Temporal, Zigflow and trigger services |
| [`Dockerfile`](Dockerfile) | Zigflow image containing your workflows |
| [`.github/workflows/build.yml`](.github/workflows/build.yml) | Linting, commit-message checks and workflow validation |

## Run the example

The example uses workflow type `hello-world` and task queue `zigflow`.
Both options below provide a Temporal UI at <http://localhost:8233>.

### Locally

Install [Zigflow](https://zigflow.dev/docs/getting-started/installation)
and the [Temporal CLI](https://docs.temporal.io/cli).
Run these commands in separate terminals, starting the server and worker
before triggering the workflow:

```sh
make temporal     # Start Temporal
make dev          # Run Zigflow in watch mode
make hello-world  # Execute the example and print its result
```

### With Docker Compose

With [Docker Compose](https://docs.docker.com/compose/install/) installed, run
the following commands in separate terminals:

```sh
docker compose up zigflow
docker compose run --rm hello-world
```

The first command starts Temporal and Zigflow. The second executes the example
and prints its result. Zigflow watches the mounted `workflows/` directory,
so workflow edits need no image rebuild.

## Extend the starter

### Add a workflow

Use one directory per workflow, with its definition named `workflow.yaml`:

```text
workflows/
  my-workflow/
    workflow.yaml
    trigger.sh
```

Copy the example into your new directory or start from the
[Zigflow examples](https://zigflow.dev/docs/examples/).
In the definition's `document` section, choose:

* `workflowType`: the name clients use to start the workflow.
* `taskQueue`: the queue the Zigflow worker polls. Keep `zigflow` or choose
  another queue.

`make dev` and the Compose worker discover workflows recursively and watch
for changes.

Every `.yaml`, `.yml` and `.json` file under `workflows/` is treated as a
workflow definition. Keep supporting files, such as input data and schemas,
outside that directory.

### Add a trigger

The included [`trigger.sh`](workflows/hello-world/trigger.sh) demonstrates
starting a workflow from the command line. Copy it alongside your definition
and update `--type` and `--task-queue` to match `workflowType` and `taskQueue`.

Optionally add a target under `Triggers` in the [`Makefile`](Makefile).
For Compose, add a service under `services` that reuses the existing trigger:

```yaml
  my-workflow:
    <<: *trigger
    command: sh /workflows/my-workflow/trigger.sh
```

The anchor supplies the image, Temporal connection settings and workflow mount.
Run the trigger with `docker compose run --rm my-workflow`.

Trigger scripts are optional. Your application can start workflows using a
[Temporal SDK](https://docs.temporal.io/develop) in its preferred language.

### Make it your own

Delete `workflows/hello-world/` and its entries in the Makefile and Compose
when you no longer need the example. If other services reference `*trigger`,
move the `&trigger` anchor to a remaining trigger service.

Replace this README with documentation for the workflows you build.

## Validate workflows

```sh
make validate
```

This checks every workflow definition without executing workflows or connecting
to Temporal. CI validates the same files, with a separate job for each file.

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/).

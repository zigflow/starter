# starter

A blank project for getting started

<!-- toc -->

* [Workflows](#workflows)
* [Contributing](#contributing)
  * [Open in a container](#open-in-a-container)
  * [Commit style](#commit-style)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Workflows

Every `.yaml`, `.yml` and `.json` file under `workflows/`, including nested
directories, is treated as a Zigflow workflow and validated.

Validate them all locally with:

```sh
make validate
```

CI validates each file as a separate job.

## Contributing

### Open in a container

* [Open in a container](https://code.visualstudio.com/docs/devcontainers/containers)

### Commit style

All commits must be done in the [Conventional Commit](https://www.conventionalcommits.org)
format.

```git
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

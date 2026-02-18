# Prerequisites

Install these before running the bootstrap one-liner.

## Required

| Tool | Minimum Version | Why |
|------|----------------|-----|
| Python | 3.12+ | Runtime for all tooling |
| Git | any | Copier clones the template repo |

## Optional (depends on project type)

| Tool | When Needed |
|------|------------|
| Terraform + tflint | IaC projects (terraform hooks will skip if not installed) |
| ShellCheck | Bash projects (auto-installed by pre-commit on most systems) |

## Recommended

| Tool | Why |
|------|-----|
| EditorConfig extension | Makes your editor match the formatting rules (Black, terraform_fmt enforce on commit regardless) |

EditorConfig support by editor:
- **VS Code**: Install the [EditorConfig for VS Code](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig) extension
- **JetBrains** (PyCharm, IntelliJ): Built-in, no plugin needed
- **Vim/Neovim**: Install [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)
- **Terminal-only users**: Not needed — pre-commit hooks enforce formatting on commit

## What You Do NOT Need to Install

- **copier** — the bootstrap script installs it automatically in a temporary venv and cleans up after
- **jinja2** — bundled with copier
- **pre-commit, pytest, black** — installed into the project's `.venv` by copier after setup

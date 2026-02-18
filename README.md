# Platform Scaffold

A [Copier](https://copier.readthedocs.io/)-based project scaffold that applies consistent engineering standards — pre-commit hooks, CI workflows, security scanning, and code formatting — to any repository in your org.

## Prerequisites

- **Python 3.12+** — the bootstrap script checks this automatically
- **Git** — any recent version

You do **not** need to install Copier, pre-commit, pytest, or Black yourself. The bootstrap script handles all of that.

## Quick Start

Run the one-liner from an **empty directory** (or the root of an existing repo):

**Linux / WSL / macOS**

```bash
curl -sL https://github.com/enthusiast/platform-scaffold/raw/main/bootstrap.sh | bash
```

**Windows (PowerShell)**

```powershell
irm https://github.com/enthusiast/platform-scaffold/raw/main/bootstrap.ps1 | iex
```

The script will prompt you for your GitHub org, project name, and template repo name, then set everything up automatically.

## What You Get

Every scaffolded project includes:

| Category | What's set up |
|----------|---------------|
| **Pre-commit hooks** | Trailing whitespace, YAML validation, large-file blocking, Python formatting (Black), Terraform fmt/validate/tflint, ShellCheck, and Gitleaks secret detection |
| **CI — Gatekeeper** | PR workflow that runs pre-commit checks, pytest, Terraform plan (if `.tf` files exist), and a security report (Bandit, Safety, Checkov) |
| **CI — Auto-updater** | Weekly workflow that opens a PR to update pre-commit hook versions |
| **PR template** | Standardised checklist covering change type, breaking changes, and quality gates |
| **EditorConfig** | Consistent indentation and line-ending rules across editors |
| **gitignore** | Python, Terraform, IDE, OS, and secrets patterns |
| **pyproject.toml** | Project metadata, dev dependencies, Black and pytest configuration |
| **Engineering Standards** | Full playbook covering repo structure, branch protection, and hook details |

## Updating

To pull the latest template changes into an existing project:

```bash
copier update
```

This merges template updates while preserving your local changes. It relies on the `.copier-answers.yml` file that was created during the initial scaffold — don't delete it.

## Repo Structure

The repo has two layers:

```
├── copier.yml              # Scaffold config: questions, post-copy tasks, metadata
├── bootstrap.sh            # Linux/macOS bootstrap script
├── bootstrap.ps1           # Windows bootstrap script
├── PREREQUISITES.md        # What users need installed before running bootstrap
└── template/               # Everything that lands in downstream projects
    ├── .editorconfig
    ├── .gitignore
    ├── .pre-commit-config.yaml
    ├── ENGINEERING_STANDARDS.md.jinja
    ├── README.md.jinja
    ├── pyproject.toml.jinja
    └── .github/
        ├── pull_request_template.md
        └── workflows/
            ├── gatekeeper.yml
            └── autoupdate-precommit.yml
```

- **Root files** — scaffold configuration and documentation. These are never copied into downstream projects.
- **`template/`** — everything inside this directory is copied into the target repo by Copier.
- **`.jinja` suffix** — files that contain `{{ variable }}` placeholders. Copier replaces these with the answers you provide during setup (org name, project name, etc.) and strips the `.jinja` extension.

## How It Works

When you run the bootstrap one-liner:

1. The script checks that Python 3.12+ and Git are installed
2. A temporary virtualenv is created and Copier is installed into it
3. `copier copy` runs — you answer three questions (GitHub org, project name, template repo name)
4. Template files are copied and `.jinja` placeholders are filled in
5. Post-copy tasks run automatically:
   - A project virtualenv (`.venv/`) is created
   - Dev dependencies (pre-commit, pytest, Black) are installed
   - Pre-commit hooks are installed into the local Git repo
6. The temporary Copier virtualenv is cleaned up
7. You activate your project with `source .venv/bin/activate` and start working

## Customization

To adapt this scaffold for a different org or tech stack:

1. **Fork this repo** into your org
2. **Update `copier.yml`** — change or add questions (e.g., add a language selector, team slug inputs)
3. **Edit files in `template/`** — add, remove, or modify the files that land in downstream repos
4. **Update the bootstrap scripts** — change the `TEMPLATE_REPO` variable to point to your fork
5. **Update `.jinja` files** — adjust templated content to match your standards

See [ENGINEERING_STANDARDS.md.jinja](template/ENGINEERING_STANDARDS.md.jinja) for the full playbook that ships with every scaffolded project.

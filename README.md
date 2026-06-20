# nma

## Python Guide

### Ruff formatting & linting

```bash
# Lint files
ruff check --fix path/to/software

# Fail if files not linted
ruff check path/to/software

# Format files
ruff format path/to/software

# Fail if files not formatted
ruff format --check path/to/software
```

### SQLFluff formatting & linting

```bash
# Lint files
sqlfluff format path/to/software

# Fail if files not linted
sqlfluff lint path/to/software
```

## R Guide

### File formatting & linting

```bash
styler::style_dir("path/to/software")
lintr::lint_dir("path/to/software")
```

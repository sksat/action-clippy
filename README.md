# action-clippy

## Example workflow

```yaml
name: reviewdog / clippy
on: pull_request
jobs:
  clippy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: install clippy
        uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
          override: true
          components: clippy

      - uses: sksat@action-clippy@main
        with:
          reporter: github-pr-review
```

## Inputs

| Name                | Required | Description | Default |
| ------------------- | :------: | ----------- | ------- |
| `github_token`      | ✓ | GitHub secret token | `${{ github.token }}` |
| `working_directory` |   | clippy working directory | |
| `tool_name`         | ✓ | Tool name to use for reviewdog reporte | `clippy` |
| `level`             | ✓ | Report level for reviewdog [info,warning,error] | `warning` |
| `reporter`          | ✓ | Reporter of reviewdog command [github-pr-check,github-pr-review,github-check] | `github-pr-check` |
| `filter_mode`       | ✓ | Filtering mode for the reviewdog command [added,diff_context,file,nofilter] | `added` |
| `fail_on_error`     | ✓ | Exit code for reviewdog when errors are found | `false` |
| `reviewdog_flags`   |   | Additional reviewdog flags | |
| `clippy_flags`      |   | Additional clippy flags | |

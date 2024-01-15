#!/bin/bash
set -eo pipefail

cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}"

cargo clippy --message-format human ${INPUT_CLIPPY_FLAGS}

cargo clippy --message-format json ${INPUT_CLIPPY_FLAGS} 2>&1 \
  | clippy-reviewdog-filter \
  | reviewdog \
    -f=checkstyle \
    -name="${INPUT_TOOL_NAME}" \
    -level="${INPUT_LEVEL}" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" \
    -filter-mode="${INPUT_FILTER_MODE}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
    ${INPUT_REVIEWDOG_FLAGS}

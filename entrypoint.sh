#!/bin/bash
set -eo pipefail

cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}"

cargo clippy --message-format human ${INPUT_CLIPPY_FLAGS}

# Rust ignore SIGPIPE by default: https://github.com/rust-lang/rust/issues/62569
# This causes `Broken pipe` error when piping to `clippy-reviewdog-filter`
cargo clippy --message-format json ${INPUT_CLIPPY_FLAGS} 2>&1 \
  | clippy-reviewdog-filter \
  > /tmp/clippy-checkstyle.xml

reviewdog \
    -f=checkstyle \
    -name="${INPUT_TOOL_NAME}" \
    -level="${INPUT_LEVEL}" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" \
    -filter-mode="${INPUT_FILTER_MODE}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
    ${INPUT_REVIEWDOG_FLAGS} \
    < /tmp/clippy-checkstyle.xml

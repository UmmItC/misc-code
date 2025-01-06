#!/bin/bash

# Find all files with .md extension and rename them to index.md
find . -type f -name "*.md" -exec bash -c 'mv "$0" "${0%/*}/index.md"' {} \;

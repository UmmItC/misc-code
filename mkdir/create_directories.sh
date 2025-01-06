#!/bin/bash

# Find all Markdown files
find . -name "*.md" | while read -r markdown_file; do
    (
        # Get the directory path of the Markdown file
        dir_path=$(dirname "${markdown_file}")

        # Extract the filename without the extension
        filename_no_ext=$(basename "${markdown_file}" .md)

        # Create a directory with the same name as the Markdown file (without the extension)
        mkdir -p "${dir_path}/${filename_no_ext}"

        # Change into the newly created directory and perform any operations
        cd "${dir_path}/${filename_no_ext}" || exit

        # Go back to the original directory
        cd - || exit
    )
done

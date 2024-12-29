#!/bin/bash

# Prompt the user for a commit message
read -p "Enter commit message: " commit_message

# Stage all changes
git add .

# Commit with the provided message
git commit -m "$commit_message"

# Push changes to the remote repository
git push

echo "Changes have been committed and pushed successfully."

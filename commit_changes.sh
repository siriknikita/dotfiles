#!/usr/bin/env bash

# Get the list of changed files and directories
changed_items=$(git status --porcelain | awk '{print $2}')

# Initialize arrays for folders and files
declare -A folders
files=()

# Process each changed item
for item in $changed_items; do
  if [[ -d $item ]]; then
    # If it's a directory, get the root folder
    root_folder=$(echo $item | cut -d'/' -f1)
    folders["$root_folder"]=1
  else
    # If it's a file, check its depth
    depth=$(echo $item | awk -F'/' '{print NF}')
    if [[ $depth -gt 1 ]]; then
      root_folder=$(echo $item | cut -d'/' -f1)
      folders["$root_folder"]=1
    else
      files+=("$item")
    fi
  fi
done

# Form the commit message
commit_message="Add"
for folder in "${!folders[@]}"; do
  commit_message+=" $folder,"
done
for file in "${files[@]}"; do
  commit_message+=" $file,"
done

# Remove the trailing comma
commit_message=${commit_message%,}

# Add all changes
git add .

# Commit the changes with the formed commit message
git commit -m "$commit_message"

# Push the changes to origin master
git push origin master

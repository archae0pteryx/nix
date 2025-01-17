#!/bin/bash

# Set the source and output directories
SOURCE_DIR="$HOME/Code"
OUTPUT_DIR="$HOME/tmp-backup"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Find all tmp directories under SOURCE_DIR up to 6 levels deep
find "$SOURCE_DIR" -mindepth 1 -maxdepth 6 \( -name node_modules -o -name .venv -o -name .git \) -prune -o -type d -name tmp -print | while read -r tmp_dir; do
    # Get the relative path from SOURCE_DIR to the tmp directory
    rel_path="${tmp_dir#$SOURCE_DIR/}"

    # Get the root project directory (first component of rel_path)
    root_project_dir=$(echo "$rel_path" | cut -d'/' -f1)

    # Get the sub-path after the root project directory, excluding 'tmp'
    sub_path=$(dirname "$rel_path" | cut -d'/' -f2-)

    # Define the destination directory
    dest_dir="$OUTPUT_DIR/$root_project_dir/$sub_path"

    # Create the destination directory if it doesn't exist
    mkdir -p "$dest_dir"

    # Copy the contents of tmp/ to the destination directory
    # -r: recursive copy
    # -n: do not overwrite existing files
    cp -r -n "$tmp_dir/." "$dest_dir/"

    echo "Copied tmp/ from $tmp_dir to $dest_dir"
done


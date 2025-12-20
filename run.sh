#!/bin/bash

# Check if a directory is passed as an argument
if [[ -z "$1" ]]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Assign the first argument to a variable
directory="$1"

# Check if the directory exists
if [[ ! -d "$directory" ]]; then
  echo "Error: Directory '$directory' does not exist."
  exit 1
fi

# Iterate over matching files in the specified directory
for file in "$directory"/solution-*.rb; do
  # Skip if no files match
  [[ -e "$file" ]] || { echo "No matching files found in '$directory'."; exit 1; }

  # Extract just the filename from the full path
  filename=$(basename "$file")

  start_time=$(date +%s.%N) # Record the start time

  # Change to the directory of the Ruby script and run the script
  cd "$directory" && ruby "$filename" > /dev/null 2>&1
  cd ..

  end_time=$(date +%s.%N)   # Record the end time
  elapsed_time=$(awk "BEGIN {print $end_time - $start_time}") # Calculate elapsed time

  # Print a dot for every file that runs successfully
  echo -n "."

  # Check if elapsed time > 1 second, and if so, print it
  if (( $(awk "BEGIN {print ($elapsed_time > 1)}") )); then
    printf "\nFile $filename took ${elapsed_time} seconds to run\n"
  fi
done

# Print a newline after all dots
echo

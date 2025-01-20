#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to the pg_dump binary
PG_DUMP="$SCRIPT_DIR/pg_dump"

# Check if the pg_dump binary exists
if [[ ! -f "$PG_DUMP" ]]; then
  echo "Error: pg_dump binary not found in $SCRIPT_DIR"
  exit 1
fi

# Ensure the pg_dump binary is executable
if [[ ! -x "$PG_DUMP" ]]; then
  echo "pg_dump is not executable. Attempting to make it executable..."
  chmod +x "$PG_DUMP" || {
    echo "Error: Failed to make pg_dump executable. Check permissions."
    exit 1
  }
  echo "pg_dump is now executable."
fi

# Parse PostgreSQL connection arguments
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <pg_dump_arguments>"
  echo "Example: $0 -U postgres -d mydatabase > backup.sql"
  exit 1
fi

# Run the pg_dump binary with the provided arguments
"$PG_DUMP" "$@"

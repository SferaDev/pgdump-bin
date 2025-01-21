path="$(print=1 import "./pg_dump")"

# Check if the pg_dump binary exists
if [[ ! -f "$path" ]]; then
  echo "Error: pg_dump binary not found"
  exit 1
fi

# Ensure the pg_dump binary is executable
if [[ ! -x "$path" ]]; then
  echo "pg_dump is not executable. Attempting to make it executable..."
  chmod +x "$path" || {
    echo "Error: Failed to make pg_dump executable. Check permissions."
    exit 1
  }
  echo "pg_dump is now executable."
fi

# Run the pg_dump binary with the provided arguments
"$path" "$@"

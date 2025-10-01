#!/bin/bash

# Thanks Gemini
# This script stores a secret using the secret-tool command.
# If a secret string is provided as an argument, it will be used.
# If no argument is provided, a random string between 70 and 90 characters will be generated.
# Use the -o flag to overwrite/update the secret if it already exists.
# Use the -h flag to display the help message.

# --- Configuration ---
SECRET_LABEL="SuiteCloud CLI"
SECRET_SERVICE_KEY="sdfcli"
# ---------------------

overwrite=false

# Function to print the usage message
usage() {
  echo "Usage: $0 [-o] [-h] [secret_string]"
  echo "Stores a secret using secret-tool."
  echo
  echo "Arguments:"
  echo "  secret_string   The secret to store. If not provided, a random one is generated."
  echo
  echo "Options:"
  echo "  -o              Overwrite the secret if it already exists."
  echo "  -h              Display this help message and exit."
  exit 0
}

# Use getopts to parse the flags
while getopts ":oh" opt; do
  case ${opt} in
    o )
      overwrite=true
      ;;
    h )
      usage
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))


# Check if the secret already exists by trying to look it up.
# Redirect output to /dev/null to keep the check silent.
secret-tool lookup service "$SECRET_SERVICE_KEY" >/dev/null 2>&1

# If the secret exists (exit code 0) and the overwrite flag is false, then exit.
if [ $? -eq 0 ] && [ "$overwrite" = false ]; then
  echo "A secret with service '$SECRET_SERVICE_KEY' already exists. Use -o to overwrite."
  exit 0
fi

secret_value=""
# Check if the user has provided a secret string argument.
if [ -z "$1" ]; then
  # If no argument is provided, generate a random string between 70 and 90 characters.
  random_length=$(( RANDOM % 21 + 70 ))
  echo "No secret string provided. Generating a random string."
  # LC_ALL=C is used for performance and to avoid locale issues.
  # tr -dc 'a-zA-Z0-9' deletes all characters that are not alphanumeric.
  # /dev/urandom provides a stream of random bytes.
  # head -c takes the first N characters from the stream.
  secret_value=$(LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c $random_length)
else
  # Use the provided argument.
  secret_value="$1"
fi

# Otherwise, store (or update) the secret.
# The secret value is passed from the secret_value variable via standard input.
# --label sets the human-readable label for the secret.
# 'service' and 'testkey' are the key-value pair attributes for the secret.
echo -n "$secret_value" | secret-tool store --label="$SECRET_LABEL" service "$SECRET_SERVICE_KEY"
echo "Secret has been successfully stored/updated."
echo "You can retrieve it using: secret-tool lookup service $SECRET_SERVICE_KEY"



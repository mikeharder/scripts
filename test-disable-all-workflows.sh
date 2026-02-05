#!/usr/bin/env bash

# Test script for disable-all-workflows.js with mocked gh CLI
# This script creates a mock gh command that simulates API responses

set -euo pipefail

# Create a temporary directory for our mock
MOCK_DIR=$(mktemp -d)
trap "rm -rf $MOCK_DIR" EXIT

# Create a mock gh command
cat > "$MOCK_DIR/gh" << 'EOF'
#!/usr/bin/env bash

# Mock gh CLI for testing

if [[ "$1" == "auth" && "$2" == "status" ]]; then
  # Simulate successful auth
  exit 0
fi

if [[ "$1" == "api" ]]; then
  if [[ "$*" == *"/actions/workflows"* && "$*" != *"/disable"* ]]; then
    # Check if jq filter is requested (simulates --jq)
    if [[ "$*" == *"--jq"* ]]; then
      # Return just the IDs of active workflows (simulating the jq filter)
      echo "12345"
      echo "67890"
      exit 0
    else
      # Return mock workflow list with active workflows
      cat << 'JSON'
{
  "workflows": [
    {
      "id": 12345,
      "name": "CI",
      "state": "active"
    },
    {
      "id": 67890,
      "name": "Release",
      "state": "active"
    },
    {
      "id": 11111,
      "name": "Disabled Workflow",
      "state": "disabled"
    }
  ]
}
JSON
      exit 0
    fi
  elif [[ "$*" == *"/disable"* ]]; then
    # Simulate successful disable
    exit 0
  fi
fi

echo "Unexpected gh command: $*" >&2
exit 1
EOF

chmod +x "$MOCK_DIR/gh"

# Add mock to PATH
export PATH="$MOCK_DIR:$PATH"

# Verify mock is in place
if ! command -v gh &> /dev/null; then
  echo "❌ Failed to set up mock gh command"
  exit 1
fi

echo "✅ Mock gh CLI is set up"
echo ""

# Test 1: Run the script with mock data
echo "Test 1: Running disable-all-workflows.js with mock owner/repo"
if node /home/runner/work/scripts/scripts/disable-all-workflows.js test-owner test-repo; then
  echo "✅ Test 1 passed"
else
  echo "❌ Test 1 failed"
  exit 1
fi

echo ""

# Test 2: Verify script requires correct arguments
echo "Test 2: Verify script requires arguments"
OUTPUT=$(node /home/runner/work/scripts/scripts/disable-all-workflows.js 2>&1 || true)
if echo "$OUTPUT" | grep -q "Usage"; then
  echo "✅ Test 2 passed"
else
  echo "❌ Test 2 failed - should show usage message"
  exit 1
fi

echo ""
echo "✅ All tests passed!"

#!/usr/bin/env bash
set -euo pipefail

TABLE_NAME="Users"

echo "[init] waiting for localstack dynamodb..."
sleep 2

# ensure awslocal is available
if ! command -v awslocal >/dev/null 2>&1; then
  echo "[init] awslocal not found in container PATH. Exiting."
  exit 1
fi

if awslocal dynamodb list-tables --region ap-northeast-1 | grep -q "\"${TABLE_NAME}\""; then
  echo "[init] table ${TABLE_NAME} already exists"
else
  echo "[init] creating ${TABLE_NAME}"
  awslocal dynamodb create-table \
    --region ap-northeast-1 \
    --table-name "${TABLE_NAME}" \
    --attribute-definitions AttributeName=user_id,AttributeType=S \
    --key-schema AttributeName=user_id,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST

  # wait until table becomes ACTIVE
  echo "[init] waiting for table to become ACTIVE..."
  for i in $(seq 1 20); do
    status=$(awslocal dynamodb describe-table --table-name "${TABLE_NAME}" --query "Table.TableStatus" --output text 2>/dev/null || true)
    if [ "${status}" = "ACTIVE" ]; then
      echo "[init] table is ACTIVE"
      break
    fi
    sleep 1
  done

  # enable TTL on attribute 'ttl'
  echo "[init] enabling TTL on attribute 'ttl'"
  awslocal dynamodb update-time-to-live \
    --region ap-northeast-1 \
    --table-name "${TABLE_NAME}" \
    --time-to-live-specification "Enabled=true,AttributeName=ttl"

  echo "[init] created ${TABLE_NAME} and enabled TTL"
fi

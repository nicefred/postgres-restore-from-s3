#! /bin/sh

set -e

if [ "${S3_ACCESS_KEY_ID}" = "**None**" ]; then
  echo "You need to set the S3_ACCESS_KEY_ID environment variable."
  exit 1
fi

if [ "${S3_SECRET_ACCESS_KEY}" = "**None**" ]; then
  echo "You need to set the S3_SECRET_ACCESS_KEY environment variable."
  exit 1
fi

if [ "${S3_BUCKET}" = "**None**" ]; then
  echo "You need to set the S3_BUCKET environment variable."
  exit 1
fi

if [ "${S3_PATH_TO_BACKUP}" = "**None**" ]; then
  echo "You need to set the S3_PATH_TO_BACKUP environment variable."
  exit 1
fi

if [ "${POSTGRES_DATABASE}" = "**None**" ]; then
  echo "You need to set the POSTGRES_DATABASE environment variable."
  exit 1
fi

if [ "${POSTGRES_HOST}" = "**None**" ]; then
  echo "You need to set the POSTGRES_HOST environment variable."
  exit 1
fi

if [ "${POSTGRES_USER}" = "**None**" ]; then
  echo "You need to set the POSTGRES_USER environment variable."
  exit 1
fi

if [ "${POSTGRES_PASSWORD}" = "**None**" ]; then
  echo "You need to set the POSTGRES_PASSWORD environment variable or link to a container named POSTGRES."
  exit 1
fi

# env vars needed for aws tools
export AWS_ACCESS_KEY_ID=${S3_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${S3_SECRET_ACCESS_KEY}
export AWS_DEFAULT_REGION=${S3_REGION}

export PGPASSWORD=${POSTGRES_PASSWORD}
POSTGRES_HOST_OPTS="-h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER"

echo "Downloading dump from $S3_BUCKET"

aws s3 cp s3://${S3_BUCKET}/${S3_PATH_TO_BACKUP} dump.sql.gz

echo "Extracting SQL file"
gunzip dump.sql.gz

echo "Restoring by running dump file from S3 on ${POSTGRES_DATABASE} database from ${POSTGRES_HOST}..."

psql ${POSTGRES_HOST_OPTS} -d ${POSTGRES_DATABASE} -f dump.sql
echo "SQL backup restored successfully"

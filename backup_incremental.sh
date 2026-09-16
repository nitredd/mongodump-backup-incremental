#!/usr/bin/env bash

MONGO_URI="mongodb://localhost"
DB_NAME="hr"
COLL_NAME=("people" "departments")

# TODO 1: Make date-time dynamic (1 hour ago in UTC ISO-8601 format)
if date -u -d "1 hour ago" +"%Y-%m-%dT%H:%M:%SZ" >/dev/null 2>&1; then
    # GNU date (Linux)
    ONE_HOUR_AGO=$(date -u -d "1 hour ago" +"%Y-%m-%dT%H:%M:%SZ")
else
    # BSD date (macOS)
    ONE_HOUR_AGO=$(date -u -v-1H +"%Y-%m-%dT%H:%M:%SZ")
fi

# Note that an index is needed for better performance
QUERY='{"createdAt": {"$gt": {"$date": "'"$ONE_HOUR_AGO"'"}}}'

# Date suffix in yyyymmdd format
DATE_SUFFIX=$(date +"%Y%m%d%H%M%S")

# Iterate through array elements (using "${COLL_NAME[@]}")
for ITERCOLL in "${COLL_NAME[@]}"
do
    # TODO 2: Add timestamp suffix in yyyymmdd format to filename
    FILENAME="/backup/${DB_NAME}_${ITERCOLL}_${DATE_SUFFIX}.archive.gz"

    # Run mongodump (using $ITERCOLL for the collection

    mongodump \
       --uri="$MONGO_URI" \
       --db="$DB_NAME" \
       --collection="$ITERCOLL" \
       --query="$QUERY" \
       --archive="$FILENAME" \
       --readPreference=secondary \
       --gzip

    echo "\
    URI: ${MONGO_URI}
    DB: ${DB_NAME}
    COLL: ${ITERCOLL}
    QUERY: ${QUERY}
    ARCHIVE: ${FILENAME}    
    "
done

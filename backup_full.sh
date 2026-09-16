#!/usr/bin/env bash

MONGO_URI="mongodb://localhost"  # Use /?directConnection=true to target a specific server
DB_NAME="hr"
# COLL_NAME=("people" "departments")  # Our full snapshot can include all collections

# Date suffix in yyyymmdd format
DATE_SUFFIX=$(date +"%Y%m%d")

# # Iterate through array elements (using "${COLL_NAME[@]}")
# for ITERCOLL in "${COLL_NAME[@]}"
# do
    # TODO 2: Add timestamp suffix in yyyymmdd format to filename
    ITERCOLL=all
    FILENAME="/backup/${DB_NAME}_${ITERCOLL}_${DATE_SUFFIX}_full.archive.gz"

    # Run mongodump (using $ITERCOLL for the collection)
    mongodump \
        --uri="$MONGO_URI" \
        --db="$DB_NAME" \
#         --collection="$ITERCOLL" \
        --archive="$FILENAME" \
        --readPreference=secondary \
        --gzip

    echo "\
    URI: ${MONGO_URI}
    DB: ${DB_NAME}
    COLL: ${ITERCOLL}
    ARCHIVE: ${FILENAME}    
    "
# done

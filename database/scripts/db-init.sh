#!/bin/bash
set -x -e
if [[ -z "$ZUSDB_ENGINE_PASSWORD" ]] || [[ -z "$ZUSDB_WWW_PASSWORD" ]] || [ -z "$ZUSDB_DATABASE" ] ; then
 echo "Environment variables ZUSDB_ENGINE_PASSWORD, ZUSDB_WWW_PASSWORD, and ZUSDB_DATABASE must be set"
 exit 1
fi
OPTIONS="--echo-all -v ON_ERROR_STOP=1"
echo "Create Database..."
createdb "${ZUSDB_DATABASE}" "Omniwallet wallet and transaction database"
echo "Init Schema..."
psql $OPTIONS -f ../omni_db_schema.psql ${ZUSDB_DATABASE}
echo "Add intial data..."
psql $OPTIONS -f ../omni_db_initialize_data.psql ${ZUSDB_DATABASE}
echo "Configure users and permissions..."
psql $OPTIONS -f ../omni_db_createusers.psql \
    --variable=omniengine=${ZUSDB_ENGINE_USER} \
    --variable=omnienginePassword=\'${ZUSDB_ENGINE_PASSWORD}\' \
    --variable=omniwww=${ZUSDB_WWW_USER} \
    --variable=omniwwwPassword=\'${ZUSDB_WWW_PASSWORD}\' ${ZUSDB_DATABASE}


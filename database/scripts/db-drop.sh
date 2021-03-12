#!/bin/sh
set -x -e
if [[ -z "$ZUSDB_ENGINE_PASSWORD" ]] || [[ -z "$ZUSDB_WWW_PASSWORD" ]] || [ -z "$ZUSDB_DATABASE" ] ; then
 echo "Environment variables ZUSDB_ENGINE_PASSWORD, ZUSDB_WWW_PASSWORD, and ZUSDB_DATABASE must be set"
 exit 1
fi

dropdb --echo --if-exists  ${ZUSDB_DATABASE}

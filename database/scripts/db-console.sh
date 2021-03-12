#!/bin/sh
set -x -e
if [ -z "$ZUSDB_DATABASE" ] ; then
 echo "Environment variable ZUSDB_DATABASE must be set"
 exit 1
fi

psql ${ZUSDB_DATABASE}



#!/bin/bash -e

echo "Run backup"
date=$(date "+%Y-%m-%dT%H:%M:%SZ")
filename=${BACKUP_FILE_PREFIX}-${date}



if [[ -z "${MONGO_PASSWORD}" ]]; then
  mongodump --host="${MONGO_HOST}" --port="${MONGO_PORT}" --username="${MONGO_USER}" --authenticationDatabase="${MONGO_AUTHENTICATION_DATABASE}" --out=/temp/backup
else
  mongodump --host="${MONGO_HOST}" --port="${MONGO_PORT}" --username=${MONGO_USER} --password=${MONGO_PASSWORD} --authenticationDatabase="${MONGO_AUTHENTICATION_DATABASE}" --out=/temp/backup
fi

tar -czvf /temp/${filename}.tar.gz /temp/backup

gcloud auth activate-service-account --key-file=${GCS_KEYFILE_PATH}
gsutil -o "GSUtil:state_dir=/temp/.gsutil" cp /temp/${filename}.tar.gz ${GCS_BUCKET}/${filename}.tar.gz

echo "Finished backup"
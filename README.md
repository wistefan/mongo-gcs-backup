# Backup mongo to gcs

A simple job to backup a complete mongodb instance into gcs-bucket. 

## Config

Following environment  variables are supported:

|  Env-Var | Description | Default |
| ----------------- | ----------------------------------------------- | ------------------------ |             
| BACKUP_FILE_PREFIX | Prefix to be used for the tar-file. Will create a name in form of ```<Prefix>-<date>.tar.gz```     |  backup   |
| GCS_KEYFILE_PATH | Path to the serviceaccount json file to be used for the bucket. | /gcs/credentials.json |
| GCS_BUCKET | Name of the backet to be used. | null |
| MONGO_HOST | Host of the mongo instance | localhost  |
| MONGO_PORT | Port of the mongo instance | 27017  |
| MONGO_USER | User for accessing the mongo instance | root  |
| MONGO_PASSWORD | Password for accessing the mongo instance | null  |
| MONGO_AUTHENTICATION_DATABASE | Database to be used for accessing the mongo instance | admin  |
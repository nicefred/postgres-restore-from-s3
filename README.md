# postgres-restore-from-s3

A docker image that can restore a backup from S3

Inspired by 
https://github.com/schickling/dockerfiles/tree/master/postgres-backup-s3 

## Usage

```sh
$ docker run -e S3_ACCESS_KEY_ID=key -e S3_SECRET_ACCESS_KEY=secret -e S3_BUCKET=my-bucket -e S3_PATH_TO_BACKUP=backups/mybackup.sql.gz -e POSTGRES_DATABASE=dbname -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -e POSTGRES_HOST=linked_db --link db_container:linked_db nicefred/postgres-restore-from-s3
```

## Automated build 

The image is available at Docker Hub here: https://hub.docker.com/r/nicefred/postgres-restore-from-s3/

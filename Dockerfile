FROM alpine:3.2
MAINTAINER Fredrik Jonsson "fredrik@nicefred.se"

ADD install.sh install.sh
RUN sh install.sh && rm install.sh

ENV POSTGRES_DATABASE **None**
ENV POSTGRES_HOST **None**
ENV POSTGRES_PORT 5432
ENV POSTGRES_USER **None**
ENV POSTGRES_PASSWORD **None**
ENV S3_ACCESS_KEY_ID **None**
ENV S3_SECRET_ACCESS_KEY **None**
ENV S3_BUCKET **None**
ENV S3_REGION us-west-1
ENV S3_PATH_TO_BACKUP **None**

ADD restore.sh restore.sh

CMD ["sh", "restore.sh"]

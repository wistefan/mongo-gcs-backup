FROM mongo:3.6.23

ARG CLOUD_SDK_VERSION=338.0.0

ENV BACKUP_FILE_PREFIX=mongodump
ENV GCS_KEYFILE_PATH=/gcs/credentials.json
ENV MONGO_HOST=localhost
ENV MONGO_PORT=27017
ENV MONGO_USER=root
ENV MONGO_AUTHENTICATION_DATABASE=admin

RUN apt-get update
RUN apt-get install -y python3 curl


# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
ENV CLOUDSDK_CONFIG=/temp/.gcloud

ADD sh /sh
RUN mkdir /temp
RUN chmod -R a+rw /temp
RUN chmod -R +x /sh

ENTRYPOINT ["/sh/backup-to-gcs.sh"]
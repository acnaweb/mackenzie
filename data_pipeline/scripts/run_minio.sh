#!/bin/bash

# clone MinIO from GitHub
git clone https://github.com/acnaweb/minio.git

# switch into MinIO directory
cd minio

# start MinIO
docker compose up
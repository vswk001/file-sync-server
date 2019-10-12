#FROM instrumentisto/rsync-ssh
FROM alpine:3.10.2

MAINTAINER VSWK <vswk001@gmail.com>


RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
            rsync \
            openssh-client \
            inotify-tools \
 && rm -rf /var/cache/apk/*

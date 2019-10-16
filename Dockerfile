FROM alpine:3.10.2

MAINTAINER VSWK <vswk001@gmail.com>

RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
            rsync \
            openssh-client \
            inotify-tools \
            bash \
 && rm -rf /var/cache/apk/*

ADD my_rsyncd.conf /etc/my_rsyncd.conf

ADD sync_run.sh /sync_run.sh
RUN chmod 755 /sync_run.sh

WORKDIR /sync_dir

CMD ["/sync_run.sh"]

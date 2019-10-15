#!/bin/sh

#
# Script options (exit script on command fail).
#
#set -e

INOTIFY_EVENTS_DEFAULT="create,delete,modify,move,attrib"
INOTIFY_OPTONS_DEFAULT="-mrq"
SYNC_DIR=/sync_dir/

#
# Display settings on standard out.
#
echo "inotify settings"
echo "================"
echo
echo "  HOSTS:            ${HOSTS}"
echo "  SYNC_DIR:         ${SYNC_DIR}"
echo "  Inotify_Events:   ${INOTIFY_EVENTS:=${INOTIFY_EVENTS_DEFAULT}}"
echo "  Inotify_Options:  ${INOTIFY_OPTONS:=${INOTIFY_OPTONS_DEFAULT}}"
echo

#
# rsync part.
#
rm -f /var/run/rsyncd.pid
/usr/bin/rsync --daemon --config=/etc/my_rsyncd.conf

#
# Inotify part.
#
echo "[Starting inotifywait...]"
inotifywait -e ${INOTIFY_EVENTS} ${INOTIFY_OPTONS} --timefmt '%d/%m/%y %H:%M' --format '%T %w%f' "${SYNC_DIR}" | while read -r notifies
    do
        for host in ${HOSTS}
        do
            rsync -azP --delete ${SYNC_DIR} ${host}::sync_part
            echo "${notifies} was rsynced" >> /tmp/rsync.log 2>&1
        done
    done

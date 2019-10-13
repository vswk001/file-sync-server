# file-sync-server
docker  + rsync + inotify-tools 

# Usage
docker network create --driver bridge my_net

docker run -d --network=my_net --name file-sync-1 -v <host1_dir>:/sync_dir -e "HOSTS=file-sync-2" vswk001/file-sync-server

docker run -d --network=my_net --name file-sync-2 -v <host2_dir>:/sync_dir -e "HOSTS=file-sync-1" vswk001/file-sync-server

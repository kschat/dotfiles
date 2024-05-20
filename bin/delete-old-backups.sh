#!/usr/bin/env bash

sudo --validate

# keep permissions for the duration of the script
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

set -e

cd /mnt/nas/desktop-backup/
# cd ./test-dir

pids=()
i=0
limit=30

for dir in */; do
  (( i += 1 ))

  echo "Deleting: ${dir}"
  (rsync -a --delete empty/ "./${dir}"; sudo renice -20 -p $!; rm -rf "${dir}") &

  pids+=($!)

  [[ $i -ge $limit ]] && break;
done

for pid in ${pids[*]}; do
    wait $pid
done

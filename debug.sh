. project.cfg

debug_name="debug-$name"
docker stop "$debug_name" > /dev/null 2>&1
docker rm "$debug_name" > /dev/null 2>&1

docker run -it \
  --name="$debug_name" \
  --entrypoint='' \
  --mount type=bind,source="$(realpath '/Users/michael/Dropbox (Personal)/Work (Documentacion)/ECS Digital/Projects/ECS/BCGDV Tracr/tracr-terraform/terraconf/stack/test-stack')",destination='/work' \
  "$repo":latest \
  sh

# Some "docker run" options for quick reference:
#  --env VARIABLE=value
#  --publish, -p HOST_PORT:CONTAINER_PORT
#  --volume=[HOST_PATH|NAMED_VOLUME]:DEST_PATH[:ro]
#  --mount type=bind,source=HOST_PATH,destination=DEST_PATH[,readonly]
#  --mount type=volume[,source=NAMED_VOLUME],destination=DEST_PATH[,readonly]
#  --mount type=tmpfs,destination=DEST_PATH
#
# NB:
#  - Volume will create DEST_PATH if it doesn't already exist
#  - Mount and Volume require absolute paths
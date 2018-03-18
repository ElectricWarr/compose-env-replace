./build.sh > /dev/null || exit 1

. project.cfg

docker run --rm \
  --name="$name" \
  --mount type=bind,source='/Users/michael/Dropbox (Personal)/Programming/docker/projects/compose-var-munge/scripts',destination='/scripts',readonly \
  --mount type=bind,source="$(realpath '/Users/michael/Dropbox (Personal)/Work (Documentacion)/ECS Digital/Projects/ECS/BCGDV Tracr/tracr-terraform/terraconf/stack/test-stack')",destination='/work' \
  "$repo":latest \
  "$@"

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

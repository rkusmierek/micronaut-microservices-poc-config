USAGE="$(basename $0) tag"

[ "$1" ] || {
    echo "Service version (tag) is missing!"
    echo "Usage: $USAGE"
    exit 1
}

TAG=$1

sed -ri "s|(image: [^:]*):.*|\1:${TAG}|" ./app/base/*/*-service-deployment.yml

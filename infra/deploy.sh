BASE=`dirname $0`

wait-for() {
    RESOURCE_TYPE=$1
    RESOURCE_NAME=$2
    REPLICAS=0
    until [ $(kubectl get ${RESOURCE_TYPE} -o json |jq -c ".items[] | select(.status.readyReplicas == 1 and .metadata.name == \"${RESOURCE_NAME}\")" | jq .metadata.name | wc -l) -gt 0 ]; do
      echo waiting
      sleep 2
    done
}

kubectl apply -k ${BASE}/base/zookeeper
echo "waiting for zookeeper to start"
wait-for statefulset zookeeper
# workaround for missing zk readiness probe
sleep 5

kubectl apply -k ${BASE}/base/elasticsearch
kubectl apply -k ${BASE}/base/jsreport
kubectl apply -k ${BASE}/base/kafka
kubectl apply -k ${BASE}/base/mongo
kubectl apply -k ${BASE}/base/zipkin

echo "waiting for kafka-manager to start"
wait-for deployment kafka-manager
echo "waiting for kafka-server to start"
wait-for statefulset kafka-server


#!/bin/bash
STATUS=""
SLEEP_TIME=30
LIMIT=30
RETRIES=0

sleep 120

while [ "$RETRIES" -le "$LIMIT" ]; do
    STATUS=$(kubectl get storagecluster px-cluster -n kube-system -o jsonpath='{.status.phase}')
    if [ "$STATUS" == "Online" ]; then
        CLUSTER_ID=$(kubectl get storagecluster px-cluster -n kube-system -o jsonpath='{.status.clusterUid}')
        printf "[SUCCESS] Portworx Storage Cluster is Online. Cluster ID: ($CLUSTER_ID)\n"
        break
    fi
    printf "[INFO] Portworx Storage Cluster Status: [ $STATUS ]\n"
    printf "[INFO] Waiting for Portworx Storage Cluster. (Retry in $SLEEP_TIME secs)\n"
    ((RETRIES++))
    sleep $SLEEP_TIME
done

if [ "$RETRIES" -gt "$LIMIT" ]; then
    printf "[ERROR] All Retries Exhausted!\n"
    exit 1
fi

RETRIES=0
PODS_COUNT=$(kubectl get pods -l name=portworx -n kube-system | wc -l | xargs)
while [ "$RETRIES" -le "$LIMIT" ]; do
    READY_COUNT=$(kubectl get pods -l name=portworx -n kube-system -o json | jq -r '.items[] | select(.status.conditions[].type=="Ready") | .metadata.name' | wc -l | xargs)
    if [ "$PODS_COUNT" == "$READY_COUNT" ]; then
        printf "[SUCCESS] All Portworx Pods are up and running\n"
        break
    fi
    printf "[INFO] Portworx Pods Status: [ $READY_COUNT/$PODS_COUNT ]\n"
    printf "[INFO] Waiting for All Portworx Pods. (Retry in $SLEEP_TIME secs)\n"
    ((RETRIES++))
    sleep $SLEEP_TIME
done

if [ "$RETRIES" -gt "$LIMIT" ]; then
    printf "[ERROR] All Retries Exhausted!\n"
    exit 1
fi

#!/bin/bash
STATUS=""
SLEEP_TIME=30
LIMIT=60
RETRIES=0

NAMESPACE=$1
ENABLE_PX_BACKUP=$2

if ! $ENABLE_PX_BACKUP; then
    printf "[INFO] No PX Backup Installation Requested\n"
    exit 0
fi

sleep 200

while [ "$RETRIES" -le "$LIMIT" ]; do
    STATUS=$(kubectl get pods -l=job-name=pxcentral-post-install-hook -n ${NAMESPACE} --no-headers -o custom-columns=":status.phase" | awk 'END { print }')
    if [ "$STATUS" == "Succeeded" ]; then
        printf "[INFO] Removing Post Install Job.\n"
        kubectl get pods -o wide -n ${NAMESPACE}
        kubectl delete job -n ${NAMESPACE} pxcentral-post-install-hook
        printf "[SUCCESS] Portworx Central Installation Complete.\n"
        break
    fi
    printf "[INFO] Waiting for Portworx Central Job to finish. (Retry in $SLEEP_TIME secs)\n"
    ((RETRIES++))
    sleep $SLEEP_TIME
done

if [ "$RETRIES" -gt "$LIMIT" ]; then
    printf "[ERROR] All Retries Exhausted!\n"
    exit 1
fi

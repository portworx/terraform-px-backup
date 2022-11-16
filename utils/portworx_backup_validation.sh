#!/bin/bash
STATUS=""
SLEEP_TIME=45
LIMIT=20
RETRIES=0

sleep 120

NAMESPACE=$1

while [ "$RETRIES" -le "$LIMIT" ]
do
    STATUS=$(kubectl get pods -l=job-name=pxcentral-post-install-hook -n ${NAMESPACE} --no-headers -o custom-columns=":status.phase")
    if [ "$STATUS" == "Succeeded" ]; then
        printf "[INFO] Removing Post Install Job.\n"
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

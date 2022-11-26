#!/bin/bash
STATUS=""
SLEEP_TIME=60
LIMIT=20
RETRIES=0

NAMESPACE=$1
WAIT_FOR_PX_CENTRAL=$2
sleep 240

if ! $WAIT_FOR_PX_CENTRAL; then
    printf "[INFO] Fast Install Selected. Checking for PX-Backup Installation Only.\n"
    while [ "$RETRIES" -le "$LIMIT" ]; do
        STATUS=$(kubectl get pods -l app=px-backup -n ${NAMESPACE} -o jsonpath='{.items[].status.containerStatuses[0].ready}')
        if [ "$STATUS" == "true" ]; then
            printf "[SUCCESS] Portworx Backup Installation Complete.\n"
            break
        fi
        printf "[INFO] Waiting for Portworx Backup Pod to be ready. (Retry in $SLEEP_TIME secs)\n"
        ((RETRIES++))
        sleep $SLEEP_TIME
    done
else
    while [ "$RETRIES" -le "$LIMIT" ]; do
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
fi

if [ "$RETRIES" -gt "$LIMIT" ]; then
    printf "[ERROR] All Retries Exhausted!\n"
    exit 1
fi

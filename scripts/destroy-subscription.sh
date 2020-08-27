#!/usr/bin/env bash

NAMESPACE="$1"
NAME="$2"

if kubectl get -n "${NAMESPACE}" subscription "${NAME}" 1> /dev/null 2> /dev/null; then
  echo "Deleting operator subscription: ${NAMESPACE}/${NAME}"
  kubectl delete -n "${NAMESPACE}" subscription "${NAME}"
else
  echo "Unable to find subscription for operator in ${NAMESPACE}/${NAME}"
fi

#!/usr/bin/env bash

CLUSTER_TYPE="$1"
OPERATOR_NAMESPACE="$2"
OLM_NAMESPACE="$3"
APP_NAMESPACE="$4"

if [[ -z "${OUTPUT_DIR}" ]]; then
  OUTPUT_DIR=".tmp"
fi
mkdir -p "${OUTPUT_DIR}"

CHANNEL=alpha

if [[ "${CLUSTER_TYPE}" == "ocp4" ]]; then
  SOURCE="community-operators"
  NAME="ibmcloud-operator"
else
  SOURCE="operatorhubio-catalog"
  NAME="ibmcloud-operator"
fi

if [[ -z "${OLM_NAMESPACE}" ]]; then
  if [[ "${CLUSTER_TYPE}" == "ocp4" ]]; then
    OLM_NAMESPACE="openshift-marketplace"
  else
    OLM_NAMESPACE="olm"
  fi
fi

YAML_FILE=${OUTPUT_DIR}/cloud-operator-subscription.yaml

cat <<EOL > ${YAML_FILE}
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: $NAME
  namespace: $OPERATOR_NAMESPACE
spec:
  channel: $CHANNEL
  installPlanApproval: Automatic
  name: $NAME
  source: $SOURCE
  sourceNamespace: $OLM_NAMESPACE
EOL

#!/usr/bin/env bash

echo "Downloading cancer-diagnosis-workflow required containers... Please wait..."

CURRENT_DIR=$(pwd)
CONTAINER_FOLDER=$(pwd)/cancer-diagnosis-workflow-containers
mkdir -p ${CONTAINER_FOLDER}
cd ${CONTAINER_FOLDER}

apptainer pull cll_combine_models.sif docker://ghcr.io/permedcoe/cll_combine_models:latest
apptainer pull cll_network_inference.sif docker://ghcr.io/permedcoe/cll_network_inference:latest
apptainer pull cll_personalize_boolean_models.sif docker://ghcr.io/permedcoe/cll_personalize_boolean_models:latest
apptainer pull cll_prepare_data.sif docker://ghcr.io/permedcoe/cll_prepare_data:latest
apptainer pull cll_run_boolean_model.sif docker://ghcr.io/permedcoe/cll_run_boolean_model:latest
apptainer pull cll_tf_activities.sif docker://ghcr.io/permedcoe/cll_tf_activities:latest

cd ${CURRENT_DIR}

echo "cancer-diagnosis-workflow required containers downloaded"
echo ""
echo "Containers stored in: ${CONTAINER_FOLDER}"
echo ""
echo "Please, don't forget to run:"
echo "    export PERMEDCOE_IMAGES=${CONTAINER_FOLDER}"
echo "Before running the workflow."
echo ""

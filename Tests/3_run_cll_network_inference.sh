#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if [[ -z "${PERMEDCOE_IMAGES}" ]]; then
  default_images=$(realpath ${SCRIPT_DIR}/../../BuildingBlocks/Resources/images/)/
  export PERMEDCOE_IMAGES=${default_images}
  echo "WARNING: PERMEDCOE_IMAGES environment variable not set. Using default: ${default_images}"
else
  echo "INFO: Using PERMEDCOE_IMAGES from: ${PERMEDCOE_IMAGES}"
fi
export COMPUTING_UNITS=1

dataset=$(pwd)/../Resources/data
models=$(pwd)/../Resources/models
outdir=$(pwd)/result/
mkdir -p ${outdir}

TEMP_DIRECTORY=$(pwd)/cll_network_inference_wd
mkdir -p ${TEMP_DIRECTORY}

cll_network_inference_BB \
    --debug \
    --tmpdir ${TEMP_DIRECTORY} \
    --cplex_bin /apps/COMPSs/PerMedCoE/python3.10/site-packages/cll_network_inference_BB/assets/cplex \
    --activities ${outdir}/activities.RData \
    --omnipath_database ${models}/omnipath_database.RData \
    --outdir ${outdir}/network_inference \
    --sif ${outdir}/inferred_network.sif

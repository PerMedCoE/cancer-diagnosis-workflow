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

TEMP_DIRECTORY=$(pwd)/cll_personalize_boolean_models_wd
mkdir -p ${TEMP_DIRECTORY}

cll_personalize_boolean_models_BB \
    --debug \
    --tmpdir ${TEMP_DIRECTORY} \
    --sif ${outdir}/inferred_network.sif \
    --norm_exp ${outdir}/primary/be_norm_exp_symbol.tsv \
    --metadata ${dataset}/metadata.tsv \
    --group ighv_status\
    --outdir ${outdir}/boolean_models

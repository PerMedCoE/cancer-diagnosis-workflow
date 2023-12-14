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

TEMP_DIRECTORY=$(pwd)/cll_prepare_data_wd
mkdir -p ${TEMP_DIRECTORY}

cll_prepare_data_BB \
    --debug \
    --tmpdir ${TEMP_DIRECTORY} \
    --exp ${dataset}/exp.txt \
    --metadata ${dataset}/metadata.tsv \
    --xref ${models}/xref.RData \
    --group ighv_status \
    --treatment MUT \
    --control UNMUT \
    --batch donor_sex \
    --outdir ${outdir}/primary

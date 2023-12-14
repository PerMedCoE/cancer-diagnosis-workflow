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

TEMP_DIRECTORY=$(pwd)/cll_run_boolean_model_wd
mkdir -p ${TEMP_DIRECTORY}

# TODO: DO THIS FOR ALL PATIENTS AND ALSO FOR PATIENT RUNS

cll_run_boolean_model_BB \
    --debug \
    --tmpdir ${TEMP_DIRECTORY} \
    --sif ${outdir}/inferred_network.sif \
    --bnd ${outdir}/boolean_models/inferred_network.sif.bnd \
    --cfg ${outdir}/boolean_models/group_profiles/inferred_network__MUT.sif.cfg \
    --id MUT \
    --outdir ${outdir}/boolean_models/group_runs/MUT

cll_run_boolean_model_BB \
    --debug \
    --tmpdir ${TEMP_DIRECTORY} \
    --sif ${outdir}/inferred_network.sif \
    --bnd ${outdir}/boolean_models/inferred_network.sif.bnd \
    --cfg ${outdir}/boolean_models/group_profiles/inferred_network__Undetermined.sif.cfg \
    --id Undetermined \
    --outdir ${outdir}/boolean_models/group_runs/Undetermined

cll_run_boolean_model_BB \
    --debug \
    --tmpdir ${TEMP_DIRECTORY} \
    --sif ${outdir}/inferred_network.sif \
    --bnd ${outdir}/boolean_models/inferred_network.sif.bnd \
    --cfg ${outdir}/boolean_models/group_profiles/inferred_network__UNMUT.sif.cfg \
    --id UNMUT \
    --outdir ${outdir}/boolean_models/group_runs/UNMUT


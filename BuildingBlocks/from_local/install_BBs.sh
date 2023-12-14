#!/usr/bin/env bash

echo "Installing cancer-diagnosis-workflow required Building Blocks... Please wait..."

CURRENT_DIR=$(pwd)
# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd ../../../BuildingBlocks

cd cll_combine_models
./install.sh
cd ..

cd cll_network_inference
./install.sh
cd ..

cd cll_personalize_boolean_models
./install.sh
cd ..

cd cll_prepare_data
./install.sh
cd ..

cd cll_run_boolean_model
./install.sh
cd ..

cd cll_tf_activities
./install.sh
cd ..

cd ${CURRENT_DIR}

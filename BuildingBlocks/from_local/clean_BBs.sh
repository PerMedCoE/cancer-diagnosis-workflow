#!/usr/bin/env bash

echo "Cleaning cancer-diagnosis-workflow required Building Blocks... Please wait..."

CURRENT_DIR=$(pwd)
# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd ../../../BuildingBlocks

cd cll_combine_models
./clean.sh
cd ..

cd cll_network_inference
./clean.sh
cd ..

cd cll_personalize_boolean_models
./clean.sh
cd ..

cd cll_prepare_data
./clean.sh
cd ..

cd cll_run_boolean_model
./clean.sh
cd ..

cd cll_tf_activities
./clean.sh
cd ..

cd ${CURRENT_DIR}

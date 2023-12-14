#!/usr/bin/env bash

echo "Uninstalling cancer-diagnosis-workflow required Building Blocks... Please wait..."

CURRENT_DIR=$(pwd)
# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd ../../../BuildingBlocks

cd cll_combine_models
./uninstall.sh
cd ..

cd cll_network_inference
./uninstall.sh
cd ..

cd cll_personalize_boolean_models
./uninstall.sh
cd ..

cd cll_prepare_data
./uninstall.sh
cd ..

cd cll_run_boolean_model
./uninstall.sh
cd ..

cd cll_tf_activities
./uninstall.sh
cd ..

cd ${CURRENT_DIR}

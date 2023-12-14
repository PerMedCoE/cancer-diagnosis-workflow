#!/usr/bin/env bash

echo "Installing cancer-diagnosis-workflow required Building Blocks... Please wait..."

python3 -m pip install 'git+https://github.com/PerMedCoE/BuildingBlocks.git@main#subdirectory=cll_combine_models'
python3 -m pip install 'git+https://github.com/PerMedCoE/BuildingBlocks.git@main#subdirectory=cll_network_inference'
python3 -m pip install 'git+https://github.com/PerMedCoE/BuildingBlocks.git@main#subdirectory=cll_personalize_boolean_models'
python3 -m pip install 'git+https://github.com/PerMedCoE/BuildingBlocks.git@main#subdirectory=cll_prepare_data'
python3 -m pip install 'git+https://github.com/PerMedCoE/BuildingBlocks.git@main#subdirectory=cll_run_boolean_model'
python3 -m pip install 'git+https://github.com/PerMedCoE/BuildingBlocks.git@main#subdirectory=cll_tf_activities'

echo "cancer-diagnosis-workflow required Building Blocks installed"

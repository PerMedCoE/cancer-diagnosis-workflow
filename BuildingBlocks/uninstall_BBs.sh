#!/usr/bin/env bash

echo "Uninstalling cancer-diagnosis-workflow required Building Blocks... Please wait..."

python3 -m pip uninstall -y cll_combine_models-BB
python3 -m pip uninstall -y cll_network_inference-BB
python3 -m pip uninstall -y cll_personalize_boolean_models-BB
python3 -m pip uninstall -y cll_prepare_data-BB
python3 -m pip uninstall -y cll_run_boolean_model-BB
python3 -m pip uninstall -y cll_tf_activities-BB

echo "Uninstall finished"

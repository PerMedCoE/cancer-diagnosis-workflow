#!/usr/bin/env bash

export COMPSS_PYTHON_VERSION=3.10.2
module load COMPSs/3.3
module load singularity/3.7.3
module use /apps/modules/modulefiles/tools/COMPSs/libraries
module load permedcoe  # generic permedcoe package

# Override the following for using different images or dataset
export PERMEDCOE_IMAGES=${PERMEDCOE_IMAGES}  # Currently using the "permedcoe" deployed
dataset=$(pwd)/../../Resources/data/
models=$(pwd)/../../Resources/models/

# Set the tool internal parallelism and constraint
export COMPUTING_UNITS=1

mkdir worker_wd
mkdir master_wd
mkdir log_dir

enqueue_compss \
    --qos=debug \
    --num_nodes=2 \
    --exec_time=80 \
    --worker_working_dir=$(pwd)/worker_wd/ \
    --master_working_dir=$(pwd)/master_wd/ \
    --log_dir=$(pwd)/log_dir/ \
    --log_level=off \
    --graph \
    --tracing \
    $(pwd)/src/cancer_diagnosis.py \
      --exp ${dataset}/exp.txt \
      --metadata ${dataset}/metadata.tsv \
      --xref ${models}/xref.RData \
      --group ighv_status \
      --treatment MUT \
      --control UNMUT \
      --batch donor_sex \
      --collectri_database ${models}/collectri_database.RData \
      --progeny_database ${models}/progeny_database.RData \
      --omnipath_database ${models}/omnipath_database.RData \
      --cplex_bin cplex \
      --outdir $(pwd)/results/

######################################################
# APPLICATION EXECUTION EXAMPLE
# Call:
#       ./launch.sh
#
# Example:
#       ./launch.sh
######################################################

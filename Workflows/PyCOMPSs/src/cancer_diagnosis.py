#!/usr/bin/python3

import os
import re
import argparse

# To set building block debug mode
from permedcoe import set_debug
# To set the default PyCOMPSs TMPDIR
from permedcoe import TMPDIR

# Import building block tasks
from cll_prepare_data_BB import cll_prepare_data
from cll_tf_activities_BB import cll_tf_activities
from cll_network_inference_BB import cll_network_inference
from cll_personalize_boolean_models_BB import cll_personalize_boolean_models
from cll_run_boolean_model_BB import cll_run_boolean_model
from cll_combine_models_BB import cll_combine_models

# Import utils
# from utils import parse_input_parameters
# from helpers import get_genefiles

# PyCOMPSs imports
from pycompss.api.api import compss_wait_on_directory
from pycompss.api.api import compss_wait_on_file
from pycompss.api.api import compss_wait_on


def parse_input_parameters():
    """Argument parser.

    :return: Args object containing the arguments.
    """
    parser = argparse.ArgumentParser(description="UC1-CLL permedcoe workflow")
    parser.add_argument("--exp", action="store", default=None, required=True)
    parser.add_argument("--metadata", action="store", default=None, required=True)
    parser.add_argument("--xref", action="store", default=None, required=True)
    parser.add_argument("--group", action="store", default=None, required=True)
    parser.add_argument("--treatment", action="store", default=None, required=True)
    parser.add_argument("--control", action="store", default=None, required=True)
    parser.add_argument("--batch", action="store", default=None, required=True)
    parser.add_argument(
        "--collectri_database", action="store", default=None, required=True
    )
    parser.add_argument(
        "--progeny_database", action="store", default=None, required=True
    )
    parser.add_argument(
        "--omnipath_database", action="store", default=None, required=True
    )
    parser.add_argument("--cplex_bin", action="store", default=None, required=True)
    parser.add_argument("--outdir", action="store", default=None, required=True)
    args = parser.parse_args()
    print(args)
    return args


def main():
    """
    MAIN CODE
    """
    set_debug(False)

    print("--------------------")
    print("| UC1-CLL Workflow |")
    print("--------------------")

    # GET INPUT PARAMETERS
    args = parse_input_parameters()

    ## BB1 (Prepare data)
    outdir = args.outdir + "/primary"
    cll_prepare_data(
        tmpdir=TMPDIR,
        exp=args.exp,
        metadata=args.metadata,
        xref=args.xref,
        group=args.group,
        treatment=args.treatment,
        control=args.control,
        batch=args.batch,
        outdir=outdir,
    )
    compss_wait_on_directory(outdir)

    ## BB2 (TFs activitites)
    norm_exp = args.outdir + "/primary/be_norm_exp_symbol.tsv"
    dea = args.outdir + "/primary/dea.tsv"
    activities = args.outdir + "/activities.RData"
    cll_tf_activities(
        tmpdir=TMPDIR,
        norm_exp=norm_exp,
        metadata=args.metadata,
        dea=dea,
        group=args.group,
        treatment=args.treatment,
        control=args.control,
        collectri_database=args.collectri_database,
        progeny_database=args.progeny_database,
        outdir=args.outdir + "/tf_activities",
        activities=activities,
    )

    ## BB3 (Network inference)
    sif = args.outdir + "/inferred_network.sif"
    cll_network_inference(
        tmpdir=TMPDIR,
        cplex_bin=args.cplex_bin,
        activities=activities,
        omnipath_database=args.omnipath_database,
        outdir=args.outdir + "/network_inference",
        sif=sif,
    )

    ## BB4 (Personalize boolean models)
    outdir_bool_models = args.outdir + "/boolean_models"
    cll_personalize_boolean_models(
        tmpdir=TMPDIR,
        sif=sif,
        norm_exp=norm_exp,
        metadata=args.metadata,
        group=args.group,
        outdir=outdir_bool_models,
    )
    compss_wait_on_directory(outdir_bool_models)

    ## BB5 (Run boolean models)
    bnd = args.outdir + "/boolean_models/inferred_network.sif.bnd"
    all_rmb_dirs = []
    # Group models
    os.mkdir(args.outdir + "/boolean_models/group_runs")
    group_profiles = args.outdir + "/boolean_models/group_profiles"
    for cfg in os.listdir(group_profiles):
        sid = re.sub(".sif.cfg", "", re.sub("inferred_network__", "", cfg))
        outdir_rbm = args.outdir + "/boolean_models/group_runs/" + sid + "/"
        all_rmb_dirs.append(outdir_rbm)
        cll_run_boolean_model(
            tmpdir=TMPDIR,
            sif=sif,
            bnd=bnd,
            cfg=os.path.join(group_profiles, cfg),
            id=sid,
            outdir=outdir_rbm,
        )

    # Patient models
    os.mkdir(args.outdir + "/boolean_models/patient_runs")
    patient_profiles = args.outdir + "/boolean_models/patient_profiles"
    for cfg in os.listdir(patient_profiles):
        sid = re.sub(".sif.cfg", "", re.sub("inferred_network__", "", cfg))
        outdir_rbm = args.outdir + "/boolean_models/patient_runs/" + sid + "/"
        all_rmb_dirs.append(outdir_rbm)
        cll_run_boolean_model(
            tmpdir=TMPDIR,
            sif=sif,
            bnd=bnd,
            cfg=os.path.join(patient_profiles, cfg),
            id=sid,
            outdir=outdir_rbm,
        )

    for rbm_dir in all_rmb_dirs:
        compss_wait_on_directory(rbm_dir)

    ## BB6 (Combine models)
    final_result = args.outdir + "/combined_models"
    cll_combine_models(
        tmpdir=TMPDIR,
        runs=args.outdir + "/boolean_models",
        metadata=args.metadata,
        group=args.group,
        outdir=final_result,
    )
    compss_wait_on_directory(final_result)



if __name__ == "__main__":
    main()

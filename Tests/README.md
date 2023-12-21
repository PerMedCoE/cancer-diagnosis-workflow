# Cancer Diagnosis Workflow Tests

This folder contains tests for the Cancer Diagnosis Building Blocks.

## Scripts

There is a set of scripts to ease the Building Blocks testing:

```bash
.
├── 1_run_cll_prepare_data.sh
├── 2_run_cll_tf_activities.sh
├── 3_run_cll_network_inference.sh
├── 4_run_cll_personalize_boolean_models.sh
├── 5_run_cll_run_boolean_models.sh
├── 6_run_cll_combine_models.sh
```

These scripts can be executed one after the other.

**WARNING:** Please, update the ``PERMEDCOE_IMAGES`` environment
variables exported within each script to the appropriate
singularity container folder and assets folder accordingly.

Finally, there is a ``clean.sh`` script aimed at cleaning the results of the
building blocks execution.

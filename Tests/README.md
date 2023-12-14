# Cancer Invasion Workflow Tests

This folder contains tests for the Cancer Invasion Building Blocks.

## Scripts

There is a set of scripts to ease the Building Blocks testing:

```bash
.
├── 1_run_physiboss_invasion_bb.sh
```

These scripts can be executed one after the other.

**WARNING:** Please, update the ``PERMEDCOE_IMAGES`` environment 
variables exported within each script to the appropriate
singularity container folder and assets folder accordingly.

Finally, there is a ``clean.sh`` script aimed at cleaning the results of the
building blocks execution.

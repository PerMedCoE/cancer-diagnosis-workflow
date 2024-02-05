# Cancer Diagnosis Workflow

## Table of Contents

- [Cancer Diagnosis Workflow](#cancer-diagnosis-workflow)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Contents](#contents)
    - [Building Blocks](#building-blocks)
    - [Workflows](#workflows)
    - [Resources](#resources)
    - [Tests](#tests)
  - [Instructions](#instructions)
    - [Local machine](#local-machine)
      - [Requirements](#requirements)
      - [Usage steps](#usage-steps)
    - [MareNostrum 4](#marenostrum-4)
      - [Requirements in MN4](#requirements-in-mn4)
      - [Usage steps in MN4](#usage-steps-in-mn4)
  - [License](#license)
  - [Contact](#contact)

## Description

This use case describes a computational workflow for building a mechanistic model that captures molecular differences between two cancer subtypes, with a focus on Chronic Lymphocytic Leukaemia (CLL). The study uses RNA-Seq data and a specific clinical variable, drawing on the ICGC consortium’s data, making it potentially applicable to various cancer types. The analysis aims to understand cellular signalling differences between IGHV groups by employing tools to assess transcription factor activity and provide a signalling network, offering a mechanistic explanation for observed molecular changes. The creation of patient-specific Boolean models allows for studying individual patient trajectories, emphasizing the importance of personalized medicine and tailoring approaches to account for genomic heterogeneity in cancer. Overall, this use case showcases the application of mathematical modelling tools in personalized medicine to understand and adapt approaches based on individual patient characteristics.


## Contents

### Building Blocks

The ``BuildingBlocks`` folder contains the script to install the
Building Blocks used in the Cancer Diagnosis Workflow.

### Workflows

The ``Workflow`` folder contains the workflows implementations.

Currently contains the implementation using PyCOMPSs.

### Resources

The ``Resources`` folder contains dataset files.

### Tests

The ``Tests`` folder contains the scripts that run each Building Block
used in the workflow for the given small dataset.
They can be executed individually for testing purposes.

## Instructions

### Local machine

This section explains the requirements and usage for the Cancer Diagnosis Workflow in a laptop or desktop computer.

#### Requirements

- [`permedcoe`](https://github.com/PerMedCoE/permedcoe) package
- [PyCOMPSs](https://pycompss.readthedocs.io/en/stable/Sections/00_Quickstart.html)
- [Singularity](https://sylabs.io/guides/3.0/user-guide/installation.html)

#### Usage steps

1. Clone this repository:

  ```bash
  git clone https://github.com/PerMedCoE/cancer-diagnosis-workflow
  ```

2. Install the Building Blocks required for the Cancer Diagnosis Workflow:

  ```bash
  cancer-diagnosis-workflow/BuildingBlocks/./install_BBs.sh
  ```

3. Get the required Building Block images from the project [B2DROP](https://b2drop.bsc.es/index.php/f/444350):

  - Required images:
      - cll_combine_models
      - cll_network_inference
      - cll_tf_activities
      - cll_personalize_boolean_models
      - cll_prepare_data
      - cll_run_boolean_model

  The path where these files are stored **MUST be exported in the `PERMEDCOE_IMAGES`** environment variable.

  > :warning: **TIP**: These containers can be built manually as follows (be patient since some of them may take some time):
  1. Clone the `BuildingBlocks` repository
     ```bash
     git clone https://github.com/PerMedCoE/BuildingBlocks.git
     ```
  2. Build the required Building Block images
     ```bash
     cd BuildingBlocks/Resources/images
     sudo singularity build cll_combine_models.sif cll_combine_models.def
     sudo singularity build cll_network_inference.sif cll_network_inference.def
     sudo singularity build cll_tf_activities.sif cll_tf_activities.def
     sudo singularity build cll_personalize_boolean_models.sif cll_personalize_boolean_models.def
     sudo singularity build cll_prepare_data.sif cll_prepare_data.def
     sudo singularity build cll_run_boolean_model.sif cll_run_boolean_model.def
     cd ../../..
     ```

**If using PyCOMPSs in local PC** (make sure that PyCOMPSs in installed):

4. Go to `Workflow/PyCOMPSs` folder

   ```bash
   cd Workflows/PyCOMPSs
   ```

5. Execute `./run.sh`


### MareNostrum 4

This section explains the requirements and usage for the Cancer Diagnosis Workflow in the MareNostrum 4 supercomputer.

#### Requirements in MN4

- Access to MN4

All Building Blocks are already installed in MN4, and the Cancer Diagnosis Workflow available.

#### Usage steps in MN4

1. Load the `COMPSs`, `Singularity` and `permedcoe` modules

   ```bash
   export COMPSS_PYTHON_VERSION=3
   module load COMPSs/3.3
   module load singularity/3.5.2
   module use /apps/modules/modulefiles/tools/COMPSs/libraries
   module load permedcoe
   ```

   > **TIP**: Include the loading into your `${HOME}/.bashrc` file to load it automatically on the session start.

   This commands will load COMPSs and the permedcoe package which provides all necessary dependencies, as well as the path to the singularity container images (`PERMEDCOE_IMAGES` environment variable) and testing dataset (`CANCERDiagnosisWORKFLOW_DATASET` environment variable).

2. Get a copy of the pilot workflow into your desired folder

   ```bash
   mkdir desired_folder
   cd desired_folder
   get_cancerDiagnosisworkflow
   ```

3. Go to `Workflow/PyCOMPSs` folder

   ```bash
   cd Workflow/PyCOMPSs
   ```

4. Execute `./launch.sh`

  This command will launch a job into the job queuing system (SLURM) requesting 2 nodes (one node acting half master and half worker, and other full worker node) for 20 minutes, and is prepared to use the singularity images that are already deployed in MN4 (located into the `PERMEDCOE_IMAGES` environment variable). It uses the dataset located into `../../Resources/data` folder.

  > :warning: **TIP**: If you want to run the workflow with a different dataset, please edit the `launch.sh` script and define the appropriate dataset path.

  After the execution, a `results` folder will be available with with Cancer Diagnosis Workflow results.

## License

[Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0)

## Contact

<https://permedcoe.eu/contact/>

This software has been developed for the [PerMedCoE project](https://permedcoe.eu/), funded by the European Commission (EU H2020 [951773](https://cordis.europa.eu/project/id/951773)).

![](https://permedcoe.eu/wp-content/uploads/2020/11/logo_1.png "PerMedCoE")

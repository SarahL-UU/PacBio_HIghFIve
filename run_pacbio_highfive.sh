#!/bin/bash

#SBATCH -A naiss2024-22-121
#SBATCH -n 1
#SBATCH -p core
#SBATCH -t 00:15:00
#SBATCH -o run_pb_highfive.%j.out
#SBATCH -e run_pb_highfive.%j.err

#module load conda
source /proj/naiss2024-22-121/nobackup/padraic/pipeline_env/bin/activate

module load slurm-drmaa/1.1.4-slurm23.02.5

snakemake --profile profiles/rackham/ \
--configfile config/config_rackham.yaml \
-d /proj/naiss2024-22-121/pb_longread_pipeline/PacBio_HIghFIve/HG002_test \
-p

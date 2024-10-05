#!/bin/bash

#SBATCH -A sens2017554
#SBATCH -n 1
#SBATCH -p core
#SBATCH -t 120:00:00
#SBATCH -o run_pb_highfive.%j.out
#SBATCH -e run_pb_highfive.%j.err

set -e
set -u
set -o pipefail

module load conda
source activate /proj/sens2017554/nobackup/sarah/Masterarbete/pipeline_env/

module load slurm-drmaa/1.1.4-slurm23.02.5

snakemake --profile profiles/bianca/ \
--configfile config/config_bianca.yaml \
-d Pipeline_results \
-p

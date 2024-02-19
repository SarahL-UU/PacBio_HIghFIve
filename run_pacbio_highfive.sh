#!/bin/bash

#SBATCH -A naiss2024-22-121
#SBATCH -n 1
#SBATCH -p core
#SBATCH -t 4-00:00:00
#SBATCH -o run_pb_highfive.%j.out
#SBATCH -e run_pb_highfive.%j.err

module load slurm-drmaa/1.1.4

snakemake --profiles/rackham/ \
--configfile config/config_rackham.yaml \
-d NA12878_test \
-p \
-n

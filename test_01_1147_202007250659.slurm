#!/bin/bash
#SBATCH --job-name='test_01'
#SBATCH --chdir=/home/hpcadmin/test
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --time=0-24:00
#SBATCH --exclusive
#SBATCH --gres=gpu:1



module load singularity
echo job start time is `date`
lico-dl-run tensorflow slurm " -B /home/hpcadmin " /home/hpcadmin/.lico/container/zcftensorflow.image \
	/home/hpcadmin/alice/test_1085_202007231010.slurm \
	" " \
	--gpu-num 1 \
	
echo job end time is `date`

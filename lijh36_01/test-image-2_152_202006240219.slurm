#!/bin/bash
#SBATCH --job-name='test-image-2'
#SBATCH --chdir=/home/hpcadmin/ai_studio/datasource/02f8cf7c-b5c1-11ea-8a60-b8599f2ba36a/jobs
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=2

module load singularity

echo job start time is `date`
singularity exec -B /home/hpcadmin  \
        \/var/lib/lico/core/container/letrain-cpu.image python /opt/letrain-run-script/datasource/datasource_process.py \
        --location=/home/hpcadmin/ai_studio/datasource/02f8cf7c-b5c1-11ea-8a60-b8599f2ba36a --image_path='/home/hpcadmin/gcbtest/44.jpg'\
        --label=flower

echo job end time is `date`
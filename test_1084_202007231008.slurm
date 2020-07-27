#!/bin/bash
#SBATCH --job-name='test'
#SBATCH --chdir=/home/hpcadmin/test
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --mincpus=1


port=25354
url_suffix=`perl -e '
    use Socket;
    use MIME::Base64;
    $host=gethostbyname("'$SLURMD_NODENAME'");
    $ip=inet_ntoa($host);
    print(MIME::Base64::encode_base64url($ip.":"."'$port'"))
'`

module load singularity

    singularity exec -B /home/hpcadmin -B /root/test1 -B /root/test2 \
        /home/lico/container/jupyter-py36-cpu.image \
        /opt/start \
        --port $port \
        --language py36 \
        --workdir /home/hpcadmin/test \
        --password sha1:2bfc1ebe59a0:19e71c037517ddede5e480816daa9a3019a93588 \
        --conda_env '/home/hpcadmin/alice' \
        --base_url /dev/jupyter/$url_suffix/le-f7128dbe-ab08-45c3-99d9-06647851c586/


echo job end time is `date`

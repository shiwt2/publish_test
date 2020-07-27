#!/bin/bash
#SBATCH --job-name='test'
#SBATCH --chdir=/home/hpcadmin/test
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --mincpus=1


port=26369
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
        --password sha1:81f915c34483:ca5e6287de1536e11b99843dca47e364d3984beb \
        --conda_env '/home/hpcadmin/test_1' \
        --base_url /dev/jupyter/$url_suffix/le-ecf4e462-34d6-4327-99a1-26bd9568988a/


echo job end time is `date`

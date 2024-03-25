#!/bin/sh
# properties = {"type": "single", "rule": "fastQC_prealignment_qc", "local": false, "input": ["/proj/naiss2024-22-121/pb_longread_pipeline/Raw_data/control_samples/m84011_220902_175841_s1.hifi_reads.bam"], "output": ["qc/fastqc/HG002_fastqc.html", "qc/fastqc/HG002_fastqc.zip"], "wildcards": {"sample": "HG002"}, "params": {}, "log": ["logs/fastqc/HG002_fastqc.log"], "threads": 2, "resources": {"mem_mb": 6144, "mem_mib": 5860, "disk_mb": 87274, "disk_mib": 83231, "tmpdir": "<TBD>", "mem_per_cpu": 6144, "partition": "core", "threads": 1, "time": "1:00:00"}, "jobid": 2, "cluster": {}}
cd /crex/proj/naiss2024-22-121/pb_longread_pipeline/PacBio_HIghFIve/HG002_test && /crex/proj/naiss2024-22-121/nobackup/padraic/pipeline_env/bin/python3 -m snakemake --snakefile '/crex/proj/naiss2024-22-121/pb_longread_pipeline/PacBio_HIghFIve/workflow/Snakefile' --target-jobs 'fastQC_prealignment_qc:sample=HG002' --allowed-rules 'fastQC_prealignment_qc' --cores 'all' --attempt 1 --force-use-threads  --resources 'mem_mb=6144' 'mem_mib=5860' 'disk_mb=87274' 'disk_mib=83231' 'mem_per_cpu=6144' 'threads=1' --wait-for-files '/crex/proj/naiss2024-22-121/pb_longread_pipeline/PacBio_HIghFIve/HG002_test/.snakemake/tmp.jqh8k4g6' '/proj/naiss2024-22-121/pb_longread_pipeline/Raw_data/control_samples/m84011_220902_175841_s1.hifi_reads.bam' --force --keep-target-files --keep-remote --max-inventory-time 0 --nocolor --notemp --no-hooks --nolock --ignore-incomplete --rerun-triggers 'mtime' 'software-env' 'params' 'code' 'input' --skip-script-cleanup  --conda-frontend 'mamba' --use-singularity  --singularity-prefix '/proj/naiss2024-22-121/pb_longread_pipeline/singularity_files' --singularity-args '--cleanenv --bind /crex/proj,/proj --disable-cache --nv' --wrapper-prefix 'git+file://proj/naiss2024-22-121/pb_longread_pipeline/snakemake-wrappers' --configfiles '/crex/proj/naiss2024-22-121/pb_longread_pipeline/PacBio_HIghFIve/config/config_rackham.yaml' --printshellcmds  --latency-wait 5 --scheduler 'greedy' --scheduler-solver-path '/crex/proj/naiss2024-22-121/nobackup/padraic/pipeline_env/bin' --default-resources 'mem_mb=max(2*input.size_mb, 1000)' 'disk_mb=max(2*input.size_mb, 1000)' 'tmpdir=system_tmpdir' --directory '/proj/naiss2024-22-121/pb_longread_pipeline/PacBio_HIghFIve/HG002_test' --mode 2


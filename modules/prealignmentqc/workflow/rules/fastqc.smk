rule fastQC_prealignment:
    input:
        "Raw_data/NA12878/{sample}.fastq"
    output:
        "Results/FastQC/{sample}_fastqc_prealignment.html"
    params:
        out_dr="Results/FastQC"
    threads: 1
    conda: "envs/fastqc.yaml"
    log:
        stdout="logs/FastQC/{sample}_fastqc.stdout", stderr="logs/FastQC/{sample}_fastqc.stderr"
    shell:
        "fastqc -o {params.out_dr} --extract -t {threads} {input} > {log.stdout} 2> {log.stderr}"

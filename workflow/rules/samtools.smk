rule samtools_stats:
    input:
        bam="aligned/{sample}.sorted.Hg38.bam",
    output:
        "samtools_stats/{sample}.txt",
    params:
        extra="",  # Optional: extra arguments.
        region="",  # Optional: region string.
    log:
        "logs/samtools_stats/{sample}.log",
    wrapper:
        "/proj/naiss2024-22-121/pb_longread_pipeline/snakemake-wrappers/bio/samtools/stats"



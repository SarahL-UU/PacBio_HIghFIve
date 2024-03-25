rule mosdepth:
    input:
        bam="aligned/{sample}.sorted.Hg38.bam",
        bai="aligned/{sample}.sorted.Hg38.bam.bai",
    output:
        "mosdepth/{sample}.mosdepth.global.dist.txt",
        "mosdepth/{sample}.per-base.bed.gz",  # produced unless --no-per-base specified
        summary="mosdepth/{sample}.mosdepth.summary.txt",  # this named output is required for prefix parsing
    log:
        "logs/mosdepth/{sample}.log",
    params:
        extra="--fast-mode",  # optional
    # additional decompression threads through `--threads`
    threads: 4  # This value - 1 will be sent to `--threads`
    wrapper:
        "/proj/naiss2024-22-121/pb_longread_pipeline/snakemake-wrappers/bio/mosdepth"

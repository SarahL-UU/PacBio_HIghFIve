rule picard_collectalignmentsummarymetrics:
    input:
        ref="/proj/naiss2024-22-121/pb_longread_pipeline/references/Hg38/ncbi_dataset/data/GCF_000001405.26/GCF_000001405.26_GRCh38_geno$
        bam="aligned/{sample}.sorted.Hg38.bam",
    output:
        "/picard/collectalignmentsummarymetrics/{sample}.sorted.Hg38.bam.summary.txt",
    log:
        "logs/picard/collectalignmentsummarymetrics/{sample}.sorted.Hg38.bam.picard.alignmentmetrics.log",
    params:
        # optional parameters (e.g. relax checks as below)
        extra="--VALIDATION_STRINGENCY LENIENT --METRIC_ACCUMULATION_LEVEL null --METRIC_ACCUMULATION_LEVEL SAMPLE",
    # optional specification of memory usage of the JVM that snakemake will respect with global
    # resource restrictions (https://snakemake.readthedocs.io/en/latest/snakefiles/rules.html#resources)
    # and which can be used to request RAM during cluster job submission as `{resources.mem_mb}`:
    # https://snakemake.readthedocs.io/en/latest/executing/cluster.html#job-properties
    resources:
        mem_mb=1024,
    wrapper:
        "/proj/naiss2024-22-121/pb_longread_pipeline/snakemake-wrappers/bio/picard/collectalignmentsummarymetrics"

rule picard_collectgcbiasmetrics:
    input:
        # BAM aligned to reference genome
        bam="aligned/{sample}.sorted.Hg38.bam",
        # reference genome FASTA from which GC-context is inferred
        ref="/proj/naiss2024-22-121/pb_longread_pipeline/references/Hg38/ncbi_dataset/data/GCF_000001405.26/GCF_000001405.26_GRCh38_genomic.fna",
    output:
        metrics="picard/collectgcbiasmetrics/{sample}.sorted.Hg38.bam.gcmetrics.txt",
        chart="picard/collectgcbiasmetrics/{sample}.sorted.Hg38.bam.gc.pdf",
        summary="picard/collectgcbiasmetrics/{sample}.sorted.Hg38.bam.summary.txt",
    params:
        # optional additional parameters, for example,
        extra="--MINIMUM_GENOME_FRACTION 1E-5",
    log:
        "logs/picard/collectgcbiasmetrics/{sample}.sorted.Hg38.bam.gcmetrics.log",
    # optional specification of memory usage of the JVM that snakemake will respect with global
    # resource restrictions (https://snakemake.readthedocs.io/en/latest/snakefiles/rules.html#resources)
    # and which can be used to request RAM during cluster job submission as `{resources.mem_mb}`:
    # https://snakemake.readthedocs.io/en/latest/executing/cluster.html#job-properties
    resources:
        mem_mb=1024,
    wrapper:
        "/proj/naiss2024-22-121/pb_longread_pipeline/snakemake-wrappers/bio/picard/collectgcbiasmetrics"



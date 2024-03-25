rule pbmm2_align:
    input:
	reference=config.get("reference", {}).get("fasta", ""),
        query=pbmm2_input,
    output:
	bam="aligned/{sample}.sorted.Hg38.bam",
        index="aligned/{sample}.sorted.Hg38.bam.bai",
    params:
	preset=config.get("pbmm2_align_params", {}).get("preset", ""),
        sample=lambda wildcards: wildcards.sample,
        loglevel="--INFO",
        extra=config.get("pbmm2_align_params", {}).get("extra", ""),
    log:
        "logs/pbmm2_align/{sample}.sorted.Hg38.bam.log",
    threads: config.get("pbmm2_align_params", {}).get("threads", config["default_resources"]["threads"]),
    resources:
	mem_mb=config.get("pbmm2_align_params", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("pbmm2_align_params", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("pbmm2_align_params", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("pbmm2_align_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("pbmm2_align_params", {}).get("time", config["default_resources"]["time"]),
    container:
	"/proj/naiss2024-22-121/pb_longread_pipeline/singularity_files/pbmm2_1.13.1.sif"
    message:
	"{rule}: Align reads in {input.query} against {input.reference}"
    shell:
	"pbmm2 align {params.preset} {params.loglevel} {params.extra} {input.reference} {input.query}"


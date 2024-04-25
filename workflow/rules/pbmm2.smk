rule pbmm2_align:
    input:
	fasta=config.get("reference_files", {}).get("fasta_file", ""),
        query=pbmm2_input,
    output:
	bam="aligned/{sample}.aligned.sorted.bam",
        index="aligned/{sample}.aligned.sorted.bam.bai",
    params:
	preset=config.get("pbmm2_align_params", {}).get("preset", ""),
        #sample=lambda wildcards: wildcards.sample,
        sort=config.get("pbmm2_align_params", {}).get("sort", ""),
        extra=config.get("pbmm2_align_params", {}).get("extra", ""),
    log:
        "logs/pbmm2_align/{sample}.aligned.sorted.bam.log",
    threads: config.get("pbmm2_align_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
	mem_mb=config.get("pbmm2_align_params", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("pbmm2_align_params", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("pbmm2_align_params", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("pbmm2_align_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("pbmm2_align_params", {}).get("time", config["default_resources"]["time"]),
    container:
	config.get("pbmm2_align_params", {}).get("container", config["pbmm2_align_params"])
    message:
	"{rule}: Align reads in {input.query} against {input.fasta}"
    shell:
	"pbmm2 align {params.preset} {params.sort} {params.extra} {input.fasta} {input.query} {output.bam}"




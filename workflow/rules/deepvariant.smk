rule deepvariant:
    input:
	bam="aligned/{sample}.aligned.sorted.bam",
        ref=config.get("reference_files", {}).get("fasta_file", ""),
    output:
	vcf="deepvariant/{sample}.SNP.indel.vcf.gz",
    params:
	model=config.get("deepvariant_params", {}).get("model", ""),
    threads: config.get("deepvariant_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
	mem_mb=config.get("deepvariant_params", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("deepvariant_params", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("deepvariant_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("deepvariant_params", {}).get("time", config["default_resources"]["time"]),
    container:
	config.get("deepvariant_params", {}).get("container", config["default_container"])
    log:
        "logs/deepvariant/{sample}/{sample}.deepvariant.log",
    message:
	"{rule}: Run deepvariant on {input.bam}."
    shell:
	"(run_deepvariant --model_type {params.model} --ref {input.ref} --reads {input.bam} "
        "--output_vcf {output.vcf} --num_shards {threads} ) &> {log}"

rule deepvariant:
    input:
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
        ref=config.get("reference_files", {}).get("fasta_file", ""),
    output:
        vcf="{trio}/snp_calling/deepvariant/{sample}.{trio}.SNP.indel.vcf.gz",
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
        "{trio}/logs/deepvariant/{sample}.{trio}.deepvariant.log",
    message:
        "{rule}: Run deepvariant on {input.bam}."
    shell:
        "(run_deepvariant --model_type {params.model} --ref {input.ref} --reads {input.bam} "
        "--output_vcf {output.vcf} --num_shards {threads} ) &> {log}"

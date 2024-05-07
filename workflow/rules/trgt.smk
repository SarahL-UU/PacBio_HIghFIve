rule trgt_genotype:
    input:
        bam="aligned/{trio}/{sample}.{trio}.aligned.sorted.bam",
        bed=config.get("reference_files", {}).get("repeat_bed", ""),
        fasta=config.get("reference_files", {}).get("fasta_file", ""),
    output:
        "repeat_calling/trgt/{sample}.{trio}.trgt.vcf.gz",
        "repeat_calling/trgt/{sample}.{trio}.trgt.spanning.bam",
    params:
        prefix=config.get("trgt_genotype_params", {}).get("prefix", ""),
    log:
        "logs/trgt/{trio}/{sample}.{trio}.tgrt.genotype.log",
    message:
        "{rule}: genotypes repeats for {input.bam}."
    threads: config.get("trgt_genotype_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("trgt_genotype_params", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("trgt_genotype_params", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("trgt_genotype_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("trgt_genotype_params", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("trgt_genotype_params", {}).get("container", config["default_container"])
    shell:
        "trgt genotype "
        "--genome {input.fasta} "
        "--reads {input.bam} "
        "--output-prefix {params.prefix}"

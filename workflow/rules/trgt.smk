rule trgt_genotype:
    input:
        bam="{trio}/aligned/{sample}.{trio}.aligned.sorted.haplotagged.bam",
        bai="{trio}/aligned/{sample}.{trio}.aligned.sorted.haplotagged.bam.bai",
        bed=config.get("reference_files", {}).get("repeat_bed", ""),
        fasta=config.get("reference_files", {}).get("fasta_file", ""),
    output:
        "{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.haplotagged.vcf.gz",
        "{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.haplotagged.spanning.bam",
    params:
        prefix=config.get("trgt_genotype_params", {}).get("prefix", ""),
    log:
        "{trio}/logs/trgt/{sample}.{trio}.trgt.haplotagged.genotype.log",
    message:
        "{rule}: genotypes repeats for {input.bam}.",
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
        "trgt --genome {input.fasta} --repeats {input.bed} --reads {input.bam} --output-prefix {params.prefix}"

#rule trgt_plot:
#    input:
#        vcf="{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.haplotagged.vcf.gz",
#        bed=config.get("reference_files", {}).get("repeat_bed", ""),
#        fasta=config.get("reference_files", {}).get("fasta_file", ""),
#        bam="{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.haplotagged.spanning.bam",
#        repeat=extract_repeat_names,
#    output: 
#        "{trio}/repeat_calling/trgt/{sample}.{trio}.{input.repeat}.trgt.svg",
#    params:
#    log:
#        "{trio}/logs/trgt/{sample}.{trio}.trvz.haplotagged.log",
#    message:
#        "{rule}: Visualization of repeats for {wildcards.sample}."
#    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
#    resources:
#        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
#        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
#        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
#        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
#        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
#    container:
#        config.get("trgt_plot_params", {}).get("container", config["default_container"])
#    shell:
#        "trgt plot --genome {input.fasta} "
#        "--repeats {input.bed} --vcf {input.vcf} "
#        "--spanning-reads {input.bam} --repeat-id {input.repeat} "
#        "--image {output}"

rule whatshap_phase:
    input:
	vcf="snp_calling/deepvariant/{trio}/{sample}.{trio}.SNP.indel.vcf.gz",
        bam="aligned/{trio}/{sample}.{trio}.aligned.sorted.bam",
        ref=config.get("reference_files", {}).get("fasta_file", ""),
    output:
	"snp_calling/whatshap/{trio}/{sample}.{trio}.SNP.indel.phased.vcf",
    params:
	indels=config.get("whatshap_phase_params", {}).get("indels", "")
    log:
        "logs/whatshap/{trio}/{sample}.{trio}.SNP.indel.phased.vcf",
    threads: config.get("whatshap_phase_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
	mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("whatshap_phase_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
	config.get("whatshap_phase_params", {}).get("container", config["whatshap_phase_params"])
    message:
	"{rule}: Phasing {input.vcf} using whatshap using SNPs and indels."
    shell:
	"whatshap phase {params.indels} -o {output} --reference={input.ref} {input.vcf} {input.bam}"

rule whatshap_stats:
    input:
	"snp_calling/whatshap/{trio}/{sample}.{trio}.SNP.indel.phased.vcf",
    output:
	"snp_calling/whatshap/{trio}/{sample}.{trio}.SNP.indel.phased.vcf.stats.tsv"
    params:
	filename="{sample}.{trio}.SNP.indel.phased.vcf.stats.tsv"
    log:
        "logs/whatshap/{trio}/{sample}.{trio}.SNP.indel.phased.vcf.stats.log"
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
	mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
	config.get("whatshap_stats_params", {}).get("container", config["whatshap_phase_params"])
    message:
        "{rule}: Calculating statistics for {input}."
    shell:
	"whatshap stats --tsv {params.filename} {input} > {output}"


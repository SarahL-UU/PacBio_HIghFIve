rule bcftools_stats:
    input:
	vcf="snp_calling/deepvariant/{trio}/{sample}.{trio}.SNP.indel.vcf.gz",
        fasta=config.get("reference_files", {}).get("fasta_file", ""),
    output:
	"qc/bcftools/{trio}/{sample}.{trio}.SNP.indel.vcf.stats",
    log:
        "log/bcftools/{trio}/{sample}_bcftools_stats.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
	mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
	config.get("bcftools_stats_params", {}).get("container", config["default_container"])
    message:
	"{rule}: Calculate statistics for {input.vcf}."
    shell:
	"bcftools stats --fasta-ref {input.fasta} - < {input.vcf} > {output}"

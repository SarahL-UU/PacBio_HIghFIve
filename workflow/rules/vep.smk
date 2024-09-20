rule vep_annotate:
    input:
	cache=config.get("vep_annotate_params", {}).get("vep_cache", ""),
        fasta=config.get("reference_files", {}).get("fasta_file", ""),
        tbi="{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.sorted.filtered.vcf.gz.tbi",
        vcf="{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.sorted.filtered.vcf.gz",
    output:
	vcf="{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.sorted.filtered.annotated.vcf.gz",
    params:
	extra=config.get("vep_annotate_params", {}).get("extra", ""),
        mode=config.get("vep_annotate_params", {}).get("mode", ""),
    log:
        "{trio}/logs/{sample}.{trio}.SNP.indel.phased.sorted.filtered.annotated.vcf.gz.log",
    threads: config.get("vep_annotate_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
	mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("vep_annotate_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("vep_annotate_params", {}).get("time", config["default_resources"]["time"]),
    container:
	config.get("vep_annotate_params", {}).get("container", config["default_container"])
    message:
	"{rule}: vep annotate {input.vcf}"
    shell:
	"(vep "
        "--vcf "
        "--no_stats "
        "-o {output.vcf} "
        "-i {input.vcf} "
        "--dir_cache {input.cache} "
        "--fork {threads} "
        "{params.mode} "
        " --compress_output gzip "
        "--fasta {input.fasta} "
        "{params.extra} ) &> {log}"

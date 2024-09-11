rule bgzip_zip:
    input:
        vcf="{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.vcf",
    output:
        "{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.gz",
    log:
        "{trio}/logs/bgzip/{sample}.{trio}.SNP.indel.phased.vcf.gz.log",
    threads: config.get("bgzip_zip_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("bgzip_zip_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("bgzip_zip_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Zip phased {input.vcf} using bgzip."
    shell:
        "bgzip --stdout --threads {threads} {input.vcf} > {output}"

rule tabix_index_snp:
    input:
        vcf="{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.gz",
    output:
        "{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.gz.tbi",
    params:
        preset=config.get("tabix_index_params", {}).get("preset", "")
    log:
        "{trio}/logs/tabix/{sample}.{trio}.SNP.indel.phased.vcf.gz.tbi.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("tabix_index_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Indexing phasing {input.vcf} using tabix."
    shell:
        "tabix -p {params.preset} -f {input.vcf} > {output}"

rule tabix_index_sv:
    input:
        vcf="{trio}/sv_calling/pbsv/{sample}.{trio}.haplotagged.sv.vcf.gz",
    output:
        "{trio}/sv_calling/pbsv/{sample}.{trio}.haplotagged.sv.vcf.gz.tbi",
    params:
        preset=config.get("tabix_index_params", {}).get("preset", "")
    log:
        "{trio}/logs/tabix/{sample}.{trio}.haplotagged.sv.vcf.gz.tbi.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("tabix_index_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Indexing phasing {input.vcf} using tabix."
    shell:
        "tabix -p {params.preset} -f {input.vcf} > {output}"

rule tabix_index_sv_sniffles:
    input:
        vcf="{trio}/sv_calling/sniffles/{sample}.{trio}.sv.haplotagged.sniffles.vcf.gz",
    output:
        "{trio}/sv_calling/sniffles/{sample}.{trio}.sv.haplotagged.sniffles.vcf.gz.tbi",
    params:
        preset=config.get("tabix_index_params", {}).get("preset", "")
    log:
        "{trio}/logs/tabix/{trio}/{sample}.{trio}.sv.haplotagged.sniffles.vcf.gz.tbi.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("tabix_index_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Indexing phasing {input.vcf} using tabix."
    shell:
        "tabix -p {params.preset} -f {input.vcf} > {output}"

rule bcftools_stats:
    input:
        vcf="{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.sorted.filtered.vcf.gz",
        fasta=config.get("reference_files", {}).get("fasta_file", ""),
    output:
        "{trio}/qc/bcftools/{sample}.{trio}.SNP.indel.phased.sorted.filtered.vcf.gz.stats",
    params:
        filter=config.get("bcftools_stats_params", {}).get("filter", ""),
    log:
        "{trio}/logs/bcftools/{sample}.{trio}_bcftools_stats.log",
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
        "bcftools stats -f {params.filter} --fasta-ref {input.fasta} - < {input.vcf} > {output}"

rule bcftools_sort_whatshap:
    input:
        vcf="{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.gz",
    output:
        "{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.sorted.vcf.gz",
    params:
        type=config.get("bcftools_sort_params", {}).get("type", ""),
    log:
        "{trio}/logs/bcftools/{sample}.{trio}_bcftools_sort.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("bcftools_sort_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Sorting {input.vcf}."
    shell:
        "bcftools sort {input.vcf} --output-type {params.type} -o {output}"

rule bcftools_filter:
    input:
        vcf="{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.sorted.vcf.gz",
    output:
        "{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.sorted.filtered.vcf.gz"
    params:
        filter=config.get("bcftools_filter_params", {}).get("filter", ""),
    log:
        "{trio}/logs/bcftools/{sample}_bcftools_filter.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("bcftools_filter_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Calculate statistics for {input.vcf}."
    shell:
        "bcftools filter -e {params.filter} {input.vcf} > {output}"

rule bcftools_sort_trgt:
    input:
        vcf="{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.haplotagged.vcf.gz",
    output:
        "{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.sorted.haplotagged.vcf.gz",
    params:
        type=config.get("bcftools_sort_trgt_params", {}).get("type", ""),
    log:
        "{trio}/logs/bcftools/{sample}.{trio}_bcftools_sort_trgt.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("bcftools_sort_trgt_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Sorting {input.vcf}."
    shell:
        "bcftools sort {input.vcf} --output-type {params.type} -o {output}"

rule bcftools_index_trgt:
    input:
        vcf="{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.haplotagged.vcf.gz",
    output:
        "{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.sorted.haplotagged.vcf.gz.tbi",
    log:
        "{trio}/logs/bcftools/{sample}.{trio}_bcftools_index_trgt.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("bcftools_index_trgt_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Sorting {input.vcf}."
    shell:
        "bcftools index {input.vcf} {output}"

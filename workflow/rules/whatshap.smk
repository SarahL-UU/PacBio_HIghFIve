rule whatshap_phase:
    input:
        vcf="{trio}/snp_calling/deepvariant/{sample}.{trio}.SNP.indel.vcf.gz",
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
        ref=config.get("reference_files", {}).get("fasta_file", ""),
    output:
        "{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.vcf",
    params:
        indels=config.get("whatshap_phase_params", {}).get("indels", "")
    log:
        "{trio}/logs/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.log",
    threads: config.get("whatshap_phase_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("whatshap_phase_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("whatshap_phase_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Phasing {input.vcf} using whatshap using SNPs and indels."
    shell: 
        "whatshap phase {params.indels} -o {output} --reference={input.ref} {input.vcf} {input.bam}"

rule whatshap_stats:
    input:
        "{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.vcf",
    output:
        "{trio}/qc/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.stats.tsv"
    params:
        filename="{sample}.{trio}.SNP.indel.phased.vcf.stats.tsv"
    log:
        "{trio}/logs/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.stats.log"
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("whatshap_stats_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Calculating statistics for {input}."
    shell:
        "whatshap stats --tsv {params.filename} {input} > {output}"

rule whatshap_haplotag:
    input:
        vcf="{trio}/snp_calling/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.gz",
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
        ref=config.get("reference_files", {}).get("fasta_file", ""),
    output:
        "{trio}/aligned/{sample}.{trio}.aligned.sorted.haplotagged.bam"
    params:
        filename="{sample}.{trio}.SNP.indel.phased.vcf.stats.tsv"
    log:
        "{trio}/logs/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.stats.log"
    threads: config.get("whatshap_haplotag_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("whatshap_haplotag_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("whatshap_stats_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Haplotagging {input.bam} using {input.vcf}."
    shell:
        "whatshap haplotag --output-threads={threads} -o {output} --reference {input.ref} {input.vcf} {input.bam}"

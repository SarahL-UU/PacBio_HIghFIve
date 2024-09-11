rule samtools_stats:
    input:
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
    output:
        "{trio}/qc/samtools/{sample}.{trio}.samtools-stats.txt",
    log:
        "{trio}/logs/samtools/{sample}.{trio}.samtools-stats.log",
    message:
        "{rule}: produces comprehensive statistics from alignment file {input.bam}."
    threads: config.get("samtools_stats", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_stats_params", {}).get("container", config["default_container"])
    shell:
        "samtools stats {input.bam} > {output}"


rule samtools_flagstat:
    input:
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
    output:
        "{trio}/qc/samtools/{sample}.{trio}.samtools-flagstat.txt",
    log:
        "{trio}/logs/samtools/{sample}.{trio}.samtools-flagstat.log",
    message:
        "{rule}: counts the number of alignments for each FLAG type for {input.bam}."
    threads: config.get("samtools_flagstat_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("samtools_flagstat_params", {}).get("threads", config["samtools_flagstat_params"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_flagstat_params", {}).get("container", config["default_container"])
    shell:
        "samtools flagstat -@ {threads} {input.bam} > {output}"

rule samtools_idxstats:
    input:
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
    output:
        "{trio}/qc/samtools/{sample}.{trio}.samtools-idxstats.txt",
    log:
        "{trio}/logs/samtools/{sample}.{trio}.samtools-idxstats.log",
    message:
        "{rule}: reports alignment summary statistics using idxstats for {input.bam}"
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_idxstats_params", {}).get("container", config["default_container"])
    shell:
        "samtools idxstats {input.bam} > {output}"

rule samtools_index:
    input:
        bam="{trio}/aligned/{sample}.{trio}.aligned.sorted.haplotagged.bam",
    output:
        "{trio}/aligned/{sample}.{trio}.aligned.sorted.haplotagged.bam.bai",
    log:
        "{trio}/logs/samtools/{sample}.{trio}.samtools-index.log",
    message:
        "{rule}: indexing {input.bam}."
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_index_params", {}).get("container", config["default_container"])
    shell:
        "samtools index -b {input.bam} {output}"

rule samtools_sort_trgt:
    input:
        bam="{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.haplotagged.spanning.bam",
    output:
        "{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.sorted.haplotagged.spanning.bam",
    log:
        "{trio}/logs/samtools/{sample}.{trio}.samtools-sort-trgt.log",
    message:
        "{rule}: sorting {input.bam}."
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_sort_trgt_params", {}).get("container", config["default_container"])
    shell:
        "samtools sort -o {output} {input.bam}"


rule samtools_index_trgt:
    input:
        bam="{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.sorted.haplotagged.spanning.bam",
    output:
        "{trio}/repeat_calling/trgt/{sample}.{trio}.trgt.sorted.haplotagged.spanning.bam.bai",
    log:
        "{trio}/logs/samtools/{sample}.{trio}.samtools-index.trgt.log",
    message:
        "{rule}: indexing {input.bam}"
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_index_trgt_params", {}).get("container", config["default_container"])
    shell:
        "samtools index -b {input.bam} {output}"

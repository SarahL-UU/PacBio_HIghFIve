rule samtools_stats:
    input:
	bam="aligned/{sample}.aligned.sorted.bam",
    output:
	"qc/samtools_stats/{sample}.samtools-stats.txt",
    log:
        "logs/samtools_stats/{sample}.log",
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
	bam="aligned/{sample}.aligned.sorted.bam",
    output:
	"qc/samtools_flagstat/{sample}.samtools-flagstat.txt",
    log:
        "logs/samtools_flagstat/{sample}.log",
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

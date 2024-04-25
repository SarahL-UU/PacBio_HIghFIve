rule mosdepth:
    input:
	bam="aligned/{sample}.aligned.sorted.bam",
    output:
	"{sample}.mosdepth.global.dist.txt",
        "{sample}.per-base.bed.gz",  # produced unless --no-per-base specified
        "{sample}.mosdepth.summary.txt",  # this named output is required for prefix parsing
        "{sample}.mosdepth.region.dist.txt",
        "{sample}.regions.bed.gz",
    log:
        "logs/mosdepth/{sample}.log",
    params:
	extra=config.get("mosdepth_params", {}).get("extra", ""),
        by=config.get("mosdepth_params", {}).get("by", ""),
    threads: config.get("mosdepth_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
	mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("mosdepth_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("mosdepth_params", {}).get("time", config["default_resources"]["time"]),
    container:
	config.get("mosdepth_params", {}).get("container", config["default_container"])
    message:
	"{rule}: calculating coverage for {input.bam}."
    shell:
	"mosdepth {params.extra} --by {params.by} -t {resources.threads} {wildcards.sample} {input.bam}"

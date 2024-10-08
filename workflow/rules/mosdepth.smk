rule mosdepth:
    input:
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
    output:
        "{trio}/qc/mosdepth/{sample}.{trio}.mosdepth.global.dist.txt",
        "{trio}/qc/mosdepth/{sample}.{trio}.per-base.bed.gz",  # produced unless --no-per-base specified
        "{trio}/qc/mosdepth/{sample}.{trio}.mosdepth.summary.txt",  # this named output is required for prefix parsing
        "{trio}/qc/mosdepth/{sample}.{trio}.mosdepth.region.dist.txt",
        "{trio}/qc/mosdepth/{sample}.{trio}.regions.bed.gz",
    log:
        "{trio}/logs/mosdepth/{sample}.mosdepth.log",
    params:
        extra=config.get("mosdepth_params", {}).get("extra", ""),
        by=config.get("mosdepth_params", {}).get("by", ""),
        prefix="{trio}/qc/mosdepth/{sample}.{trio}"
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
        "mosdepth {params.extra} --by {params.by} -t {resources.threads} {params.prefix} {input.bam}"

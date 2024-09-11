rule picard_collectalignmentsummarymetrics:
    input:
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
        ref=config.get("reference_files", {}).get("fasta_file", ""),
    output:
        "{trio}/qc/picard/{sample}.{trio}.aligned.sorted.bam.summarymetrics.txt",
    log:
        "{trio}/logs/picard/{sample}.{trio}.aligned.sorted.bam.picard.summarymetrics.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("defaults_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_collectalignmentsummarymetrics_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Produces a summary of alignment metrics from picard for {input.bam}"
    shell:
        "picard CollectAlignmentSummaryMetrics R={input.ref} I={input.bam} O={output}"


rule picard_collectgcbiasmetrics:
    input:
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
        ref=config.get("reference_files", {}).get("fasta_file", ""),
    output:
        metrics="{trio}/qc/picard/{sample}.{trio}.aligned.sorted.bam.gcmetrics.txt",
        chart="{trio}/qc/picard/{sample}.{trio}.aligned.sorted.bam.gc.pdf",
        summary="{trio}/qc/picard/{sample}.{trio}.aligned.sorted.bam.gcsummary.txt",
    log:
        "{trio}/logs/picard/{sample}.{trio}.aligned.sorted.bam.gcmetrics.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("defaults_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_collectgcbiasmetrics_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Collect metrics regarding GC bias from picard for {input.bam}"
    shell:
        "picard CollectGcBiasMetrics "
        "I={input.bam} O={output.metrics} "
        "CHART={output.chart} "
        "S={output.summary} R={input.ref}"

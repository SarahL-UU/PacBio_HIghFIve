rule pbsv_discover:
    input:
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
        bed=config.get("reference_files", {}).get("bed_file", ""),
    output:
        "{trio}/sv_calling/pbsv/{sample}.{trio}.haplotagged.svsig.gz",
    params:
        preset="--hifi",
        loglevel="INFO",
    log:
        "{trio}/logs/pbsv/{sample}.{trio}_pbsv_discover.haplotagged.log",
    threads: config.get("pbsv_discover_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("pbsv_discover_params", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("pbsv_discover_params", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("pbsv_discover_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("pbsv_discover_params", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("pbsv_discover_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Create svsig file from {input.bam} with {input.bed}."
    shell:
        "(pbsv discover {params.preset} --log-level {params.loglevel} "
        "--tandem-repeats {input.bed} "
        "{input.bam} {output} ) &> {log}"

rule pbsv_call:
    input:
        fasta=config.get("reference_files", {}).get("fasta_file", ""),
        svsig="{trio}/sv_calling/pbsv/{sample}.{trio}.haplotagged.svsig.gz",
    output:
        vcf="{trio}/sv_calling/pbsv/{sample}.{trio}.haplotagged.sv.vcf",
    params:
        preset="--hifi",
        loglevel="INFO",
        #region=,
    log:
        "{trio}/logs/pbsv/{sample}.{trio}_pbsv_call.haplotagged.log",
    threads: config.get("pbsv_call_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("pbsv_call_params", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("pbsv_call_params", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("pbsv_call_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("pbsv_call_params", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("pbsv_call_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Call structural variants for {wildcards.sample}."
    shell:
        "(pbsv call -j {threads} {params.preset} "
        "--log-level {params.loglevel} {input.fasta} {input.svsig} "
        "{output.vcf} ) &> {log}"

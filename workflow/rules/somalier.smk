rule somalier_extract:
    input:
        fasta=config.get("reference_files", {}).get("fasta_file", ""),
        bam="aligned/{trio}/{sample}.{trio}.aligned.sorted.bam",
        vcf=config.get("reference_files", {}).get("sites_vcf", ""),
    output:
        "qc/somalier/extract/{trio}/{sample}.{trio}.somalier",
    params:
        outdir="qc/somalier/extract/{trio}",
        prefix="{sample}.{trio}",
    log:
        "logs/somalier/extract/{trio}/{sample}.{trio}.somalier.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("defaults_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_extract_params", {}).get("container", config["default_container"])
    message:
        "{rule}: extract genotype-like information for a single-sample from somalier for {input.bam}"
    shell:
        "somalier extract --out-dir={params.outdir} --sample-prefix {params.prefix} --sites {input.vcf} -f {input.fasta} {input.bam} > {output}"

rule somalier_relate:
    input:
        extract_files=expand("qc/somalier/extract/{trio}/{sample}.{trio}.somalier", sample=samples["sample"], trio=samples["trioid"])
    output:
        samples_tsv="qc/somalier/relate/{trio}/{trio}.samples.tsv",
        pairs_tsv="qc/somalier/relate/{trio}/{trio}.pairs.tsv",
        groups_tsv="qc/somalier/relate/{trio}/{trio}.groups.tsv",
        html="qc/somalier/relate/{trio}/{trio}.html",
    params:
        outdir="qc/somalier/relate/{trio}"
    log:
        "logs/somalier/relate/{trio}/{trio}.somalier_relate.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
    resources:
        mem_mb=config.get("defaults_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("somalier_relate_params", {}).get("container", config["default_container"]),
    message:
        "{rule}: Calculate relatedness on extracted data for trio {wildcards.trio}.",
    shell:
        "somalier relate --infer --unknown -o {params.outdir} {input.extract_files}"

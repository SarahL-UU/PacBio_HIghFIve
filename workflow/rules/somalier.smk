rule somalier_extract:
    input:
        fasta=config.get("reference_files", {}).get("fasta_file", ""),
        bam="{trio}/aligned/pbmm2/{sample}.{trio}.aligned.sorted.bam",
        vcf=config.get("reference_files", {}).get("sites_vcf", ""),
    output:
        "{trio}/qc/somalier/{sample}.{trio}.somalier",
    params:
        outdir="{trio}/qc/somalier/",
        prefix="{sample}",
    log:
        "{trio}/logs/somalier/{sample}.{trio}.somalier.log",
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
        extract_files=expand("{trio}/qc/somalier/{sample}.somalier", zip, sample=samples["sample"], trio=samples["trioid"]),
        ped=config.get("somalier_relate_params", {}).get("ped", ""),
    output:
        samples_tsv="{trio}/qc/somalier/{trio}.somalier.samples.tsv",
        pairs_tsv="{trio}/qc/somalier/{trio}.somalier.pairs.tsv",
        groups_tsv="{trio}/qc/somalier/{trio}.somalier.groups.tsv",
        html="{trio}/qc/somalier/{trio}.somalier.html",
    params:
        outdir="{trio}/qc/somalier/{trio}.somalier",
        prefix="{trio}.somalier",
    log:
        "{trio}/logs/somalier/{trio}.somalier_relate.log",
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
        "somalier relate --ped={input.ped} --unknown --sample-prefix={params.prefix} -o {params.outdir} {input.extract_files}"

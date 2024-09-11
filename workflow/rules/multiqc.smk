rule multiqc_prep:
    input:
        expand("{trio}/qc/fastqc/{sample}.{trio}_fastqc.zip", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/mosdepth/{sample}.{trio}.mosdepth.global.dist.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/mosdepth/{sample}.{trio}.per-base.bed.gz", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/mosdepth/{sample}.{trio}.mosdepth.summary.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/mosdepth/{sample}.{trio}.mosdepth.region.dist.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/mosdepth/{sample}.{trio}.regions.bed.gz", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/samtools/{sample}.{trio}.samtools-stats.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/samtools/{sample}.{trio}.samtools-flagstat.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/samtools/{sample}.{trio}.samtools-idxstats.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/picard/{sample}.{trio}.aligned.sorted.bam.summarymetrics.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/picard/{sample}.{trio}.aligned.sorted.bam.gcmetrics.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/picard/{sample}.{trio}.aligned.sorted.bam.gc.pdf", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/picard/{sample}.{trio}.aligned.sorted.bam.gcsummary.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        "{trio}/qc/somalier/{trio}.somalier.samples.tsv",
        "{trio}/qc/somalier/{trio}.somalier.pairs.tsv",
        expand("{trio}/qc/bcftools/{sample}.{trio}.SNP.indel.phased.sorted.filtered.vcf.gz.stats", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("{trio}/qc/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.stats.tsv", zip, sample=samples["sample"], trio=samples["trioid"]),
    output:
        "{trio}/qc/multiqc/multiqc_dirs_{trio}.txt",
    log:
        "{trio}/logs/multiqc/{trio}_multiqc_prep.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("defaults_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),    
    message:
        "Prepares input file for multiqc using all qc files for {wildcards.trio}."
        "Read paths from file into an array, extract directories, and remove duplicates for {wildcards.trio}.",
    shell:
        "echo {input} | xargs -n1 dirname | sort -u > {output}"

rule multiqc_report:
    input:
        dirs="{trio}/qc/multiqc/multiqc_dirs_{trio}.txt",
    output:
        html="{trio}/qc/multiqc/multiqc_{trio}.html",
        data=directory("{trio}/qc/multiqc/multiqc_{trio}_data"),
    log:
        "{trio}/logs/multiqc/{trio}_multiqc.log",
    params:
        dir="{trio}/qc/multiqc"
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("defaults_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("multiqc_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Multiqc summary report on {wildcards.trio}."
    shell:
        "multiqc --filename multiqc_{wildcards.trio} --outdir {params.dir} --file-list {input.dirs}"

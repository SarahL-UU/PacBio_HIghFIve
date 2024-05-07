rule multiqc_prep:
    input:
	expand("results/{trio}/{sample}/fastqc/{sample}.{trio}_fastqc.zip", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/mosdepth/{sample}.{trio}.mosdepth.global.dist.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/mosdepth/{sample}.{trio}.per-base.bed.gz", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/mosdepth/{sample}.{trio}.mosdepth.summary.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/mosdepth/{sample}.{trio}.mosdepth.region.dist.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/mosdepth/{sample}.{trio}.regions.bed.gz", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/samtools/{sample}.{trio}.samtools-stats.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/samtools/{sample}.{trio}.samtools-flagstat.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/samtools/{sample}.{trio}.samtools-idxstats.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/collectalignmentsummarymetrics/{sample}.{trio}.aligned.sorted.bam.summary.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/picard/collectgcbiasmetrics/{sample}.{trio}.aligned.sorted.bam.gcmetrics.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/picard/collectgcbiasmetrics/{sample}.{trio}.aligned.sorted.bam.gc.pdf", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/picard/collectgcbiasmetrics/{sample}.{trio}.aligned.sorted.bam.summary.txt", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/bcftools/{sample}.{trio}.SNP.indel.vcf.stats", zip, sample=samples["sample"], trio=samples["trioid"]),
        expand("results/{trio}/{sample}/whatshap/{sample}.{trio}.SNP.indel.phased.vcf.stats.tsv", zip, sample=samples["sample"], trio=samples["trioid"]),
    output:
	"qc/multiqc/{trio}/multiqc_dirs_{trio}.txt",
    log:
        "logs/multiqc/{trio}/{trio}_multiqc_prep.log",
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
	dirs="qc/multiqc/{trio}/multiqc_dirs_{trio}.txt",
    output:
	html="qc/multiqc/{trio}/multiqc_{trio}.html",
        data=directory("qc/multiqc/{trio}/multiqc_{trio}_data"),
    log:
        "logs/multiqc/{trio}/{trio}_multiqc.log",
    params:
	upload="--no-megaqc-upload",
        dir="qc/multiqc/{trio}"
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
	"multiqc {params.upload} --filename multiqc_{wildcards.trio} --outdir {params.dir} --file-list {input.dirs}"

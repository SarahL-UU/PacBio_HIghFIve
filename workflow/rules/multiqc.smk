rule multiqc_prep:
    input:
	"results/{sample}/fastqc/{sample}_fastqc.zip",
        "results/{sample}/mosdepth/{sample}.mosdepth.global.dist.txt",
        "results/{sample}/mosdepth/{sample}.per-base.bed.gz",
        "results/{sample}/mosdepth/{sample}.mosdepth.summary.txt",
        "results/{sample}/mosdepth/{sample}.mosdepth.region.dist.txt",
        "results/{sample}/mosdepth/{sample}.regions.bed.gz",
        "results/{sample}/samtools/{sample}.samtools-stats.txt",
        "results/{sample}/samtools/{sample}.samtools-flagstat.txt",
        "results/{sample}/samtools/{sample}.samtools-idxstats.txt",
        "results/{sample}/collectalignmentsummarymetrics/{sample}.aligned.sorted.bam.summary.txt",
        "results/{sample}/picard/collectgcbiasmetrics/{sample}.aligned.sorted.bam.gcmetrics.txt",
        "results/{sample}/picard/collectgcbiasmetrics/{sample}.aligned.sorted.bam.gc.pdf",
        "results/{sample}/picard/collectgcbiasmetrics/{sample}.aligned.sorted.bam.summary.txt",
    output:
	"qc/multiqc/multiqc_dirs_{sample}.txt",
    log:
        "logs/multiqc/{sample}_multiqc_prep.log",
    threads: config.get("default_resources", {}).get("threads", config["default_resources"]["threads"])
    resources:
	mem_mb=config.get("defaults_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("defaults_resources", {}).get("time", config["default_resources"]["time"]),
    message:
	"Prepares input file for multiqc using all qc files for {wildcards.sample}."
        "Read paths from file into an array, extract directories, and remove duplicates for {wildcards.sample}.",
    shell:
	"echo {input} | xargs -n1 dirname | sort -u > {output}"

rule multiqc_report:
    input:
	dirs="qc/multiqc/multiqc_dirs_{sample}.txt"
    output:
	html="qc/multiqc/multiqc_{sample}.html",
        data=directory("qc/multiqc/multiqc_{sample}_data"),
    log:
        "logs/multiqc/{sample}_multiqc.log",
    params:
	upload="--no-megaqc-upload",
        dir="qc/multiqc"
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
	"{rule}: Multiqc summary report on {wildcards.sample}."
    shell:
	"multiqc {params.upload} --filename multiqc_{wildcards.sample} --outdir {params.dir} --file-list {input.dirs}"


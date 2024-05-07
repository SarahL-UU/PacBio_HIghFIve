rule fastqc_prealignment_qc:
    input:
	query=pbmm2_input,
    output:
	"qc/fastqc/{trio}/{sample}/{sample}.{trio}_fastqc.html",
        "qc/fastqc/{trio}/{sample}/{sample}.{trio}_fastqc.zip",
    log:
        "logs/fastqc/{trio}/{sample}/{sample}_fastqc.log",
    params:
	dir="qc/fastqc/{trio}/{sample}"
    threads: config.get("fastqc_params", {}).get("threads", config["fastqc_params"]["threads"])
    resources:
	mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("fastqc_params", {}).get("threads", config["fastqc_params"]["threads"]),
        time=config.get("fastqc_params", {}).get("time", config["fastqc_params"]["time"]),
    container:
	config.get("fastqc_params", {}).get("container", config["fastqc_params"])
    message:
	"{rule}: Run fastQC on file {input.query}."
    shell:
	"""
	fastqc -t {threads} --outdir {params.dir} {input.query}
        mv {params.dir}/*.hifi_reads*_fastqc.html {params.dir}/{wildcards.sample}.{wildcards.trio}_fastqc.html
        mv {params.dir}/*.hifi_reads*_fastqc.zip {params.dir}/{wildcards.sample}.{wildcards.trio}_fastqc.zip
        """

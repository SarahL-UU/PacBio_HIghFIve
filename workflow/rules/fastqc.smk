rule fastQC_prealignment_qc:
    input:
        query=pbmm2_input,
    output:
        "qc/fastqc/{sample}_fastqc.html",
	"qc/fastqc/{sample}_fastqc.zip"
    params:
    log:
        "logs/fastqc/{sample}_fastqc.log"
    threads: 2
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("", config["default_resources"]["partition"]),
        threads=config.get("default_resources", {}).get("", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("", config["default_resources"]["time"]),
    container:
        config.get("fastqc_params", {}).get("container", config["default_container"]),
    message:
        "{rule}: Run fastQC on file {input.query}."
    shell:
        "fastqc {input.query}"

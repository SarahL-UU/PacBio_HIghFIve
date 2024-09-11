rule svanna_prioritize:
    input:
        vcf="{trio}/sv_calling/pbsv/{sample}.{trio}.haplotagged.sv.vcf",
        data=config.get("reference_files", {}).get("svanna-data", ""),
    output: 
        "{trio}/sv_calling/svanna/{sample}.{trio}.haplotagged.sv.SVANNA.tsv.gz",
        "{trio}/sv_calling/svanna/{sample}.{trio}.haplotagged.sv.SVANNA.html",
    params:
        output=config.get("svanna_prioritize_params", {}).get("output_format", ""),
        outdir=config.get("svanna_prioritize_params", {}).get("outdir", ""),
        HPO="HP:0034241"
    threads: config.get("svanna_prioritize_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("svanna_prioritize_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("default_resources", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("svanna_prioritize_params", {}).get("container", config["default_container"])
    log:
        "{trio}/logs/svanna/{sample}.{trio}.svanna.log",
    message:
        "{rule}: Rank SVs using SvAnna for {input.vcf}."
    shell:
        "java -jar /svanna-cli-1.0.4/svanna-cli-1.0.4.jar prioritize -d {input.data} --output-format {params.output} "
        "--out-dir {params.outdir} --phenotype-term {params.HPO} --vcf {input.vcf}"

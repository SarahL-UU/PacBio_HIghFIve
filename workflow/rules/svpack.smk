rule svpack_filter:
    input:
        vcf="{trio}/sv_calling/pbsv/{sample}.{trio}.haplotagged.sv.vcf.gz",
        tbi="{trio}/sv_calling/pbsv/{sample}.{trio}.haplotagged.sv.vcf.gz.tbi",
        eee_vcf=config.get("reference_files", {}).get("eee_vcf", ""),
        gnomadsv_vcf=config.get("reference_files", {}).get("gnomadsv_vcf", ""),
        hprc_pbsv_vcf=config.get("reference_files", {}).get("hprc_pbsv_vcf", ""),
        decode_vcf=config.get("reference_files", {}).get("decode_vcf", ""),
        gff=config.get("reference_files", {}).get("gff", ""),
    output:
        "{trio}/sv_calling/svpack/{sample}.{trio}.haplotagged.sv.sorted.svpack.vcf.gz",
    params:
        min_sv_length=config.get("svpack_filter_params", {}).get("min_sv_length", ""),
    log:
        "{trio}/logs/svpack/{sample}.{trio}_svpack_filter.log",
    threads: config.get("svpack_filter_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("svpack_filter_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("svpack_filter_params", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("svpack_filter_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Filtering and annotating SVs in {input.vcf}."
    shell:
        "(zcat {input.vcf} | "
        "svpack filter --pass-only --min-svlen {params.min_sv_length} - | "
        "svpack match -v - {input.eee_vcf} | "
        "svpack match -v - {input.gnomadsv_vcf} | "
        "svpack match -v - {input.hprc_pbsv_vcf} | "
        "svpack match -v - {input.decode_vcf} | "
        "svpack consequence - <(zcat {input.gff}) > {output}) &> {log}"

rule svpack_filter_sniffles:
    input:
        vcf="{trio}/sv_calling/sniffles/{sample}.{trio}.sv.haplotagged.sniffles.vcf.gz",
        tbi="{trio}/sv_calling/sniffles/{sample}.{trio}.sv.haplotagged.sniffles.vcf.gz.tbi",
        eee_vcf=config.get("reference_files", {}).get("eee_vcf", ""),
        gnomadsv_vcf=config.get("reference_files", {}).get("gnomadsv_vcf", ""),
        hprc_pbsv_vcf=config.get("reference_files", {}).get("hprc_pbsv_vcf", ""),
        decode_vcf=config.get("reference_files", {}).get("decode_vcf", ""),
        gff=config.get("reference_files", {}).get("gff", ""),
    output:
        "{trio}/sv_calling/sniffles/{sample}.{trio}.sv.haplotagged.sniffles.svpack.vcf.gz",
    params:
        min_sv_length=config.get("svpack_filter_params", {}).get("min_sv_length", ""),
    log:
        "{trio}/logs/svpack/{sample}.{trio}_svpack_filter.sniffles.log",
    threads: config.get("svpack_filter_params", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("default_resources", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("default_resources", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("default_resources", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("svpack_filter_params", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("svpack_filter_params", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("svpack_filter_params", {}).get("container", config["default_container"])
    message:
        "{rule}: Filtering and annotating SVs in {input.vcf}."
    shell:
        "(zcat {input.vcf} | "
        "svpack filter --pass-only --min-svlen {params.min_sv_length} - | "
        "svpack match -v - {input.eee_vcf} | "
        "svpack match -v - {input.gnomadsv_vcf} | "
        "svpack match -v - {input.hprc_pbsv_vcf} | "
        "svpack match -v - {input.decode_vcf} | "
        "svpack consequence - <(zcat {input.gff}) > {output}) &> {log}"

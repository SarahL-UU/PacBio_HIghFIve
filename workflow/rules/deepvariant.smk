rule deepvariant:
    input:
        bam="aligned/{sample}.sorted.Hg38.bam",
        ref=config.get("reference", {}).get("fasta", ""),
    output:
        vcf="deepvariant/{sample}.sorted.Hg38.vcf.gz"
    params:
        model="pacbio",   # {wgs, wes, pacbio, hybrid}
        #sample_name={sample}, # optional
        extra=""
    threads: 2
    log:
        "logs/deepvariant/{sample}/{sample}.deepvariant.log"
    container:
        config.get("deepvariant", {}).get("container", config["default_container"]),
    wrapper:
        "v3.3.6/bio/deepvariant"



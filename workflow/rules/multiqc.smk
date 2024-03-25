# rule multiqc_dir:
#     input:
#         expand("samtools_stats/{sample}.txt"),
#     output:
#         "qc/multiqc.html",
#         directory("qc/multiqc_data"),
#     params:
#         extra="--config /path/to/multiqc_config.yaml",  # Optional: extra parameters for multiqc.
#     log:
#         "logs/{sample}.multiqc.log",
#     wrapper:
#         "/proj/naiss2024-22-121/pb_longread_pipeline/snakemake-wrappers/bio/multiqc"

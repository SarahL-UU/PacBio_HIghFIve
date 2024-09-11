import itertools
import numpy as np
import pathlib
import pandas as pd
import yaml
import os
from snakemake.utils import validate
from snakemake.utils import min_version

from hydra_genetics.utils.misc import get_module_snakefile
from hydra_genetics.utils.resources import load_resources
from hydra_genetics.utils.samples import *
from hydra_genetics.utils.units import *

min_version("7.32.0")

### Set and validate config file

if not workflow.overwrite_configfiles:
    sys.exit("At least one config file must be passed using --configfile/--configfiles, by command line or a profile!")

### Set and validate config file
configfile: "config/config.yaml"
validate(config, schema="../schemas/config.schema.yaml")

### Read and validate resources file

config = load_resources(config, config["resources"])
validate(config, schema="../schemas/resources.schema.yaml")

### Read and validate samples file

samples = (
    pd.read_table(config["samples"], dtype=str)
    .set_index(["sample"], drop=False)
)
validate(samples, schema="../schemas/samples.schema.yaml")

### Read and validate units file

units = (
    pd.read_table(config["units"], dtype=str)
    .set_index(["sample", "platform", "machine", "processing_unit", "barcode", "methylation"], drop=False)
    .dropna(axis='columns').sort_index()
)

#print(units)

validate(units, schema="../schemas/units.schema.yaml")

### Read and validate output file
with open(config["output"]) as output:
    if config["output"].endswith("json"):
        output_spec = json.load(output)
    elif config["output"].endswith("yaml") or config["output"].endswith("yml"):
        output_spec = yaml.safe_load(output.read())

validate(output_spec, schema="../schemas/output_files.schema.yaml")

# Group by trioid and aggregate samples
#trioid_sample_dict = samples.groupby(samples.loc[:, 'trioid'])['sample'].apply(list).to_dict()

#print(trioid_sample_dict)

# Get all possible combinations of sample and trioid
#all_combinations = [(sample, trioid) for trioid, samples in trioid_sample_dict.items() for sample in samples]

#print(all_combinations)

# Set wildcard constraints
wildcard_constraints:
#    sample="|".join(sorted(set(sample for sample, _ in all_combinations))),
#    trio="|".join(sorted(trioid_sample_dict.keys())),
#    repeats="|".join(repeat_names)
    sample="|".join(samples.index),
    trio="|".join(samples.loc[:, 'trioid'])

### Functions

def pbmm2_input(wildcards):

    platform = 'PACBIO'
    unit = units.loc[(wildcards.sample)].dropna()
    bam_file = unit["bam"] 

    return bam_file


#def trgt_plot_input(wildcards):
#
#    sample = wildcards.sample
#    repeat-ids = config["repeat-ids"]
#
#    return repeat-ids

#def extract_repeat_names(config["pathogenic_repeats"]):
#    repeat_names = []
#    with open(input_file, 'r') as file:
#        for line in file:
#            match = re.search(r'ID=([^;]+)', line)
#            if match:
#                repeat_names.append(match.group(1))
#    return repeat_names

def compile_output_list(wildcards):
    outdir = pathlib.Path(output_spec.get("directory", "./"))
    output_files = []

    for f in output_spec["files"]:
        # Please remember to add any additional values down below
        # that the output strings should be formatted with.
        outputpaths = set(
            [
                f["output"].format(sample=sample, trio=trio)
                for sample, trio in zip(samples["sample"], samples["trioid"])
            ]
        )

        for op in outputpaths:
            output_files.append(outdir / Path(op))

    return output_files

def generate_copy_rules(output_spec):
    output_directory = pathlib.Path(output_spec.get("directory", "./"))
    rulestrings = []

    for f in output_spec["files"]:
        if f["input"] is None:
            continue

        rule_name = "_copy_{}".format("_".join(re.split(r"\W{1,}", f["name"].strip().lower())))
        input_file = pathlib.Path(f["input"])
        output_file = output_directory / pathlib.Path(f["output"])

        mem_mb = config.get("_copy", {}).get("mem_mb", config["default_resources"]["mem_mb"])
        mem_per_cpu = config.get("_copy", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"])
        partition = config.get("_copy", {}).get("partition", config["default_resources"]["partition"])
        threads = config.get("_copy", {}).get("threads", config["default_resources"]["threads"])
        time = config.get("_copy", {}).get("time", config["default_resources"]["time"])
        copy_container = config.get("_copy", {}).get("container", config["default_container"])

        rule_code = "\n".join(
            [
                f'@workflow.rule(name="{rule_name}")',
                f'@workflow.input("{input_file}")',
                f'@workflow.output("{output_file}")',
                f'@workflow.log("logs/{rule_name}_{output_file.name}.log")',
                f'@workflow.container("{copy_container}")',
                f'@workflow.resources(time="{time}", threads={threads}, mem_mb="{mem_mb}", '
                f'mem_per_cpu={mem_per_cpu}, partition="{partition}")',
                f'@workflow.shellcmd("{copy_container}")',
                "@workflow.run\n",
                f"def __rule_{rule_name}(input, output, params, wildcards, threads, resources, "
                "log, version, rule, conda_env, container_img, singularity_args, use_singularity, "
                "env_modules, bench_record, jobid, is_shell, bench_iteration, cleanup_scripts, "
                "shadow_dir, edit_notebook, conda_base_path, basedir, runtime_sourcecache_path, "
                "__is_snakemake_rule_func=True):",
                '\tshell("(cp --preserve=timestamps {input[0]} {output[0]}) &> {log}", bench_record=bench_record, '
                "bench_iteration=bench_iteration)\n\n",
            ]
        )

        rulestrings.append(rule_code)

    exec(compile("\n".join(rulestrings), "copy_result_files", "exec"), workflow.globals)

generate_copy_rules(output_spec)

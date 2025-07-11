import pandas as pd

rule fastqc1:
    input:
        R1 = lambda wildcards: get_fastq_path(wildcards.sample, wildcards.batch)+"_R1.fastq.gz",
        R2 = lambda wildcards: get_fastq_path(wildcards.sample, wildcards.batch)+"_R2.fastq.gz"
    output:
        R1_out = "results/{batch}/fastqc/fastqc1/{sample}_R1_fastqc.zip",
        R2_out = "results/{batch}/fastqc/fastqc1/{sample}_R2_fastqc.zip"

    log:
        "logs/{batch}/fastqc1_{sample}.log"

    params:
        outdir = "results/{batch}/fastqc/fastqc1/"
    conda:
        "../envs/fastq.yaml"        

    shell:
        """
        fastqc --noextract --nogroup -o {params.outdir} {input.R1} {input.R2} 2> {log}
        """

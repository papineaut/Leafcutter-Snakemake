rule trim_galore:
    log:
        "logs/{batch}/trimgalore/{sample}.log"
    input:
        R1 = lambda wildcards: get_fastq_path(wildcards.sample, wildcards.batch)+"_R1.fastq.gz",
        R2 = lambda wildcards: get_fastq_path(wildcards.sample, wildcards.batch)+"_R2.fastq.gz"
    output:
        R1_out="results/{batch}/trimgalore/{sample}_R1_val_1.fq",
        R2_out="results/{batch}/trimgalore/{sample}_R2_val_2.fq"

    params:
        output_dir = "results/{batch}/trimgalore"
    conda:
        "../envs/trimgalore.yaml"   
    shell:
        """
        trim_galore --paired --cores 8 \
            --output_dir {params.output_dir} \
            --dont_gzip \
            {input.R1} {input.R2} \
            2> {log}
        """

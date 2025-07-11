rule fastqc2:
    input:
        R1="results/{batch}/trimgalore/{sample}_R1_val_1.fq",
        R2="results/{batch}/trimgalore/{sample}_R2_val_2.fq"
    output:
         R1_out="results/{batch}/fastqc/fastqc2/{sample}_R1_val_1_fastqc.zip",
         R2_out="results/{batch}/fastqc/fastqc2/{sample}_R2_val_2_fastqc.zip"

    log:
        "logs/{batch}/fastqc2_{sample}.log"
    params:
        outdir= "results/{batch}/fastqc/fastqc2"
    conda:
        "../envs/fastq.yaml"   
    shell:
        """
        fastqc --noextract --nogroup -o {params.outdir} {input.R1} {input.R2} 2> {log}
        """

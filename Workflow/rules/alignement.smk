rule alignement:
    output:
        "results/star_align/{sample}Aligned.sortedByCoord.out.bam"
    
    #params:
        #prefix = lambda wildcards: f"results/{wildcards.batch}/star_align/{wildcards.sample}"
    
    input:
        R_S1 = "results/batch1/trimgalore/{sample}_R1_val_1.fq",
        R_S2 = "results/batch2/trimgalore/{sample}_R1_val_1.fq",
        R_R1 = "results/batch1/trimgalore/{sample}_R2_val_2.fq",
        R_R2 = "results/batch2/trimgalore/{sample}_R2_val_2.fq",
        genome = "/home/thomaspv/projects/def-kchoquet/thomaspv/refgen/STARindex"

    log:
        "logs/STAR/{sample}.log"
    
    conda:
        "../envs/alignement.yaml"

    shell:
        """
        STAR \
            --genomeDir {input.genome} \
            --genomeLoad NoSharedMemory \
            --runThreadN 12 \
            --readFilesCommand cat \
            --readFilesIn {input.R_S1},{input.R_S2} {input.R_R1},{input.R_R2} \
            --outFileNamePrefix results/star_align/{wildcards.sample} \
            --outSAMtype BAM SortedByCoordinate \
            --outStd Log \
            --outSAMmode Full \
            --outSAMunmapped None \
            --outReadsUnmapped Fastx \
            --outSAMattributes All \
            --outFilterMultimapNmax 101 \
            --outSJfilterOverhangMin 3 1 1 1 \
            --outSJfilterDistToOtherSJmin 0 0 0 0 \
            --outSAMstrandField intronMotif \
            --alignIntronMin 11 > {log} 2>&1
        """
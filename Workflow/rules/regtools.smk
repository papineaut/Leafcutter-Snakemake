rule regtool:
    input:
       R="results/star_align/{sample}Aligned.sortedByCoord.out.bam",
       idx="results/star_align/{sample}Aligned.sortedByCoord.out.bam.bai",
       genome="data/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
    log:
        "logs/reg_junc/{sample}.txt"
    output:
        "results/reg_junc/{sample}_off.junc",
    conda:
        "../envs/regtool.yaml"
    shell:
        """
        regtools junctions extract -a 8 -m 50 -M 500000 {input.R} -s XS -o {output} {input.genome}
        echo "done" >> {log}
        """

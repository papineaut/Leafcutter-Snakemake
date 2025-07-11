rule sam_idx:
    input:
        "results/star_align/{sample}Aligned.sortedByCoord.out.bam",
    output:
        "results/star_align/{sample}Aligned.sortedByCoord.out.bam.bai",
    log:
        "logs/samtools/idx/{sample}.log",
    conda:
        "../envs/samtools.yaml"
    shell:
        "samtools index {input} {output} -@ {threads} 2> {log}"

rule sam_stats:
    input:
        "results/star_align/{sample}Aligned.sortedByCoord.out.bam",
    output:
        "results/sam_stats/{sample}.txt",
    log:
        "logs/samtools/stats/{sample}.log",
    conda:
        "../envs/samtools.yaml"
    shell:
        "samtools stats {input} -@ {threads} 1> {output} 2> {log}"

rule sam_flagstat:
    input:
        "results/star_align/{sample}Aligned.sortedByCoord.out.bam",
    output:
        "results/sam_flagstat/{sample}.tsv",
    log:
        "logs/samtools/flagstat/{sample}.log",
    conda:
        "../envs/samtools.yaml"
    shell:
        "samtools flagstat {input} -@ {threads} --output-fmt tsv 1> {output} 2> {log}"

rule sam_idxstats:
    input:
        bam="results/star_align/{sample}Aligned.sortedByCoord.out.bam",
    output:
        "results/sam_idxstats/{sample}.tsv",
    log:
        "logs/samtools/idxstats/{sample}.log",
    conda:
        "../envs/samtools.yaml"
    shell:
        "samtools idxstats {input.bam} -@ {threads} 1> {output} 2> {log}"
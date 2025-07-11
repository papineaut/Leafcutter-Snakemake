rule oLEGO_prep:
    input:
        R_S1 = "results/batch1/trimgalore/{sample}_R1_val_1.fq",
        R_S2 = "results/batch2/trimgalore/{sample}_R1_val_1.fq",
        R_R1 = "results/batch1/trimgalore/{sample}_R2_val_2.fq",
        R_R2 = "results/batch2/trimgalore/{sample}_R2_val_2.fq",
    output:
        RS="results/combined/{sample}_sens.fq",
        RR="results/combined/{sample}_reverse.fq"
    log:
        "logs/combined/{sample}"
    shell:
        """
        cat {input.R_S1} {input.R_S2} > {output.RS} 
        cat {input.R_R1} {input.R_R2} > {output.RR}
        """
rule oLEGO_INDEX:
    input:
        "data/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
    output:
        "data/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa.rsa"
    log:
        "logs/olego_index"
    shell:
        """
        olego/olegoindex -a bwtsw {input} &>{log}
        """

rule oLEGO_F:
    input:
        RS="results/combined/{sample}_sens.fq",
        genome="data/genome/hg19.intron.hmr.brainmicro.bed.gz",
        G="data/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa.rsa"
    output:
        F="results/olego_align/{sample}_sens.map"
    log:
        "logs/oLEGO/F/{sample}.txt"
    shell:
        """
        bash -c '
        olego/olego -t 16 -r olego/models/hg.cfg \
              -j <(zcat {input.genome}) \
              -M 4 -o {output.F} {input.RS} &> {log}
        '
        """
rule oLEGO_R:
    input:
        RR="results/combined/{sample}_reverse.fq",
        genome="data/genome/hg19.intron.hmr.brainmicro.bed.gz",
        G="data/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa.rsa"
    log:
        "logs/oLEGO/R/{sample}.txt"
    output:
        R="results/olego_align/{sample}reverse.map"
    shell:
        """
        bash -c '
        olego/olego -t 16 -r olego/models/hg.cfg \
              -j <(zcat {input.genome}) \
              -M 4 -o {output.F} {input.RS} &> {log}
        '
        """

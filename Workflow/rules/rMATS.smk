localrules:
    install_pairdise,


rule install_pairdise:
    output:
        outdir=directory("PAIRADISE"),
    params:
        link="https://github.com/Xinglab/PAIRADISE.git",
        install_dir="./PAIRADISE/pairadise/src/pairadise_model/",
    log:
        "logs/rmats/install_pairadise.log",
    conda:
        "../envs/rmats.yaml"
    shell:
        """
        git clone {params.link} 2> {log}
        Rscript -e "install.packages('{params.install_dir}', repos=NULL)" 2>> {log}
        """
rule rmats_samples:
    input:
        meta="data/startingfiles/samples_group.csv"
    output:
        b1="data/startingfiles/b1.txt",
        b2="data/startingfiles/b2.txt"
    run:
        b1_samples = []
        b2_samples = []

rule rmats_prep:
    input:
        gtf="data/genome/gencode.v38.annotation.gtf",
        b1="data/startingfiles/b1.txt",
        b2="data/startingfiles/b2.txt"
    output:
        prep_dir=directory("results/rmats/prep/tmp"),
        flag=touch("results/rmats/prep/validation/complete.txt")
    log:
        "logs/rmats/prep/group.log"
    conda:
        "../envs/rmats.yaml"
    shell:
        """
        rmats.py \
            --gtf {input.gtf} \
            --tmp {output.prep_dir} \
            --od results/rmats/post \
            --readLength 75 \
            --b1 {input.b1} \
            --b2 {input.b2} \
            -t paired \
            --libType fr-firststrand \
            --nthread 8 \
            --task prep \
            --variable-read-length \
            --allow-clipping \
            --novelSS
            &> {log}
        """


rule rmats_post:
    input:
        flag="results/rmats/prep/validation/complete.txt",
        gtf="data/genome/gencode.v38.annotation.gtf",
        b1="data/startingfiles/b1.txt",
        b2="data/startingfiles/b2.txt"
    output:
        summary="results/rmats/post/A3SS.MATS.JC.txt",
        flag="results/rmats/post/res.txt"
    log:
        "logs/rmats/302131640_rmats_post.log"
    params:
        tmp="results/rmats/prep/tmp"
    conda:
        "../envs/rmats.yaml"
    shell:
        """
        rmats.py \
            --gtf {input.gtf} \
            --tmp {params.tmp} \
            --od results/rmats/post/ \
            --readLength 75 \
            --b1 {input.b1} \
            --b2 {input.b2} \
            -t paired \
            --nthread 8 \
            --task post \
            --variable-read-length \
            --allow-clipping \
            --novelSS
            &> {log} \
        && touch {output.flag}
        """
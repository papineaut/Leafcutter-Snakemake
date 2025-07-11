rule junc:
    input:
       "results/bam_bed/{sample}Aligned.sortedByCoord.out.bed"
    log:
        "logs/junctions/{sample}_bamfile.txt"
    output:
        jnt = "results/junctions/{sample}_off.junc",
        tmp = "results/jun_temp/{sample}_temp.txt"
    container:config["images"]["leafcutter"]
    shell:
        """
        bed2junc.pl \\
            {input} \\
            {output.jnt}
        # Create tmp file with
        # pointer to junction 
        # file used for gather
        # step later
        echo '{output.jnt}' > {output.tmp}
        """
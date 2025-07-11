rule bam_bed:
    input:
       bam="results/star_align/{sample}Aligned.sortedByCoord.out.bam"
    log:
        "logs/bam_bed/{sample}bam_bed.log"
    output:
        "results/bam_bed/{sample}Aligned.sortedByCoord.out.bed"
    container: config["images"]["leafcutter"]
    shell: 
        """
        # Filter alignments and create
        # intermediate bed file
        samtools view {input.bam} \\
            | filter_cs.py \\
            | sam2bed.pl \\
                --use-RNA-strand \\
                /dev/stdin \\
                {output}
        """
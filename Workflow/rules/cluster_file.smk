rule cluster_file:
    input:
        tmps = expand("results/jun_temp/{sample}_temp.txt",sample=SAMPLES)
    log:
        "logs/cluster/clustering.log"
    output:
        "results/cluster/junction_file.txt"
    container: config["images"]["leafcutter"]
    shell: 
        """
        # Create single file with pointing
        # to all junction files
        cat {input.tmps} \\
        > {output} 
        """
rule differencial:
    input:
        grp = "data/startingfiles/women_sans_outl.csv",
        num = "results/cluster/leafcutter_perind_numers.counts.gz",
        exn = "data/genome/gencode.v31.exons.txt.gz"
        
    output:
        per="leafcutter_ds_cluster_significance.txt",
        effect="leafcutter_ds_effect_sizes.txt"
    log:
        "logs/diff"
    container:config["images"]["leafcutter"]
    shell:
        """
        leafcutter/scripts/leafcutter_ds.R --exon_file {input.exn} --num_threads 8 --timeout 1200 {input.num} {input.grp}
        """
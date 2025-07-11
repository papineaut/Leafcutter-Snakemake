rule prep_vis2:
    input:
        num = "results/cluster/leafcutter_perind_numers.counts.gz",
        grp = "data/startingfiles/samples_group.csv",
        res = "leafcutter_ds_cluster_significance.txt",
        eff = "leafcutter_ds_effect_sizes.txt",
        itn = "data/genome/_all_introns.bed.gz"
    output: 
        "annotation/vieux_vs_jeunes_leafviz.Rdata"
    container: config["images"]["leafcutter"]
    log:
        "logs/vis2"

    shell:
        """
        touch "annotation/vieux_vs_jeunes_leafviz.Rdata"

        leafcutter/leafviz/prepare_results.R\\
            --FDR 0.05 \\
            --meta_data_file {input.grp} \\
            --code "vieux_vs_jeunes" \\
            {input.num} \\
            {input.res} \\
            {input.eff} \\
            "data/genome/" \\
            -o {output}
            &>{log}
        """
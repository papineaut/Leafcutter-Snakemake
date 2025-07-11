rule outlier:
    input:
        "results/cluster/leafcutter_perind_numers.counts.gz"

    log:
        "logs/outlier.log"

    output:
        "leafcutter_outlier_pVals.txt"

    container: config["images"]["leafcutter"]

    shell:
        """
        leafcutter/scripts/leafcutterMD.R --num_threads 8 {input}
         
        """
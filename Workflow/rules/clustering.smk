rule clustering:
    input:
        "results/cluster/junction_file.txt"
    output:
        num ="results/cluster/leafcutter_perind_numers.counts.gz"
    container: config["images"]["leafcutter"]
    shell:
        """
        leafcutter/clustering/leafcutter_cluster.py -j {input} -m 30 -o leafcutter -l 100000 -r "results/cluster/"  -p 0.001
        """
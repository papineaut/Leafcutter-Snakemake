rule prep_vis1:
    input: "data/genome/Homo_sapiens.GRCh38.110.gtf"
    log:
        "logs/vis/vis1.log"
    output: 
        introns = "data/genome/_all_introns.bed.gz",
        exons = "data/genome/_all_exons.txt.gz",
        start = "data/genome/_fiveprime.bed.gz",
        end = "data/genome/_threeprime.bed.gz"
    container: config["images"]["leafcutter"]
    shell: 
        """
            #tmp=$(mktemp -d -p "temp_dir")
            #trap 'rm -rf "${{tmp}}"' EXIT
            #export TMPDIR="${{tmp}}"

            leafcutter/leafviz/gtf2leafcutter.pl -o "data/genome/" data/genome/Homo_sapiens.GRCh38.110.gtf 2>{log}
        """
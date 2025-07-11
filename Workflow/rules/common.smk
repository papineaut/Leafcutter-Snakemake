import pandas as pd

df = pd.read_csv("data/startingfiles/samples_path.csv", sep="\t" )
SAMPLES = sorted(df["sample"].unique())
BATCHES = sorted(df["batch"].unique())

READS = ["R1", "R2"]

UN_OU_DEUX = [
    f"{sample}_{read}_val_{'1' if read == 'R1' else '2'}"
    for sample in SAMPLES
    for read in READS
]

def get_fastq_path(sample, batch):
    row = df[(df["sample"] == int(sample)) & (df["batch"] == batch)]
    assert not row.empty, f"No entry for sample={sample}, batch={batch} in SAMPLES.csv"
    return row["workdir"].values[0] + f"/{sample}"

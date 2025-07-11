# Leafcutter-Snakemake
Snakemake pipline to find differentialy express spliced genes using leafcutter

To launch the pipeline you need to:

create a conda environments with the smake.yml and activate it   

-Create samples_path.csv, tab delimited file with sample;workdir;batch columns 
    sample;workdir;batch
-Create a meta data file, with is a with your samples followed by _off, then the group and other cofounder you want to include (sex,rin,etc)
    302155756_off 0 men 9.09

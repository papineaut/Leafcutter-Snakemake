# Leafcutter-Snakemake
Snakemake pipline to find differentialy express spliced genes using leafcutter

To launch the pipeline you need to:

-create a conda environments with the smake.yml and activate it   

-Create samples_path.csv, tab delimited file with sample;workdir;batch columns 
    sample;workdir;batch
    
-Create a meta data file, with is a with your samples followed by _off, then the group and other cofounder you want to include (sex,rin,etc)
    302155756_off 0 men 9.09

-Download a exon files (you can find it here https://www.dropbox.com/s/osmtksukti9gv7o/gencode.v31.exons.txt.gz?dl=0 from davidaknowles repo), a GTf file for your species, an annotation file and a primary assembly and put it in data/genome/.

# Host-Screen
Utilizes Bowtie2 to remove host contaminated read from Fasta/q files

Before Start:

A Bowtie2 index must be created prior to using this program. The index should be created from the genome(s) of what your screening for (i.e. to remove human reads a index from the human genome needs to be created). The index is created from fasta/q files from the host using bowtie2-build:

bowtie2-build [options]* <reference_in> <bt2_base>

    $ bowtie2-build chr1.fa,chr2.fa,chrX.fa,chrY.fa human_index -f
    (human_index is the bt2_base and is used as the INDEX_BASE variable in settings.sh)
    (-f signifies the reference input files are in FASTA format)

Instructions:

1) Edit settings.sh to include correct paths (See below for variable descriptions)

2) Move into the directory containing your FASTA/Q files. Create a file named "list" that contains the BASENAME of your paired end files. An example of this process is demonstrated below:

    $ cd fasta/
    $ ls *.fasta > list
    $ sed -i -e 's/.fasta//g' list
    $ cat list
    
    SRR1647144
    SRR1647145
    SRR1647236
    SRR1647237
    SRR1647238
    SRR1647239
    SRR1647240
    SRR1647260

3) Edit the "naming scheme" in host-screen.sh (found in script directory). The naming scheme declares the extensions to differentiate between forward/reverse/singleton paired end files.

4) Execute submit.sh
    
    $ ./submit.sh

Variable Descriptions:

These are descriptions of the variables found in settings.sh that must be edited before submitting the job.

FASTA_DIR="/path/to/fasta(or fastq)/files"
FORMAT="f" or "q" (f = fasta format, q = fastq format)
INDEX_DIR="/path/to/bt2/index"
INDEX_BASE="basename" of the Bowtie 2 index files as named during bowtie2-build
OUT_DIR="/path/to/store/screened/reads"
THREADS="number cpus" 

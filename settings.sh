#---------- VARIABLE DECLARATIONS ----------
#Current working directory
export CWD=$PWD

#Script directory
export SCRIPT_DIR="$CWD/scripts"

#Fasta/q directory containing files to screen
export FASTA_DIR="$1"

#FASTA or FASTQ format? (f = fasta (default), q = fastq)
export FORMAT="$2"

#Bowtie2 index directory path AND index basename
export INDEX_DIR="$3"

#Bowtie2 index basenames (human_index.1.bt2 = human_index)
export INDEX_BASE="$4"

#Output directory
export OUT_DIR="$5"

#Number of CPU Threads
export THREADS="4"

#Standard Out/Error
export STDERR_DIR="$CWD/std-err"
export STDOUT_DIR="$CWD/std-out"
# ------------------------------------------

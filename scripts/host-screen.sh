#!/bin/bash

#PBS -W group_list=bh_class
#PBS -q windfall
#PBS -l jobtype=cluster_only
#PBS -l select=1:ncpus=6:mem=11gb
#PBS -l pvmem=10gb
#PBS -l walltime=24:00:00
#PBS -l cput=24:00:00
#PBS -M jamesthornton@email.arizona.edu
#PBS -m bea

module load bowtie2/2.2.5
cd $FASTA_DIR

#Paired end naming scheme
R1=$FILE".R1.fastq"
R2=$FILE".R2.fastq"
S=$FILE".singletons.fastq"

bowtie2 -x $INDEX_DIR/$INDEX_BASE -1 $R1 -2 $R2 -U $S -$FORMAT --very-sensitive-local -p $THREADS --un $OUT_DIR/$FILE.singletons.fastq --un-conc $OUT_DIR/$FILE.paired.fastq 

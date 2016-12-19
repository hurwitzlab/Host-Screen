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

bowtie2 -x $INDEX_DIR/$INDEX_BASE -U $FILE -$FORMAT --very-sensitive-local -p $THREADS --un $OUT_DIR/$FILE.screened 

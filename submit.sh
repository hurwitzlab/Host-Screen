#!/bin/bash

./init-host-screen.pl6

source ./settings.sh

if [[ ! -d "$FASTA_DIR" ]]; then
  echo "$FASTA_DIR does not exist. Job terminated."
  exit 1
fi

if [[ ! -d "$INDEX_DIR" ]]; then
  echo "$INDEX_DIR does not exist. Edit INDEX_DIR path and try again. Job terminated."
  exit 1
fi

if [[ ! -f "$FASTA_DIR/list" ]]; then
  echo "Cannot find file list in $FASTA_DIR. This file must be in the FASTA directory and be named 'list'. See README for more information. Job terminated."
  exit 1
fi
  
if [[ ! -d "$OUT_DIR" ]]; then
  echo "$OUT_DIR does not exist. I made it for you and will place the screened reads there."
  mkdir -p "$OUT_DIR"
fi

if [[ ! -d "$STDERR_DIR" ]]; then
  echo "$STDERR_DIR does not exist. Directory created for standard error."
  mkdir -p "$STDERR_DIR"
fi

if [[ ! -d "$STDOUT_DIR" ]]; then
  echo "$STDOUT_DIR does not exist. Directory created for standard out."
  mkdir -p "$STDOUT_DIR"
fi

cd "$FASTA_DIR"
export LIST="$FASTA_DIR/list"
pwd
while read FILE; do
   export FILE="$FILE"

  JOB_ID1=`qsub -v CWD,SCRIPT_DIR,FILE,FASTA_DIR,INDEX_DIR,INDEX_BASE,FORMAT,OUT_DIR,THREADS -N Host_screen -e "$STDERR_DIR" -o "$STDOUT_DIR" $SCRIPT_DIR/host-screen.sh`

done < $LIST

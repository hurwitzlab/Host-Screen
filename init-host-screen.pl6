#!/usr/bin/env perl6

my $FASTQ_DIR;
my $FORMAT;
my $INDEX_DIR;
my $INDEX_BASE;
my $OUT_DIR;

get_FASTQ_DIR();
sub get_FASTQ_DIR {
    $FASTQ_DIR = prompt("What is the full path to your Fasta/q files?: \n");
        if ($FASTQ_DIR.IO.e) {
            put "I've located $FASTQ_DIR , Here are it's contents:";
            for dir($FASTQ_DIR) -> $file {
                say $file.basename;
        }
    }
        else {
            note "Unable to find the path given for location of Fasta/q files ($FASTQ_DIR). Please try again";
            get_FASTQ_DIR();
    }
    get_FORMAT();
}

sub get_FORMAT {
    $FORMAT = prompt("Is your data in Fasta or Fastq format?: \n 1: Fasta \n 2: Fastq \n");
    if ($FORMAT == 1) {
        $FORMAT = "-f";
        get_INDEX_DIR();
    }
    elsif ($FORMAT == 2) {
        $FORMAT = "-q";
        get_INDEX_DIR();
    }
    else {
        put "I don't understand. Please enter 1 (fasta) or 2 (fastq).";
        get_FORMAT();
    }
}

sub get_INDEX_DIR {
    $INDEX_DIR = prompt("Select a preset index to screen against or select custom to use your own index files: \n 1: Human \n 2: Mouse \n 3: Custom \n");
    if ($INDEX_DIR == 1) {
        $INDEX_DIR = $*PROGRAM.dirname/"index/human";
        $INDEX_BASE = "human_index";
        get_OUT_DIR();
    }
    elsif ($INDEX_DIR == 2) {
        $INDEX_DIR = $*PROGRAM.dirname/"index/mouse";
        $INDEX_BASE = "mouse_index";
        get_OUT_DIR();
    }
    elsif ($INDEX_DIR == 3) {
        $INDEX_DIR = prompt("Enter the FULL path to your index files: \n");
        $INDEX_BASE = prompt("What is the basename of your index files? (exampled human_index.1.bt2 = human_index) \n");
        get_OUT_DIR();
    }
    else {
        put "I don't understand. Please enter one of the provided options.";
        get_INDEX_DIR();
    }    
}

sub get_OUT_DIR {
    $OUT_DIR = prompt("What is the FULL path to place the output?:\n");
    if ($OUT_DIR.IO.e) {
        submit_vars();
    }
    else {
        create_OUT_DIR();
    }
}

sub create_OUT_DIR {
    my $out_check = prompt ("Unable to find $OUT_DIR. Should I create it? (Y/N):");
    if ($out_check ~~ "Y") {
        mkdir "$OUT_DIR";
        submit_vars();
     }
     elsif ($out_check ~~ "N") {
        get_OUT_DIR();
     }
     else {
        put "I don't understand. Please enter one of the provided options.";
        create_OUT_DIR();
     }
}

sub submit_vars {
    my $settings="./settings.sh";
    run $settings, $FASTQ_DIR, $FORMAT, $INDEX_DIR, $INDEX_BASE, $OUT_DIR;
}

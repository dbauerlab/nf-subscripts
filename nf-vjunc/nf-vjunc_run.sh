#!/bin/bash
# nf-vjunc_run.sh
# This script runs the nf-vjunc pipeline
# This specific script was first setup to run on Nuno's data from PM23265

# Load modules
ml purge
ml Singularity/3.11.3
ml Nextflow/25.04.4

# Pull the latest nf-vjunc repository
nextflow pull dbauerlab/nf-vjunc

# Run Nextflow pipeline
nextflow run dbauerlab/nf-vjunc \
    -profile crick \
    -r aligner \
    -resume \
    --input /nemo/stp/babs/working/bootj/projects/bauerd/nuno.santos/dvgs_PM23265/data/samplesheets/samplesheet.csv \
    --host_fasta /nemo/stp/babs/working/bootj/genomes/human/hg38_r95/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
    --host_gtf /nemo/stp/babs/working/bootj/genomes/human/hg38_r95/Homo_sapiens.GRCh38.95.gtf

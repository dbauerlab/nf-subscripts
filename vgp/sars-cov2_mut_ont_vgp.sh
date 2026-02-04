#!/bin/sh

# Script for running the viral genomics pipeline for SARS-CoV-2 nanopore data
# Trying to detect mouse-adapted mutations (hi%) and other variants of interest

#SBATCH --partition=ncpu
#SBATCH --job-name=viral-genomics
#SBATCH --mem=16G
#SBATCH -n 1
#SBATCH --time=7-00:00:00
#SBATCH --output=viral-genomics.out
#SBATCH --error=viral-genomics.err

ml purge
ml Nextflow/25.10.0
ml Singularity/3.6.4

export SINGULARITY_CACHEDIR="/nemo/lab/bauerd/home/shared/singularity"
export NXF_SINGULARITY_CACHEDIR="/nemo/lab/bauerd/home/shared/singularity"

nextflow run /nemo/lab/bauerd/home/shared/github/crick-viral-genomics \
    -resume \
    -profile crick,nemo \
    --samplesheet samplesheet.csv \
    --viral_fasta SARS-CoV-2.reference.fasta\
    --primers_bed SARS-CoV-2.primer.bed \
    --run_nanopore_qc_trim \
    --run_minimap_align \
    --run_artic_primer_trim \
    --run_nanopore_varcall \
    --force_ref_to_upper \
    --pool_primer_reads

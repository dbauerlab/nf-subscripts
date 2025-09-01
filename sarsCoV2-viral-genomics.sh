#!/bin/sh

#SBATCH --partition=ncpu
#SBATCH --job-name=viral-genomics
#SBATCH --mem=4G
#SBATCH -n 1
#SBATCH --time=168:00:00
#SBATCH --output=viral-genomics.out
#SBATCH --error=viral-genomics.err

ml purge
ml Nextflow/24.04.2
ml Singularity/3.6.4

export NXF_SINGULARITY_CACHEDIR="/nemo/lab/bauerd/home/users/barretj/Projects/.nextflow/singularity"

nextflow pull crick-pipelines-stp/crick-viral-genomics
nextflow run crick-pipelines-stp/crick-viral-genomics \
    -r main \
    -resume \
    -profile crick,nemo \
    --samplesheet /nemo/lab/bauerd/home/users/barretj/Projects/Viral_Genomics/Samplesheet/samplesheetdelta.csv \
    --viral_fasta /nemo/lab/bauerd/home/users/barretj/Projects/Viral_Genomics/gff/Delta/Delta.fa \
    --viral_gff /nemo/lab/bauerd/home/users/barretj/Projects/Viral_Genomics/gff/Delta/Delta.sgRNA_canonical.gtf \
    --primers_bed /nemo/lab/bauerd/home/users/barretj/Projects/Viral_Genomics/primerbed/SARS-CoV-2.primer.bedpe.bed \
    --run_nanopore_qc_trim \
    --run_minimap_align \
    --run_artic_primer_trim \
    --run_nanopore_varcall \
    --force_ref_to_upper \
    --pool_primer_reads

#!/bin/sh

#SBATCH --partition=ncpu
#SBATCH --job-name=vgp-artic
#SBATCH --mem=4G
#SBATCH -n 1
#SBATCH --time=7-00:00:00
#SBATCH --output=run.o
#SBATCH --error=run.o

ml purge
ml Nextflow/25.10.0
ml Singularity/3.6.4

export NXF_SINGULARITY_CACHEDIR="/nemo/lab/bauerd/home/shared/singularity"

nextflow run /nemo/lab/bauerd/home/shared/github/dev/chandra \
    -resume \
    -profile crick,nemo \
    --samplesheet ./all_artic_samplesheet.csv \
    --viral_fasta /nemo/stp/babs/working/bootj/projects/bauerd/jamie.barrett-rodger/b830/easyseq_covid19/db/artic-ncov2019/primer_schemes/nCoV-2019/V4/SARS-CoV-2.reference.fasta \
    --primers_bed /nemo/stp/babs/working/bootj/projects/bauerd/jamie.barrett-rodger/b830/easyseq_covid19/db/artic-ncov2019/primer_schemes/nCoV-2019/V4/SARS-CoV-2.primer.bed \
    --viral_gff /nemo/stp/babs/working/bootj/projects/bauerd/jamie.barrett-rodger/b830/easyseq_covid19/db/data/NC_045512.2/genes_custom.gff \
    --run_illumina_qc_trim \
    --run_bwa_align \
    --run_artic_primer_trim \
    --run_illumina_varcall \
    --run_panglolin \
    --run_nextclade \
    --nextclade_dataset_name "sars-cov-2" \
    --pool_primer_reads \
    -c myconfig.config
    

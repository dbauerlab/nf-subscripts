#!/bin/bash

# Process Ollie's in cellulo splash
# Based on script by A. M. Chakrabarti
# 09/05/2025

#SBATCH --job-name="ollie_splash"
#SBATCH --time=48:00:00
#SBATCH --mem=512G
#SBATCH --cpus-per-task=8
#SBATCH --output=ollie_splash_r2-%A.out

ml purge
ml Nextflow/23.10.0
ml Singularity/3.6.4
ml Graphviz/2.47.2-GCCcore-10.3.0

REF=/camp/home/bootj/working/bootj/projects/bauerd/ollie.platt/incellulo.splash/ref/human

cd /camp/home/bootj/working/bootj/projects/bauerd/ollie.platt/incellulo.splash

nextflow pull amchakra/tosca -r main
nextflow run amchakra/tosca \
-resume \
-r main \
-profile crick \
--input samplesheet_r2.csv \
--outdir results_r2 \
--genome_fai $REF/GRCh38.primary_assembly.genome.fa.fai \
--star_genome $REF/STAR_GRCh38_GencodeV33 \
--transcript_fa $REF/GRCh38.gencode_v33.fa \
--transcript_fai $REF/GRCh38.gencode_v33.fa.fai \
--transcript_gtf $REF/GRCh38.gencode_v33.tx.gtf.gz \
--regions_gtf $REF/regions.gtf.gz \
--split_size 50000 \
--dedup_method none \
--omit_highincidence 10000 \
--max_memory '512.GB' \
--max_time '24.h' \
--max_cpus 8 \
-queue-size 100 \
--goi goi.csv \
--bin_size 10 \
--skip_arcs \
--skip_qc

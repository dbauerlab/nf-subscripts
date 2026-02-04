# nf-subscripts

A repository for submission scripts of Nextflow pipelines commonly run by the lab. This collection provides ready-to-use SLURM submission scripts configured for the Crick HPC environment.

## Overview

This repository contains SLURM job submission scripts for various Nextflow pipelines used by the lab. Each pipeline has its own subfolder with one or more submission scripts tailored for different input types or analysis configurations.

## General Instructions: Submitting Scripts to SLURM

### Prerequisites
- Access to the HPC cluster with Nextflow installed
- The Nextflow pipeline repository cloned or available
- Required input files (samplesheets, reference genomes, etc.)

### How to Submit

1. **Navigate to your project directory:**
   ```bash
   cd /path/to/your/project
   ```

2. **Copy or download the appropriate submission script:**
   ```bash
   cp /nemo/lab/bauerd/home/shared/github/nf-subscripts/<pipeline>/<script>.sh ./
   ```

3. **Customize the script if needed:**
   - Edit the SBATCH directives (job name, memory, time, etc.) to match your needs
   - Update paths to input files, reference genomes, and output directories
   - Modify pipeline parameters as required

4. **Submit the job to SLURM:**
   ```bash
   sbatch <script>.sh
   ```

5. **Monitor job status:**
   ```bash
   squeue -u $USER                    # View all your jobs
   squeue -j <job-id>                 # View a specific job
   tail -f <output-log-file>          # Monitor job output in real-time
   ```

### Notes
- SBATCH directives at the top of each script configure resource allocation (memory, CPU, time, partition, etc.)
- The `-resume` flag in Nextflow allows jobs to be restarted from where they left off
- Output and error files are specified in the SBATCH directives and will be created in the directory where you submit the job

---

## Pipeline Scripts

### tosca/
**TOSCA Pipeline - Ollie's In Cellulo Splash Analysis**

- **`tosca.sh`**: Processes in cellulo splash sequencing data using the TOSCA pipeline. Analyzes RNA-seq data with STAR alignment, generates transcript abundance estimates, and produces spatial analysis outputs. Configured for the Crick cluster with 512GB memory and 8 CPUs.

### vgp/ (Viral Genomics Pipeline)
**SARS-CoV-2 Viral Genomics Pipeline**

- **`sars-cov2_artic_illumina_vgp.sh`**: Processes SARS-CoV-2 Illumina sequencing data from ARTIC protocol. Includes QC/trimming, BWA alignment, ARTIC primer trimming, variant calling, multiple sequence alignment (MSA), and taxonomic assignment (Pangolin/Nextclade). Optimized for Illumina short-read data.

- **`sars-cov2_mut_ont_vgp.sh`**: Processes SARS-CoV-2 nanopore (Oxford Nanopore Technologies) sequencing data with focus on detecting mouse-adapted mutations and other variants of interest. Includes QC/trimming, Minimap2 alignment, ARTIC primer trimming, and nanopore-specific variant calling. Configured with 16GB memory for long-read data processing.

### nf-vjunc/
Currently empty. This folder is reserved for future V-junction analysis pipeline scripts.

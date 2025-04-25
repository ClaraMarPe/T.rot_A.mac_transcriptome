# Metatranscriptome processing pipeline for _T. rotula_ and _A. macleodii_ co-culture experiments
This repository contains a set of scripts used to process RNA-seq reads from co-culture experiments between _Thalassiosira rotula_ CCMP3096 and _Alteromonas macleodii_ ATCC 27126. The pipeline spans from raw reads to rRNA removal, mapping to reference genomes (or de novo assembled transcriptomes), and preparation for downstream analyses.<br>
This repository accompanies the manuscript:<br>
"_Alteromonas macleodii_ induces protoplast withdrawal from the silica cell wall and necrotic cell death to feed on the oceanic _Thalassiosira rotula diatom_"<br>
**Authors:** Isobel Short, Clara Martínez-Pérez, Roman Stocker, Uria Alcolombri


## _Please note:_ 
This repository is provided for transparency and reproducibility of the working pipeline used in our study. It is not intended as a polished or fully generalized pipeline (some adaptation may be required depending on your dataset and computing environment). 

## Overview:
The scripts in this repository are numbered in the intended order of use. All steps were executed on the Euler HPC cluster at ETH Zurich, using the SLURM workload manager.
The steps include the following:
01. Trimmig and error correction of raw reads 
02. Sequential mapping to ribosomal RNA databases for rRNA removal 
03. Read alignment to the A.macleodii reference genome, and generation of a transcript count table 
04. Pre-processing of reads for de-novo assembly: normalization of reads that did not map map to A. macleodii 
05. Assembly of non-A.macleodii reads (with metaSPAdes)
06. Open Reading Frame (ORF) prediction (using Transdecoder), followed by assembly evaluation
07. ORF annotation, using available reference datasets 
08. Read alignment to the assembled T.rotula transcriptome, and generation of a transcript count table

Differential Expression Analysis (performed in R) is available in a separate repository

## Data availability:
Raw reads and de novo transcriptome assembly are deposited and available in the European Nucleotide Archive (ENA), project accession: PRJEB72406
Reference genome of _A. macleodii_ ATCC 27126 is available under the GenBank accession number CP003841.1.

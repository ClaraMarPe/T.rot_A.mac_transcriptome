#!/bin/bash
#
#SBATCH --job-name=Transdecoder
#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ctinez.p@gmail.com
#SBATCH --output=/scratch/oceanography/martinez/metaT_A.mac/out_err_files/Transdecoder.out
#SBATCH --error=/scratch/oceanography/martinez/metaT_A.mac/out_err_files/Transdecoder.err
#SBATCH --nice=1000
#SBATCH --partition=basic


#ORF annotations from denovo rnaseq assembly
#useful link: https://academic.oup.com/bib/article/23/2/bbab563/6514404#338429054

module load hmmer

#[1] define variables
#[1.1] project variable
PROJECT="Trotula_metaT"
#[1.2] folder variables
DATA_FOLDER=/scratch/oceanography/martinez/metaT_A.mac
#[1.3] outup folder
mkdir $DATA_FOLDER/02_assembly/${PROJECT}.annotations/

#[2] copy data to tmpdir
cd $TMPDIR
scp $DATA_FOLDER/02_assembly/${PROJECT}.transdecoder_dir/transcripts.fasta.transdecoder.pep ./
scp /scratch/martinez/databases/UniProt/uniprot_complete.dmnd ./

# [3] Homology search with diamond blastp
eval "$(conda shell.bash hook)" 
conda activate diamond-2.0.13
module load diamond 

#blast against uniprot (Dec2021)
diamond blastp --query transcripts.fasta.transdecoder.pep \
    --db uniprot_complete.dmnd \
    --outfmt 6 qseqid sseqid salltitles pident length mismatch evalue bitscore \
    --max-target-seqs 1 \
    --iterate \
    --very-sensitive \
    --evalue 1e-25 \
    --threads 12 \
    --out diamondblastp2transdecoder.pep.Uniprot.outfmt6
scp  diamondblastp2transdecoder.pep.Uniprot.outfmt6 $DATA_FOLDER/02_assembly/${PROJECT}.annotations

#blast against nr
diamond blastp --query transcripts.fasta.transdecoder.pep \
    --db /localmirror/monthly/diamond/nr.dmnd \
    --outfmt 6 qseqid sseqid salltitles pident length mismatch evalue bitscore \
    --max-target-seqs 1 \
    --iterate \
    --very-sensitive \
    --evalue 1e-25 \
    --threads 12 \
    --out diamondblastp2transdecoder.pep.nr.outfmt6
scp diamondblastp2transdecoder.pep.nr.outfmt6 $DATA_FOLDER/02_assembly/${PROJECT}.annotations
conda deactivate

# [4] Domain search with Interpro
/localmirror/monthly/interpro/interproscan-5.53-87.0/interproscan.sh \
    -i transcripts.fasta.transdecoder.pep \
    -f tsv \
    -o InterProScan2transdecoder.pep \
    -appl Pfam,Phobius,TIGRFAM,Hamap,ProSitePatterns,ProSiteProfiles
scp InterProScan2transdecoder.pep $DATA_FOLDER/02_assembly/${PROJECT}.annotations




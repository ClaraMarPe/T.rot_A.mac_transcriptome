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


#ORF prediction from denovo rnaseq assembly
#from pipeline: https://www.nature.com/articles/s41598-019-46276-8#Sec17

module load transdecoder
module load hmmer

#[1] define variables
#[1.1] project variable
PROJECT="Trotula_metaT"
#[1.2] folder variables
DATA_FOLDER=/scratch/oceanography/martinez/metaT_A.mac

#[2] copy data to tmpdir
cd $TMPDIR
scp $DATA_FOLDER/02_assembly/rnaSpades/Euk_SPAdes/transcripts.fasta ./

#[3] run transdecoder
TransDecoder.LongOrfs -t transcripts.fasta --output_dir ${PROJECT}.transdecoder_dir
#copy files
scp -r ${PROJECT}.transdecoder_dir $DATA_FOLDER/02_assembly/

# identify ORFs with hits to Pfam database
hmmsearch --cpu 12 \
--domtblout ${PROJECT}.transdecoder_dir/pfam.domtblout \
/localmirror/monthly/interpro/interproscan-5.53-87.0/data/pfam/34.0/pfam_a.hmm \
${PROJECT}.transdecoder_dir/longest_orfs.pep
scp -r ${PROJECT}.transdecoder_dir $DATA_FOLDER/02_assembly/

# identify ORFs with blast hits to diamond database
eval "$(conda shell.bash hook)" 
conda activate diamond-2.0.13
module load diamond 

diamond blastp --query ${PROJECT}.transdecoder_dir/longest_orfs.pep \
    --db /localmirror/monthly/diamond/nr.dmnd \
    --outfmt 6 \
    --sensitive \
    --evalue 1e-25 \
    --threads 12 \
    --out ${PROJECT}.transdecoder_dir/diamondblastp.outfmt6
scp -r ${PROJECT}.transdecoder_dir $DATA_FOLDER/02_assembly/
conda deactivate

#retain ORFs with hits, together with those 
#important to specify the output directory from the TransDecoder.LongOrfs step (default: basename( -t val ) + ".transdecoder_dir")

TransDecoder.Predict \
-t transcripts.fasta \
--retain_pfam_hits ${PROJECT}.transdecoder_dir/pfam.domtblout \
--retain_blastp_hits ${PROJECT}.transdecoder_dir/diamondblastp.outfmt6 \
--out ${PROJECT}.transdecoder_dir/

scp -r ${PROJECT}.transdecoder_dir $DATA_FOLDER/02_assembly/

rm -r ${PROJECT}.transdecoder_dir
rm $TMPDIR/*


#!/bin/bash
#!/bin/bash
#BSUB -J "rnaSPADES"                                
#BSUB -n 16                              
#BSUB -R "rusage[mem=250000]"            
#BSUB -R "rusage[scratch=20000]"        
#BSUB -W 24:00                                     
#BSUB -o ~/out_err/rnaSpades.out
#BSUB -e ~/out_err/rnaSpades.err
#BSUB -notify done

#to run:
#bsub < ~/scripts/05_rnaspades_Euk.sh 

#de novo assembly of reads using Spades
module load spades

#[1] define variables
#[1.1] project variable
PROJECT="Dual_metaT"
#[1.2] folder variables
DATA_FOLDER= ~/data

#[2] Copy data to temp dir
cd $TMPDIR
scp $DATA_FOLDER/04_Normalized_reads/* ./

#[3] Run spades (NOTE:Reads are interleaved(!), using one big library (concatenated reads). 
#note:you cannot specify multiple k-mer sizes in RNA-Seq mode
spades.py \
--rna \
-m 250 \
--only-assembler \
-t 16 \
--pe1-12 all_norm_unmapped70_A.mac.fastq.gz \
-o Euk_SPAdes

#Copy results back to scratch
mkdir $DATA_FOLDER/05_rnaSPAdes
scp -r Euk_SPAdes $DATA_FOLDER/05_rnaSPAdes
rm -r *



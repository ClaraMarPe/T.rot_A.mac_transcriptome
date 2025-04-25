#!/bin/bash
#BSUB -J "BBmap_to_Amac_70pct[1-79]%10"                                  
#BSUB -n 8                              
#BSUB -R "rusage[mem=24000]"            
#BSUB -R "rusage[scratch=20000]"         
#BSUB -W 24:00                                    
#BSUB -o ~/out_err/BBmap_to_Amac_70pct/BBmap_to_Amac_70pct_%J.out
#BSUB -e ~/out_err/BBmap_to_Amac_70pct/BBmap_to_Amac_70pct_%J.err

#to run this script:
#bsub < ~/scripts/03_A.mac_mapping_array.sh 

module load gcc/8.2.0 bbmap/37.36 openjdk/17.0.0_35 

#[1] define variables
#[1.1] project variable
PROJECT="Dual_metaT"
#[1.2] folder variables
DATA_FOLDER= ~/data

#[1.3]Select the sample name from Sample_list.txt, where the array task id is used as line number. Note, Sample_list.txt is created in the script 01_Trimming_and_Error_correction.sh
SAMPLE=$(sed -n ${LSB_JOBINDEX}p $DATA_FOLDER/Sample_list.txt)

#[2]copy files into $TMPDIR for faster processing
cd $TMPDIR
#[2.1] the corrected mRNA reads
scp $DATA_FOLDER/02.2_mRNA_reads/${SAMPLE}*fastq.gz ./

#[2.2] the A.mac genome
scp -r $DATA_FOLDER/Alteromonas_macleodii_ATCC_27126_complete_genome.fasta ./

#[3] #map with low stringency to sort out the reads (default is ~70%)
bbmap.sh \
    unpigz=T \
    threads=8 \
    ref=Alteromonas_macleodii_ATCC_27126_complete_genome.fasta \
    in=${SAMPLE}_no_rRNA_read1.fastq.gz \
    in2=${SAMPLE}_no_rRNA_read2.fastq.gz \
    killbadpairs=true \
    pairedonly=true \
    outu=${SAMPLE}_unmapped70_A.mac.fastq.gz \
    outm=${SAMPLE}_mapped70_A.mac.fastq.gz \
    -Xmx24G

#[5]copy the results back to the project folder
mkdir $DATA_FOLDER/03.1_mRNA_reads_unmapped_to_A.mac
scp ${SAMPLE}_unmapped* $DATA_FOLDER/03.1_mRNA_reads_unmapped/

mkdir $DATA_FOLDER/03.2_mRNA_reads_mapped_to_A.mac
scp ${SAMPLE}_mapped* $DATA_FOLDER/03.2_mRNA_reads_mapped_to_A.mac
#[6] clear tmpdir
rm ${SAMPLE}*.fastq.gz


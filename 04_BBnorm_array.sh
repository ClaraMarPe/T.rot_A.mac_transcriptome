#!/bin/bash
#!/bin/bash
#BSUB -J "BBnorm[1-79]%10"                              
#BSUB -n 8                              
#BSUB -R "rusage[mem=24000]"            
#BSUB -R "rusage[scratch=20000]"          
#BSUB -W 24:00                                      
#BSUB -o ~/BBnorm/BBnorm_%J.out
#BSUB -e ~/BBnorm/BBnorm_%J.err
#BSUB -notify done

#to run:
#bsub < ~/scripts/04_BBnorm_array.sh 

#Read normalization prior de novo assembly of reads 
module load gcc/8.2.0 bbmap/37.36 openjdk/17.0.0_35 samtools

#[1] define variables
#[1.1] project variable
PROJECT="Dual_metaT"
#[1.2] folder variables
DATA_FOLDER= ~/data

#[1.3]Select the sample name from Sample_list.txt, where the array task id is used as line number. Note, Sample_list.txt is created in the script 01_Trimming_and_Error_correction.sh
SAMPLE=$(sed -n ${LSB_JOBINDEX}p $HOME_FOLDER/Sample_list.txt)

#[2] Copy data to temp dir
cd $TMPDIR
scp $DATA_FOLDER/01_mappings/unmapped70_to_A.mac_ATCC_27126/${SAMPLE}*.fastq.gz ./

#[3] Run bbnorm. (NOTE:Reads are interleaved(!)
bbnorm.sh \
    unpigz=T \
    threads=8 \
    interleaved=true \
    in=${SAMPLE}_unmapped70_A.mac.fastq.gz \
    k=30 \
    target=80 \
    prefilter=t \
    out=${SAMPLE}_norm_unmapped70_A.mac.fastq.gz \
    -Xmx24G

#Copy results back to scratch
mkdir $DATA_FOLDER/04_Normalized_reads
scp ${SAMPLE}_norm_unmapped70_A.mac.fastq.gz $DATA_FOLDER/04_Normalized_reads

rm -r *



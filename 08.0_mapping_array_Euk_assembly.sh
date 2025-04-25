#!/bin/bash
#BSUB -J "BBmap_Euk_assembly                          
#BSUB -n 8                              #Requesting 4 cores per job array sub-job
#BSUB -R "rusage[mem=24000]"            #memory per core, per job in MB. 
#BSUB -R "rusage[scratch=20000]"        #scratch space needed per job, in MB per processor core    
#BSUB -W 24:00                          #Requesting 20 hours running time                
#BSUB -o /cluster/scratch/clperez/output_files/BBmap_to_Euk.assembly_97pct.out
#BSUB -e /cluster/scratch/clperez/output_files/BBmap_to_Euk.assembly_97pct.err
#BSUB -notify done

#to run:
#bsub < /cluster/home/clperez/scripts/07_mapping_array_Euk_assembly.sh 

module load gcc/8.2.0 bbmap/37.36 openjdk/17.0.0_35 samtools

#[1] define variables
#[1.1] project variable
PROJECT="Trotula_metaT"
#[1.2] folder variables
DATA_FOLDER=/cluster/scratch/clperez
HOME_FOLDER=/cluster/home/clperez

#[1.3]pick the sample name from the list where the array task id is used as line number
SAMPLE=$(sed -n ${LSB_JOBINDEX}p $HOME_FOLDER/Sample_list.txt)

#[2]copy files into $TMPDIR for faster processing
cd $TMPDIR
#[2.1] the corrected mRNA reads
scp $DATA_FOLDER/01_mappings/unmapped70_to_A.mac_ATCC_27126/${SAMPLE}_unmapped70_A.mac.fastq.gz ./
#[2.2] the Euk assembly
scp -r  $DATA_FOLDER/02_assembly/Euk_SPAdes/transcripts.fasta ./

#[3] #map stringent
bbmap.sh \
    unpigz=T \
    threads=8 \
    ref=transcripts.fasta \
    in=${SAMPLE}_unmapped70_A.mac.fastq.gz \
    outm=${SAMPLE}_mapped97_to_Euk.sam \
    bamscript=${SAMPLE}_mapped97_to_Euk.sh \
    minidentity=97 \
    idfilter=97 \
    -Xmx24G
bash ${SAMPLE}_mapped97_to_Euk.sh

#[5]copy the results back to the project folder
mkdir $DATA_FOLDER/03_mappings_to_${PROJECT}/
scp ${SAMPLE}_mapped* $DATA_FOLDER/03_mappings_to_${PROJECT}/
scp *sorted.bam $DATA_FOLDER/03_mappings_to_${PROJECT}/

#[6] clear tmpdir
rm ${SAMPLE}*

#* when bash not done, then
#for i in $(cat $HOME_FOLDER/Sample_list.txt);
#do bash "$i"_mapped97_A.mac_bamscript.sh;


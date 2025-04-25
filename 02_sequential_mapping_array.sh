#!/bin/bash
#BSUB -J "rRNA_Mapping[1-71]%10"                                 
#BSUB -n 4                              
#BSUB -R "rusage[mem=6000]"           
#BSUB -R "rusage[scratch=20000]"        
#BSUB -W 24:00                                 
#BSUB -o ~/output_files/rRNA_Mapping_%J.out
#BSUB -e ~/output_files/rRNA_Mapping_%J.err
#BSUB -notify done

module load gcc/8.2.0 bbmap/37.36 openjdk/17.0.0_35 

#[1] define variables
#[1.1] project variable
PROJECT="Dual_metaT"
#[1.2] folder variables
DATA_FOLDER= ~/data
RNA_FOLDER= ~/home

#[1.3] Select the sample name from Sample_list.txt, where the array task id is used as line number. Note, Sample_list.txt is created in the script 01_Trimming_and_Error_correction.sh
SAMPLE=$(sed -n ${LSB_JOBINDEX}p $DATA_FOLDER/Sample_list.txt)

#[2]copy files into $TMPDIR for faster processing
cd $TMPDIR
#[2.1] the corrected reads
scp $DATA_FOLDER/01_corr_reads/spades_corrected/${SAMPLE}*fastq.gz
#[2.2] the rRNA databases
scp -r $rRNA_FOLDER/rRNA_databases/ ./

#[3] Sequential mapping out of the rRNA-resembling reads
    bbmap.sh \
        nodisk=T \
        threads=32 \
        ref=rRNA_databases/SILVA_138.1_SSURef_NR99_tax_silva_trunc.fasta.gz \
        in=${SAMPLE}_corr.read1.fastq.gz \
        in2=${SAMPLE}_corr.read2.fastq.gz \
        outu=${SAMPLE}_no_SSU_read1.fastq \
        outu2=${SAMPLE}_no_SSU_read2.fastq \
        out=${SAMPLE}_SSU_read1.fastq \
        out2=${SAMPLE}_SSU_read2.fastq \
        -Xmx24G
    
    bbmap.sh \
        nodisk=T \
        threads=32 \
        ref=rRNA_databases/SILVA_138.1_LSURef_NR99_tax_silva_trunc.fasta.gz \
        in=${SAMPLE}_no_SSU_read1.fastq \
        in2=${SAMPLE}_no_SSU_read2.fastq \
        outu=${SAMPLE}_no_LSU_read1.fastq \
        outu2=${SAMPLE}_no_LSU_read2.fastq \
        out=${SAMPLE}_LSU_read1.fastq \
        out2=${SAMPLE}_LSU_read2.fastq \
        -Xmx24G

    bbmap.sh \
        nodisk=T \
        threads=32 \
        ref=rRNA_databases/5S_rRNA_db.fasta \
        in=${SAMPLE}_no_LSU_read1.fastq \
        in2=${SAMPLE}_no_LSU_read2.fastq \
        outu=${SAMPLE}_no_rRNA_read1.fastq.gz \
        outu2=${SAMPLE}_no_rRNA_read2.fastq.gz \
        out=${SAMPLE}_5S_read1.fastq \
        out2=${SAMPLE}_5S_read2.fastq \
        -Xmx24G

#[4]copy the results back to the project folder
mkdir $DATA_FOLDER/02.1_rRNA_reads
mkdir $DATA_FOLDER/02.2_mRNA_reads

scp ${SAMPLE}_SSU* $DATA_FOLDER/02.1_rRNA_reads
scp ${SAMPLE}_LSU* $DATA_FOLDER/02.1_rRNA_reads
scp ${SAMPLE}_5S* $DATA_FOLDER/02.1_rRNA_reads
scp ${SAMPLE}_no_rRNA* $DATA_FOLDER/02.2_mRNA_reads

#[5] clear tmpdir
rm ${SAMPLE}_no_SSU* 
rm ${SAMPLE}_no_LSU*
rm ${SAMPLE}*.fastq.gz


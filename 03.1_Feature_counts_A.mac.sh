#!/bin/bash
#BSUB -J "Feature_Counts"                                
#BSUB -n 12                              #Requesting 12 cores per job array sub-job
#BSUB -R "rusage[mem=24000]"            #memory per core, per job in MB. 
#BSUB -R "rusage[scratch=20000]"        #scratch space needed per job, in MB per processor core    
#BSUB -W 24:00                          #Requesting 20 hours running time                
#BSUB -o /cluster/scratch/clperez/output_files/Feature_Counts_Amac_97pct.out
#BSUB -e /cluster/scratch/clperez/output_files/Feature_Counts_Amac_97pct.err
#BSUB -notify done

#to run:
#bsub < /cluster/home/clperez/scripts/03_FeatureCounts_A.mac.sh 

module load subread

#[1] define variables
#[1.1] project variable
PROJECT="Amac_metaT"
#[1.2] folder variables
DATA_FOLDER=/cluster/scratch/clperez/
HOME_FOLDER=/cluster/home/clperez/

cd $DATA_FOLDER/01_mappings/bbmap97_to_A.mac_ATCC_27126/
featureCounts \
-g ID \
- isPairedEnd=TRUE \
-a $HOME_FOLDER/Feature_table_A.mac_CP003841.1modified.gff3 \
-o $DATA_FOLDER/01_mappings/bbmap97_to_A.mac_ATCC_27126/counts_A.mac97.txt \
01-1_0h_mapped97_A.mac_sorted.bam \
02-1_5h_mapped97_A.mac_sorted.bam \
05-1_26h_mapped97_A.mac_sorted.bam \
08-8_5h_mapped97_A.mac_sorted.bam \
09-8_10h_mapped97_A.mac_sorted.bam \
10-8_24h_mapped97_A.mac_sorted.bam \
11-8_26h_mapped97_A.mac_sorted.bam \
12-8_30h_mapped97_A.mac_sorted.bam \
13-8_48h_mapped97_A.mac_sorted.bam \
14-3_0h_mapped97_A.mac_sorted.bam \
15-3_5h_mapped97_A.mac_sorted.bam \
16-3_10h_mapped97_A.mac_sorted.bam \
17-3_24h_mapped97_A.mac_sorted.bam \
18-3_26h_mapped97_A.mac_sorted.bam \
20-3_48h_mapped97_A.mac_sorted.bam \
21-3_72h_mapped97_A.mac_sorted.bam \
22-9_0h_mapped97_A.mac_sorted.bam \
23-9_5h_mapped97_A.mac_sorted.bam \
24-9_10h_mapped97_A.mac_sorted.bam \
25-9_24h_mapped97_A.mac_sorted.bam \
26-9_26h_mapped97_A.mac_sorted.bam \
27-9_30h_mapped97_A.mac_sorted.bam \
28-9_48h_mapped97_A.mac_sorted.bam \
29-9_72h_mapped97_A.mac_sorted.bam \
30-4_0h_mapped97_A.mac_sorted.bam \
31-4_5h_mapped97_A.mac_sorted.bam \
32-4_10h_mapped97_A.mac_sorted.bam \
33-4_24h_mapped97_A.mac_sorted.bam \
34-4_26h_mapped97_A.mac_sorted.bam \
35-4_30h_mapped97_A.mac_sorted.bam \
36-4_48h_mapped97_A.mac_sorted.bam \
37-4_72h_mapped97_A.mac_sorted.bam \
38-10_0h_mapped97_A.mac_sorted.bam \
39-10_5h_mapped97_A.mac_sorted.bam \
40-10_10h_mapped97_A.mac_sorted.bam \
41-10_24h_mapped97_A.mac_sorted.bam \
42-10_26h_mapped97_A.mac_sorted.bam \
43-10_30h_mapped97_A.mac_sorted.bam \
44-10_48h_mapped97_A.mac_sorted.bam \
45-10_72h_mapped97_A.mac_sorted.bam \
46-6_0h_mapped97_A.mac_sorted.bam \
47-6_5h_mapped97_A.mac_sorted.bam \
48-6_10h_mapped97_A.mac_sorted.bam \
49-6_24h_mapped97_A.mac_sorted.bam \
50-6_26h_mapped97_A.mac_sorted.bam \
51-6_30h_mapped97_A.mac_sorted.bam \
52-6_48h_mapped97_A.mac_sorted.bam \
53-6_72h_mapped97_A.mac_sorted.bam \
54-11_0h_mapped97_A.mac_sorted.bam \
56-11_10h_mapped97_A.mac_sorted.bam \
57-11_24h_mapped97_A.mac_sorted.bam \
58-11_26h_mapped97_A.mac_sorted.bam \
59-11_30h_mapped97_A.mac_sorted.bam \
60-11_48h_mapped97_A.mac_sorted.bam \
61-11_72h_mapped97_A.mac_sorted.bam \
62-5_0h_mapped97_A.mac_sorted.bam \
63-5_5h_mapped97_A.mac_sorted.bam \
64-5_10h_mapped97_A.mac_sorted.bam \
65-5_24h_mapped97_A.mac_sorted.bam \
66-5_26h_mapped97_A.mac_sorted.bam \
67-5_30h_mapped97_A.mac_sorted.bam \
68-5_48h_mapped97_A.mac_sorted.bam \
69-5_72h_mapped97_A.mac_sorted.bam \
70-12_0h_mapped97_A.mac_sorted.bam \
71-12_5h_mapped97_A.mac_sorted.bam \
72-12_10h_mapped97_A.mac_sorted.bam \
73-12_24h_mapped97_A.mac_sorted.bam \
74-12_26h_mapped97_A.mac_sorted.bam \
75-12_30h_mapped97_A.mac_sorted.bam \
76-12_48h_mapped97_A.mac_sorted.bam \
77-12_72h_mapped97_A.mac_sorted.bam \
78-1_72h_mapped97_A.mac_sorted.bam \
79-8_0h_mapped97_A.mac_sorted.bam \
-T 12


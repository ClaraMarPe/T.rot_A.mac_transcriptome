#!/bin/bash

#[1] define variables
#[1.1] project variable
PROJECT="Amac_metaT"
#[1.2] folder variables
DATA_FOLDER=/media/clara/Elements
HOME_FOLDER=/home/clara/Documents/Collaborations/MSc_Isobel/Diff_expression
PROG_FOLDER=/home/clara/Downloads/subread-2.0.3-source/bin
cd $DATA_FOLDER/03_mappings_to_Trotula_metaT
$PROG_FOLDER/featureCounts \
-g ID \
-p \
-F GFF \
-a $HOME_FOLDER/T.rot/transcripts.fasta.transdecoder.gff3 \
-o $HOME_FOLDER/T.rot/featCounts.Trotula97.transcripts.fasta.transdecoder.gff3.txt \
-t CDS \
01-1_0h_mapped97_to_Euk_sorted.bam \
02-1_5h_mapped97_to_Euk_sorted.bam \
05-1_26h_mapped97_to_Euk_sorted.bam \
08-8_5h_mapped97_to_Euk_sorted.bam \
09-8_10h_mapped97_to_Euk_sorted.bam \
10-8_24h_mapped97_to_Euk_sorted.bam \
11-8_26h_mapped97_to_Euk_sorted.bam \
12-8_30h_mapped97_to_Euk_sorted.bam \
13-8_48h_mapped97_to_Euk_sorted.bam \
14-3_0h_mapped97_to_Euk_sorted.bam \
15-3_5h_mapped97_to_Euk_sorted.bam \
16-3_10h_mapped97_to_Euk_sorted.bam \
17-3_24h_mapped97_to_Euk_sorted.bam \
18-3_26h_mapped97_to_Euk_sorted.bam \
20-3_48h_mapped97_to_Euk_sorted.bam \
21-3_72h_mapped97_to_Euk_sorted.bam \
22-9_0h_mapped97_to_Euk_sorted.bam \
23-9_5h_mapped97_to_Euk_sorted.bam \
24-9_10h_mapped97_to_Euk_sorted.bam \
25-9_24h_mapped97_to_Euk_sorted.bam \
26-9_26h_mapped97_to_Euk_sorted.bam \
27-9_30h_mapped97_to_Euk_sorted.bam \
28-9_48h_mapped97_to_Euk_sorted.bam \
29-9_72h_mapped97_to_Euk_sorted.bam \
30-4_0h_mapped97_to_Euk_sorted.bam \
31-4_5h_mapped97_to_Euk_sorted.bam \
32-4_10h_mapped97_to_Euk_sorted.bam \
33-4_24h_mapped97_to_Euk_sorted.bam \
34-4_26h_mapped97_to_Euk_sorted.bam \
35-4_30h_mapped97_to_Euk_sorted.bam \
36-4_48h_mapped97_to_Euk_sorted.bam \
37-4_72h_mapped97_to_Euk_sorted.bam \
38-10_0h_mapped97_to_Euk_sorted.bam \
39-10_5h_mapped97_to_Euk_sorted.bam \
40-10_10h_mapped97_to_Euk_sorted.bam \
41-10_24h_mapped97_to_Euk_sorted.bam \
42-10_26h_mapped97_to_Euk_sorted.bam \
43-10_30h_mapped97_to_Euk_sorted.bam \
44-10_48h_mapped97_to_Euk_sorted.bam \
45-10_72h_mapped97_to_Euk_sorted.bam \
46-6_0h_mapped97_to_Euk_sorted.bam \
47-6_5h_mapped97_to_Euk_sorted.bam \
48-6_10h_mapped97_to_Euk_sorted.bam \
49-6_24h_mapped97_to_Euk_sorted.bam \
50-6_26h_mapped97_to_Euk_sorted.bam \
51-6_30h_mapped97_to_Euk_sorted.bam \
52-6_48h_mapped97_to_Euk_sorted.bam \
53-6_72h_mapped97_to_Euk_sorted.bam \
54-11_0h_mapped97_to_Euk_sorted.bam \
56-11_10h_mapped97_to_Euk_sorted.bam \
57-11_24h_mapped97_to_Euk_sorted.bam \
58-11_26h_mapped97_to_Euk_sorted.bam \
59-11_30h_mapped97_to_Euk_sorted.bam \
60-11_48h_mapped97_to_Euk_sorted.bam \
61-11_72h_mapped97_to_Euk_sorted.bam \
62-5_0h_mapped97_to_Euk_sorted.bam \
63-5_5h_mapped97_to_Euk_sorted.bam \
64-5_10h_mapped97_to_Euk_sorted.bam \
65-5_24h_mapped97_to_Euk_sorted.bam \
66-5_26h_mapped97_to_Euk_sorted.bam \
67-5_30h_mapped97_to_Euk_sorted.bam \
68-5_48h_mapped97_to_Euk_sorted.bam \
69-5_72h_mapped97_to_Euk_sorted.bam \
70-12_0h_mapped97_to_Euk_sorted.bam \
71-12_5h_mapped97_to_Euk_sorted.bam \
72-12_10h_mapped97_to_Euk_sorted.bam \
73-12_24h_mapped97_to_Euk_sorted.bam \
74-12_26h_mapped97_to_Euk_sorted.bam \
75-12_30h_mapped97_to_Euk_sorted.bam \
76-12_48h_mapped97_to_Euk_sorted.bam \
77-12_72h_mapped97_to_Euk_sorted.bam \
78-1_72h_mapped97_to_Euk_sorted.bam \
79-8_0h_mapped97_to_Euk_sorted.bam \
-T 12


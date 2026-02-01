#!/bin/bash

# fq_files="Tub_Mos1_A
# Tub_Mos1_B
# Tub_Mos1_C
# Tub_w1118_A
# Tub_w1118_B
# Tub_w1118_C
# w1118_Mos1_A
# w1118_Mos1_B"

fq_files="Tub_w1118_C
w1118_Mos1_C"

while read -r sample; do
    echo "$sample"
    STAR --runThreadN 16 --genomeDir . \
    --readFilesIn "$sample"_1_trim.fastq.gz "$sample"_2_trim.fastq.gz \
    --outFilterMultimapNmax 100 --winAnchorMultimapNmax 100 \
    --outFileNamePrefix "$sample" --outSAMtype BAM SortedByCoordinate --readFilesCommand gunzip -c

    singularity exec tetranscripts.sif TEcount -b "$sample"Aligned.sortedByCoord.out.bam \
    --GTF dmel-all-r6.49.gtf --TE dmel-r6.49_RM_fixed6.gtf \
    --stranded reverse --sortByPos --mode multi --project "$sample"
done <<< "$fq_files"

# STAR --runThreadN 16 --genomeDir . \
#     --readFilesIn Tub_Mos1_A_1_trim.fastq.gz Tub_Mos1_A_2_trim.fastq.gz \
#     --outFilterMultimapNmax 100 --winAnchorMultimapNmax 100 \
#     --outFileNamePrefix test --outSAMtype BAM SortedByCoordinate --readFilesCommand gunzip -c

# singularity exec tetranscripts.sif TEcount -b Aligned.sortedByCoord.out.bam --GTF dmel-all-r6.49.gtf --TE dmel-all-chromosome-r6.49_RMpolished.gtf --sortByPos --mode multi

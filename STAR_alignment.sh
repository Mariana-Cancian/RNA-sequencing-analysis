#!/bin/bash

### variable names

declare -a libraries=("Tub_Mos1_A"
"Tub_Mos1_B"
"Tub_Mos1_C"
"Tub_w1118_A"
"Tub_w1118_B"
"Tub_w1118_C"
"w1118_Mos1_A"
"w1118_Mos1_B"
"w1118_Mos1_C")

DATA="/media/labdros/Elements/RNAseq-mari/trimmed" ### path to the genome and gff files 
OUTPUT_STAR="/media/labdros/Elements/RNAseq-mari/trimmed" ### select the path to store the output (.bam files)

mkdir "$OUTPUT_STAR"/star_index "$OUTPUT_STAR"/star_align "$OUTPUT_STAR"/counts "$OUTPUT_STAR"/star_align/stat

STAR --runThreadN 16 --genomeSAindexNbases 12 --runMode genomeGenerate --genomeDir "$OUTPUT_STAR"/star_index --genomeFastaFiles "$DATA"/dmel-all-chromosome-r6.66.fasta --sjdbGTFfile "$DATA"/dmel-all-r6.66.gtf --sjdbOverhang 149

for file in "${libraries[@]}"; do
        echo "Alignment "$file""
        STAR --genomeDir "$OUTPUT_STAR"/star_index --runThreadN 16 --readFilesCommand zcat --readFilesIn "$file"_1_trim.fastq.gz "$file"_2_trim.fastq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix "$OUTPUT_STAR"/star_align/"$file"_

        mv "$OUTPUT_STAR"/star_align/*final.out "$OUTPUT_STAR"/star_align/stat
        rm "$OUTPUT_STAR"/star_align/*.out
done

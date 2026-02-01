#!/bin/bash

species_specific_gff="/media/labdros/Elements/RNAseq-mari/trimmed/star_align/dmel-all-r6.66.gtf" #GTF file location

# list all BAM files
bam_files=$(ls *.bam)

# run featureCounts on all BAM files at once
featureCounts -a "$species_specific_gff" \
  -o all_samples_counts.txt \
  -p -B -C -T 20 -t exon -g gene_id -s 2\
  $bam_files


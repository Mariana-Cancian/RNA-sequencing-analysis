#!/bin/bash

while read -r line; do
	R1_in=$(cut -f1 <<< "$line")
	R1_out=$(sed 's/.fastq.gz//' <<< "$R1_in")
	R2_in=$(cut -f2 <<< "$line")
	R2_out=$(sed 's/.fastq.gz//' <<< "$R2_in")

	docker run --rm -v $(pwd):$(pwd) -w $(pwd) staphb/trimmomatic trimmomatic \
	PE $R1_in $R2_in \
	"$R1_out"_trim.fastq.gz "$R1_out"_unp.fastq.gz \
	"$R2_out"_trim.fastq.gz "$R2_out"_unp.fastq.gz \
	ILLUMINACLIP:/usr/local/bin/adapters/TruSeq3-PE.fa:2:30:10 MINLEN:100 -threads 8
done < sample_names.txt

#!/usr/bin/env bash

# This script sums gene expression across celltypes

# param1: the path to the sample ID by gene matrix
# param2: the path to the metadata TSV
# output: a TSV where celltypes are rows and genes are columns

# ex: workflow/scripts/celltype_sum.bash data/nemo_data/mouse_transcriptome/mouse.csv data/nemo_data/mouse_transcriptome/meta_cols.tsv | gzip > data/prepared/mouse.tsv.gz

cat "$1" | \
datamash transpose -t ';' | \
tr -d '"' | \
sed 's/;/\t/g' | \
{
	echo -ne sample_id;
	cat;
} | \
{
	read -r head;
	echo "$head";
	sort -k1,1;
} | \
join -t $'\t' -j1 <(
	cat "$2" | \
	{
		read -r head;
		echo "$head";
		sort -k1,1;
	}
) - | \
{
	read -r head;
	num_samps="$(echo "$head" | awk -F $'\t' '{print NF;}')"
	echo "$head" | cut -f2-;
	datamash -s -t $'\t' -g 2,3 sum 4-"$num_samps"
}

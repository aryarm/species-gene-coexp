#!/bin/bash

# this script get identifies common cell types across our two species (human and mouse)
# and then sums the relevant counts

h_path="/storage/data/dsc291/nemo_data/human_transcriptome/Human_M1_10xV3_"
m_path="/storage/data/dsc291/nemo_data/mouse_transcriptome/Mouse_M1_10xV3_"

python workflow/scripts/extract_meta_cols.py ${m_path}Metdata.feather integrated_clusters_label data/processed/mouse_integrated_samples.tsv
python workflow/scripts/extract_meta_cols.py ${h_path}Metdata.feather integrated_clusters_label data/processed/human_integrated_samples.tsv

bash workflow/scripts/celltype_sum.bash data/nemo_data/human_transcriptome/human.csv data/processed/human_integrated_samples.tsv | gzip > data/prepared/human_integrated.tsv.gz

bash workflow/scripts/celltype_sum.bash data/nemo_data/mouse_transcriptome/human.csv data/processed/mouse_integrated_samples.tsv | gzip > data/prepared/mouse_integrated.tsv.gz
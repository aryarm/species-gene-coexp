import pandas as pd
import feather
import sys
meta_file = sys.argv[1]
col = sys.argv[2]
out_file = sys.argv[3]


meta = pd.read_feather(meta_file).set_index('sample_id')
cols =[col, 'donor_id']

meta[cols].to_csv(out_file, sep='\t')

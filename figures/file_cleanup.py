from pathlib import Path

# Use rglob("*") to recursively find all items
filepaths = [str(f) for f in Path('data/').rglob('*') if f.is_file()]

filenames = ['0_field_observed', '0_profiles_observed',
             'params', 'pos_receivers', 'pos_sources',
             'metric_time_svd', 'metric_time_classic',
             'metric_ssf_svd', 'metric_ssf_classic',
             'metric_time_vs_ssf_svd', 'metric_time_vs_ssf_classic',
             'fin_profiles_svd', 'fin_profiles_classic',]
for filename in 


for file in filepaths:
    print(file)
    
input('a')

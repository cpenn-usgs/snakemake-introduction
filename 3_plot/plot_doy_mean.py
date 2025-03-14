import pandas as pd
import os
import seaborn as sns
import matplotlib.pyplot as plt

def plot_doy_means(out_file, df_sel_depths):
    df_long = df_sel_depths.reset_index().melt(var_name="depth",
                                               value_name = "temperature (C)",
                                               id_vars=["doy", "site_id"])
    sns.relplot(data=df_long, x="doy", y="temperature (C)", col="site_id",
                hue="depth", col_wrap=2, kind='line')
    plt.tight_layout()
    plt.savefig(out_file)
    return out_file

def main(combined_doy_means, out_file, depths):
    out_dir = os.path.dirname(out_file)
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)
    df_combined = pd.read_csv(combined_doy_means).set_index(["doy", "site_id"])
    depth_cols = [f"temp_{d}" for d in depths]
    df_sel_depths = df_combined[depth_cols]
    plot_doy_means(out_file, df_sel_depths)

if __name__ == '__main__':
    combined_doy_means = snakemake.input['in_file']
    out_file = snakemake.output['out_file']
    depths = snakemake.params['lake_depths']
    main(combined_doy_means, out_file, depths)

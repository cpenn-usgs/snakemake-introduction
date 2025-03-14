rule all:
    input:
        "3_plot/out/doy_plot.png"

rule get_sb_data:
    params:
        sb_item = "5e5d0bb9e4b01d50924f2b36"
    output:
        sb_file = "1_fetch/tmp/pgdl_predictions_04_N45.50-48.00_W92.00-93.00.zip"
    script:
        "1_fetch/sb_get.py"

rule unzip_sb_data:
    input:
        zip_file_path = "1_fetch/tmp/pgdl_predictions_04_N45.50-48.00_W92.00-93.00.zip"
    output:
        "1_fetch/out/tmp/pgdl_nhdhr_{FC091A8F-FC45-46C0-91F9-18379CF0EAAE}_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_69545713_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_80006805_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_86444267_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_86445115_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_105954753_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_107071276_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_107071492_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_107072210_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_111726865_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120018402_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120018788_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120018790_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020150_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020163_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020166_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020167_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020444_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020465_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020466_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020478_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020480_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020497_temperatures.csv",
        "1_fetch/out/tmp/pgdl_nhdhr_120020979_temperatures.csv"
    script:
        "1_fetch/unzip_file.py"

rule calc_doy_means:
    input:
        in_file = "1_fetch/out/tmp/pgdl_nhdhr_{lake_id}_temperatures.csv"
    output:
        out_file = "2_process/out/doy_{lake_id}.csv"
    script:
        "2_process/calc_doy_means.py"

rule combine_site_files:
    input:
        "2_process/out/doy_120020150.csv",
        "2_process/out/doy_107072210.csv",
        "2_process/out/doy_86444267.csv",
        "2_process/out/doy_120020979.csv"
    output:
        out_file = "2_process/out/combined_doy.csv"
    script:
        "2_process/combine_site_files.py"

rule plot_doy_mean:
    params:
        lake_depths = [0, 2, 5, 10, 15, 20, 25]
    input:
        in_file = "2_process/out/combined_doy.csv"
    output:
        out_file = "3_plot/out/doy_plot.png"
    script:
        "3_plot/plot_doy_mean.py"

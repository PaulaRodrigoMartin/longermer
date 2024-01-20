#!/usr/bin/env Renv
## USAGE: mireact_downsampled.R a output_file

# Modify file paths accordingly

library(dplyr)
# source miReact code, download it from https://github.com/muhligs/miReact
source("/faststorage/project/sc_covid_PiB2023/miReact/code/mireact.R") 
# Your expression matrix
efile <- "/faststorage/project/sc_covid_PiB2023/2/data2/th_mireact_exp_downsampled.rds" 
# Your annotations file for each cell
annot <- read.csv("/faststorage/project/sc_covid_PiB2023/2/data2/annotation.csv", header = TRUE, row.names = 1)
# This following command starts miReact, run in a cluster
mireact(exp=efile, species="hs", motifs=7, seq.type="utr3",
        out.file="/faststorage/project/sc_covid_PiB2023/miReact/data/mirnaActivity_th_downsampled.rds",out.meonly=T,
        mail="paulilokiestudia@gmail.com", install.dir = "/faststorage/project/sc_covid_PiB2023/miReact", 
        annotation = annot)
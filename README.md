# longermer
This code takes miReact output (short kmers) as input and constructs longer motifs with potential biological relevance

To run miReact follow the instructions at https://github.com/muhligs/miReact. To access the publicly available data access Ren et al. (2021). COVID-19 immune features revealed by a large-scale single-cell transcriptome atlas. Cell. https://doi.org/10.1016/j.cell.2021.01.053.

## Overview of the workflow
```mermaid
graph TD;
    seqlist[seqs/hs.utr3.seqlist.rds]
    seqs[seqs/hs.utr3.seq.rds]
    mireact_input[data/th_mireact_exp_downsampled.rds]
    miReact_output[data/mirnaActivity_th_downsampled.rds]
    7mers[patterns/patterns7.csv]
    annotation[data/annotation.csv]
    miReact[code/mireact.R]
    functions[code/functions_build.R]
    functionsc[code/functions_check.R]
    main_notebook[code/main.Rmd]
    check_notebook[code/check.Rmd]
    GSEA[results/log/gsea_genes.csv]
    plots[results/plots]
    longmers[results/log/longmers_beforecheck.csv.rds]
    finallongmers[results/log/longmers_aftercheck.csv]
    

    style seqlist fill:#7cb5ec,stroke:#333,stroke-width:2px;
    style miReact_output fill:#7cb5ec,stroke:#333,stroke-width:2px;
    style 7mers fill:#7cb5ec,stroke:#333,stroke-width:2px;
    style mireact_input fill:#7cb5ec,stroke:#333,stroke-width:2px;
    %%style seqs fill:#7cb5ec,stroke:#333,stroke-width:2px;
    style annotation fill:#7cb5ec,stroke:#333,stroke-width:2px;
    style longmers fill:#7cb5ec,stroke:#333,stroke-width:2px;
    style finallongmers fill:#FFA07A,stroke:#333,stroke-width:2px;
    style plots fill:#FFA07A,stroke:#333,stroke-width:2px;
    style GSEA fill:#FFA07A,stroke:#333,stroke-width:2px;


    seqlist-->miReact
    7mers-->miReact
    mireact_input-->miReact
    annotation-->miReact
    miReact-->miReact_output
    functions-->main_notebook
    functionsc-->check_notebook
    main_notebook-->longmers
    longmers-->check_notebook
    check_notebook-->plots
    check_notebook-->finallongmers
    check_notebook-->GSEA
    %%finallongmers-->GSEA
    %%seqs-->GSEA
    miReact_output-->main_notebook
    seqs --> check_notebook

```
## Results example
Results were obtained after working with a subset dataset formed by 10,000 cells, of which 3,085 were infected. 11 different cell types were studied. This is an example of potential results after running the analysis (longermer/results/log/longmers_aftercheck.csv):

| Final longmer | Initial longmer | Cell type |
| :---         |     :---:      |          ---: |
| ATTA(C\|G)(A\|G)G(A\|G)TTAC   | GGGATTACAGGT    | Neutrophil    |
| AACC(C\|T)TATGA     | AACCCTATGAAT       | Squamous     |
| TTCACCATGTT     | TTCACCATGTT       | T, B cell, Macrophage     |
| AATGTGGCA    | GAATGTGGCA       | Macrophage     |

Further plots can be created with this code (longermer/results/log):

Spearman correlation distribution of the modified p-values from miReact for top 100 kmers used for the analysis vs random 100 kmers from the distribution:

<img src = "https://github.com/PaulaRodrigoMartin/longermer/assets/112614977/90d6edc6-4001-4deb-9efd-d88b14e17580" width="400" height="300"> 
<img src = "https://github.com/PaulaRodrigoMartin/longermer/assets/112614977/6ab0a435-6bdf-4518-b98d-77ab2154a092 width="400" height="300">


Logo of the final longmer after alignment to the whole set of sequences, including 10 flanking bases to both sides of the longmer:

![image](https://github.com/PaulaRodrigoMartin/longermer/assets/112614977/4f1e3e0e-edde-4d8e-b5c3-32df5362680d)



# BDMM-Flow Supplementary Material

Supplementary material for *Speeding up Multi-type Birth-Death Phylodynamics*, benchmarking the new flow implementation in the BDMM-Prime package against the conventional implementation.

- **[synthetic_benchmarks/](synthetic_benchmarks/)**: Synthetic benchmark results, analysis notebook, and exported plots.
- **[beast_benchmarks/](beast_benchmarks/)**: BEAST 2 configurations, run scripts, and analyses for the MERS-CoV and H3N2 datasets.
- **[misc_analyses/](misc_analyses/)**: Exploratory notebooks and data for numerical methods, conditioning, preconditioning, and performance experiments.

[synthetic_benchmarks/analysis.ipynb](synthetic_benchmarks/analysis.ipynb) generates the following paper plots:

| Figure | Plot |
| --- | --- |
| 4 | Speedup over BDMM-Prime across three tree-size groups. |
| 5 | Runtime rank distributions across the same tree-size groups. |
| 6 | Relative log-likelihood deviation from BDMM-Prime on simulated trees. |
| 9 | Effect of parallelization and caching on MERS-CoV runtime. |
| 10 | Computational cost split between tree prior, sequence likelihood, and other operations for MERS-CoV and H3N2. |

Figures 9 and 10 use manually recorded BEAST measurements embedded in the notebook.

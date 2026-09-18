# BDMM-Flow Supplementary Material

Supplementary material for *Speeding up Multi-type Birth-Death Phylodynamics*, benchmarking the new flow implementation in the [BDMM-Prime](https://github.com/tgvaughan/BDMM-Prime) package against the conventional implementation.

## Repository structure

- **[synthetic_benchmarks/](synthetic_benchmarks/)**: Synthetic benchmark results, analysis notebook, and exported plots.
- **[beast_benchmarks/](beast_benchmarks/)**: BEAST 2 configurations, run scripts, and analyses for the MERS-CoV and H3N2 datasets.
- **[misc_analyses/](misc_analyses/)**: Exploratory notebooks and data for numerical methods, conditioning, preconditioning, and performance experiments.

## Synthetic benchmark figures

[synthetic_benchmarks/analysis.ipynb](synthetic_benchmarks/analysis.ipynb) generates the following paper plots:

| Figure | Plot | Output |
| --- | --- | --- |
| 4 | Speedup over BDMM-Prime across three tree-size groups. | `speedup.svg` |
| 5 | Runtime rank distributions across the same tree-size groups. | `wins.svg` |
| 6 | Relative log-likelihood deviation from BDMM-Prime on simulated trees. | `rel_deviation.svg` |
| 9 | Effect of parallelization and caching on MERS-CoV runtime. | `caching_parallelization.svg` |
| 10 | Computational cost split between tree prior, sequence likelihood, and other operations for MERS-CoV and H3N2. | `runtime_fraction_stacked_bar_by_dataset.svg` |

Figures 9 and 10 use manually recorded BEAST measurements embedded in the notebook.

## BEAST benchmark figures

[beast_benchmarks/analyse.ipynb](beast_benchmarks/analyse.ipynb) analyzes BEAST runs on MERS-CoV and H3N2 and generates these paper plots:

| Figure | Plot | Output |
| --- | --- | --- |
| 7 | Runtime by algorithm, with median annotations. | `runtime_real.svg` |
| 8 | Mean relative log-likelihood deviation from BDMM-Prime. | `deviation_real.svg` |

The notebook also includes exploratory comparisons of interval strategies. Run it from `beast_benchmarks/` with results in each dataset's `out/` folder.

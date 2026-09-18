# BDMM-Flow Supplementary Material

This repository contains supplementary material for the BEAST 2 package [BDMM-Flow](https://github.com/tochsner/BDMM-Flow). It contains scripts to benchmark BDMM-Flow against BDMM-Prime using both synthetic data produced using the `benchmark` module in the BDMM-Flow package and BEAST 2 runs on real data.

## BEAST benchmark analysis

[beast_benchmarks/analyse.ipynb](beast_benchmarks/analyse.ipynb) analyzes BEAST runs on MERS-CoV and H3N2 and generates these paper plots:

| Figure | Plot | Output |
| --- | --- | --- |
| 7 | Runtime by algorithm, with median annotations. | `runtime_real.svg` |
| 8 | Mean relative log-likelihood deviation from BDMM-Prime. | `deviation_real.svg` |

The notebook also includes exploratory comparisons of interval strategies. Run it from `beast_benchmarks/` with results in each dataset's `out/` folder.

# BEAST benchmarks

BEAST XML configurations and Slurm scripts for the H3N2 and MERS-CoV benchmarks.

The benchmarks were run with **BEAST 2.7**. The current [BDMM-Prime](https://github.com/tgvaughan/BDMM-Prime) package is compatible only with **BEAST 2.8**; reproducing the original runs requires a BEAST 2.7-compatible package version.

Run each dataset's `run_*.sh` with Bash from its folder after adjusting the BEAST path and cluster settings. The scripts create `out/` and `results/` if needed and clear their previous contents.

Run `analyse.ipynb` from this folder to read `out/*.out` results and generate Figures 7 (runtime) and 8 (likelihood deviation). The `analyse*.sh` helpers are for legacy output filenames.

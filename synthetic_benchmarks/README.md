# Synthetic benchmarks

`analysis.ipynb` compares flow algorithms with BDMM-Prime on simulated trees and exports Figures 4-6, 9, and 10; see the [figure table](../README.md) for output filenames. Figures 9 and 10 use BEAST measurements embedded in the notebook.

Run the notebook from this folder after installing the Python dependencies in the repository's `pyproject.toml`. Update its input path to results from the Java `bdmmprime.flow.benchmark.Benchmark` class. Benchmark input data are not bundled; generate a compatible CSV containing the columns required by the notebook, including `trial`, `algorithm`, and `initial_state_strategy`.

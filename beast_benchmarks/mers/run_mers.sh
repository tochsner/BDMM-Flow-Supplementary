# submit MERS-CoV benchmarks to Slurm for 16 seeds and all flow/preconditioner/interval combinations.
# run with Bash from this dataset folder; requires sbatch and the configured relative BEAST executable.
# deletes existing contents of out/ and results/ before submitting jobs; creates the folders if missing.

mkdir -p out results || exit 1

rm -rf out/*
rm -rf results/*

preconditioners=("identity" "average_inverse")

for i in `seq 1 16`; do
    for preconditioner in "${preconditioners[@]}"; do
        for inverseFlow in true false; do
            for loucaPennell in true false; do
                experiment="bdmmflow.${preconditioner}.${inverseFlow}.1e8.${loucaPennell}.${i}"
                sbatch --cpus-per-task=12 --time=96:00:00 --mem-per-cpu=6G --output out/$experiment.out --wrap="../../../../beast/bin/beast -threads -1 -seed $i -D 'preconditioner=$preconditioner,inverseFlow=$inverseFlow,maxConditioningNumber=1e8,useLoucaPennellIntervals=${loucaPennell}' -statefile results/$experiment.state -overwrite bdmm-flow.xml"
            done
        done
    done

    sbatch --cpus-per-task=12 --time=120:00:00 --mem-per-cpu=6G --output out/bdmmprime_$i.out --wrap="../../../../beast/bin/beast -threads -1 -seed $i -statefile results/bdmm-prime.$i.state -overwrite bdmm-prime.xml"
done

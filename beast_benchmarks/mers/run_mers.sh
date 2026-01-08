mkdir -p out
mkdir -p results

for i in `seq 1 1`; do
    sbatch --cpus-per-task=8 --mem-per-cpu=2G --output out/bdmmflow_$i.out --wrap="../../../../beast/bin/beast -statefile results/bdmm-flow.$i.state -overwrite bdmm-flow.xml"
    # sbatch --cpus-per-task=8 --mem-per-cpu=2G --output out/bdmmflow_random_inverse_$i.out --wrap="../../../../beast/bin/beast -statefile results/bdmm-flow-random-inverse.$i.state -overwrite bdmm-flow-random-inverse.xml"
    # sbatch --cpus-per-task=8 --mem-per-cpu=2G --output out/bdmmflow_random_$i.out --wrap="../../../../beast/bin/beast -statefile results/bdmm-flow-random.$i.state -overwrite bdmm-flow-random.xml"
    # sbatch --cpus-per-task=8 --mem-per-cpu=2G --output out/bdmmprime_$i.out --wrap="../../../../beast/bin/beast -statefile results/bdmm-prime.$i.state -overwrite bdmm-prime.xml" --time=20:00:00
done

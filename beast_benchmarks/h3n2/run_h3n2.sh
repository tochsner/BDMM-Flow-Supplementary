rm -rf out
rm -rf results

mkdir -p out
mkdir -p results

for i in `seq 1 1`; do
    sbatch --cpus-per-task=8 --time=160:00:00 --mem-per-cpu=4G --output out/bdmmflow_$i.out --wrap="../../../../beast/bin/beast -seed 2297453$i -statefile results/bdmm-flow.$i.state -overwrite bdmm-flow.xml"
    sbatch --cpus-per-task=8 --time=160:00:00 --mem-per-cpu=2G --output out/bdmmflow_random_$i.out --wrap="../../../../beast/bin/beast -seed 2297453$i -statefile results/bdmm-flow-random.$i.state -overwrite bdmm-flow-random.xml"
    sbatch --cpus-per-task=8 --time=160:00:00 --mem-per-cpu=4G --output out/bdmmprime_$i.out --wrap="../../../../beast/bin/beast -seed 2297453$i -statefile results/bdmm-prime.$i.state -overwrite bdmm-prime.xml"
done

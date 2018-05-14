# FindCommon_NCBI

We use this to find the species whose chloroplast_genome and mitochondria_genome are both in the database of NCBI.

```bash
cd ~/FindCommon_NCBI

#We need to know where are the chloroplast_genomes and mitochondria_genomes.
perl find_common.pl \
~/data/organelle/mito/GENOMES \
~/data/organelle/plastid_genomes \
> common.csv

#55
cat common.csv | grep -v "^#" | wc -l

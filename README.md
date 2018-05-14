# FindCommon_NCBI

We use this to find the species whose chloroplast_genome and mitochondria_genome are both in the database of NCBI.

```bash
mkdir -p ~/data/organelle/common
cd ~/data/organelle/common


#We need to know where are the chloroplast_genomes and mitochondria_genomes.
perl ~/Scripts/FindCommon_NCBI/find_common.pl \
~/data/organelle/plastid_genomes \
~/data/organelle/mito/GENOMES  \
> common_sp.csv

#55
cat common.csv | grep -v "^#" | wc -l

```

Remove these chloroplast_genomes and mitochondria_genomes to a new folder.

```bash 
mkdir -p ~/data/organelle/common/genomes
cd ~/data/organelle/common/genomes



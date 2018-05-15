# FindCommon_NCBI

We use this to find the species whose chloroplast_genome and mitochondria_genome are both in the database of NCBI.

```bash
mkdir -p ~/data/organelle/common
cd ~/data/organelle/common


#We need to know where are the chloroplast_genomes and mitochondria_genomes.
perl ~/Scripts/FindCommon_NCBI/find_common.pl \
~/data/organelle/plastid/GENOMES \
~/data/organelle/mito/GENOMES  \
> common_sp.csv


#55
cat common_sp.csv | grep -v "^#" | wc -l

```

Remove these chloroplast_genomes and mitochondria_genomes to a new folder.

```bash 
mkdir -p ~/data/organelle/common/genomes
cd ~/data/organelle/common/genomes

perl ~/Scripts/FindCommon_NCBI/get_mit_chl.pl \
../common_sp.csv \
~/data/organelle/plastid/GENOMES \
~/data/organelle/mito/GENOMES 

```
Prepare sequences for lastz.
```bash 
cd ~/data/organelle/common/genomes

find . -maxdepth 1 -type d -path "*/*" |
    sort |
    parallel --no-run-if-empty --linebuffer -k -j 2 '
        echo >&2 "==> {}"
        
        if [ -e {}/chr.fasta ]; then
            echo >&2 "    {} has been processed"
            exit;
        fi

        egaz prepseq \
            {} \
            --gi -v --repeatmasker " --gff --parallel 4"
    '
```


Try to put the genomes we chose into genus.

```bash 
mkdir -p ~/data/organelle/common/genus
cd ~/data/organelle/common/genus

#Here we choose chloroplastid.ABBR.csv as a reference.
perl ~/Scripts/FindCommon_NCBI/ABBR_to_genus.pl \
~/data/organelle/common/common_sp.csv \
~/data/organelle/plastid/summary/chloroplastid.ABBR.csv
```


Self-alignments
```bash
mkdir -p ~/data/organelle/common/self
cd ~/data/organelle/common/genus

perl ~/Scripts/FindCommon_NCBI/egaz_circos.pl

cd ~/data/organelle/common/self
for d in `find . -mindepth 1 -maxdepth 1 -type d | sort `;do
    echo "echo \"====> Processing ${d} <====\""
    echo bash ${d}/1_self.sh;
    echo bash ${d}/3_proc.sh;
    echo bash ${d}/4_circos.sh;
    echo ;
done  > runall.sh

sh runall.sh 2>&1 | tee log_runall.txt

# clean
find . -mindepth 1 -maxdepth 2 -type d -name "*_raw" | parallel -r rm -fr
find . -mindepth 1 -maxdepth 2 -type d -name "*_fasta" | parallel -r rm -fr









#Requires: bcftools, vcftools, subread, tabix, BEDTools, samtools, SnpSift
#DBSNP file can be downloaded from: ftp://ftp.ncbi.nlm.nih.gov/snp/organisms/human_9606/VCF/
DBSNP=00-All.vcf.gz
#REDIporta;_hg38_output.vcf is downlaoded from http://srv00.recas.ba.infn.it/atlas/download.html; compressed and indexed with tabix
#genes_from_hg38_ensembl.bed.gz is the bed file with protein coding gene only, downloaded from Ensembl
#header_REDIportal.hdr is
echo '##INFO=<ID=HIT,Number=0,Type=Flag,Description="Located in a the region">' > header_REDIportal.hdr
echo '##INFO=<ID=GENE_ID,Number=1,Type=String,Description="GENE ID from Ensembl">' >> header_REDIportal.hdr
echo '##INFO=<ID=STRAND,Number=1,Type=String,Description="STRAND information from Ensembl">' >> header_REDIportal.hdr
echo '##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">' >> header_REDIportal.hdr
echo '##INFO=<ID=TYPE,Number=1,Type=String,Description="Type">' >> header_REDIportal.hdr
echo '##INFO=<ID=VALIDATED,Number=1,Type=String,Description="Present in REDIportal database">' >> header_REDIportal.hdr

#header_vcf_GC.hdr is
echo '##INFO=<ID=HIT,Number=0,Type=Flag,Description="Located in a the region">' > header_vcf_GC.hdr
echo '##INFO=<ID=GENE_ID,Number=1,Type=String,Description="GENE ID from Ensembl">' >> header_vcf_GC.hdr
echo '##INFO=<ID=STRAND,Number=1,Type=String,Description="STRAND information from Ensembl">' >> header_vcf_GC.hdr
echo '##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">' >> header_vcf_GC.hdr

sample_name=sample
echo "[Annotating known sites using DBSNP for] $sample_name" 
bgzip -c "$sample_name"_mismatch_output.vcf > "$sample_name"_mismatch_output.vcf.gz
tabix -p vcf "$sample_name"_mismatch_output.vcf.gz
java -jar $SnpSift annotate $DBSNP "$sample_name"_mismatch_output.vcf.gz | bgzip -c > "$sample_name"_dbsnp_output.vcf.gz
tabix -p vcf "$sample_name"_dbsnp_output.vcf.gz
bcftools annotate -a REDIportal_hg38.bed.gz -h header_REDIportal.hdr -c CHROM,FROM,TO,TYPE,HIT,STRAND,VALIDATED "$sample_name"_dbsnp_output.vcf.gz > "$sample_name"_dbsnp_REDI_annotated.vcf 
bcftools annotate -a genes_from_hg38_ensembl.bed.gz -h header_vcf_GC.hdr -l GENE_ID:unique -l STRAND:unique -c CHROM,FROM,TO,GENE_ID,HIT,STRAND "$sample_name"_dbsnp_REDI_annotated.vcf > "$sample_name"_dbsnp_annotated.vcf 


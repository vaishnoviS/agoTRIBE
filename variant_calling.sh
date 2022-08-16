#custom pipeline for variant_calling.sh
#Required samtools, samfixcigar and sam2tsv
#Code to try and get the sam2tsv to produce the list of mismatches
#Block2.1: initialise variables 
read_depth_cutoff=0  ##Change this to set the DP cut off
SAMFIXCIGAR=samfixcigar.jar
SAM2TSV=sam2tsv.jar
GENOME=resources-broad-hg38-v0-Homo_sapiens_assembly38.fasta
#vcf_header.txt
echo '##fileformat=VCFv4.2' > vcf_header.txt
echo $'#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO' >> vcf_header.txt

#Phread_score input file 
#The script has to be run as awk -v Pst=10 -f script.awk
#where Pst is the user defined Phred score threshold 
#where ASCII_Qscore_conversion.txt is a two column tab seperated file with column 1 as the Qscore and column 2 is the corresponding ASCII character
Pst=30 ##Change this to set the phred score cut-off
awk -v n="$Pst" '$1>n' ASCII_Qscore_conversion.txt | cut -f 2 | grep -v "ASCII" > ASCII_phred_score_defined.txt


#Converting the actual Bam file to a reduced size file which only contains the reads that contain a mismatch
sample_name=sample
echo "[Extracting only the reads with mis-matches based on CIGAR string] $sample_name"
java -jar $SAMFIXCIGAR -r $GENOME --samoutputformat BAM --output "$sample_name"_cigar_fixed.bam "$sample_name"_dedupped.bam
samtools view -H "$sample_name"_cigar_fixed.bam > "$sample_name"_header.sam
samtools view "$sample_name"_cigar_fixed.bam | awk '$6 ~ /X/ {print $0}' > "$sample_name"_filtered_mismatch_reads.bam
cat "$sample_name"_header.sam "$sample_name"_filtered_mismatch_reads.bam > "$sample_name"_tmp
mv "$sample_name"_tmp "$sample_name"_filtered_mismatch_reads.bam
echo "[Processing the bam file with sam2tsv and parser to extract mismatces] $sample_name"
java -jar $SAM2TSV -R $GENOME "$sample_name"_filtered_mismatch_reads.bam | awk '$10=="X"' | grep -v "REF-POS1" | awk 'NR==FNR { A[$1]=1 ; next } $7 in A { print $0 }' ASCII_phred_score_defined.txt - | awk -v OFS='\t' '{if($9!=$6) print $4,";", $8, ";", $9,";", $6, $1}'  | awk '{if($7!=".") print $0}' | awk '{if($7!="N") print $0}' | awk '{A[$1$2$3$4$5$6$7]++}END{for(i in A)print i,A[i]}' | tr ";" "\t" | tr " " "\t"  | awk -v OFS='\t' '{print $1,";", $2, ";", $3,";", $4, "-", $5}' | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k2,2n"}' | awk -v OFS=";" '{a[$1$2$3$4$5]=a[$1$2$3$4$5](a[$1$2$3$4$5]==""?"":",")$7$8$9}END{for(i in a)print i, a[i]}' | grep -v "," | tr "-" "\t" | awk -v n="$read_depth_cutoff" '$2>n' | tr ";" "\t" | awk -v OFS="\t" '{if(length($4)==1) print $1, $2, ".", $3, $4, ".", ".", "DP="$5, "."}' | sort -k1,1 -k2,2n > "$sample_name"_output_file.txt
cat vcf_header.txt "$sample_name"_output_file.txt > "$sample_name"_mismatch_output.vcf

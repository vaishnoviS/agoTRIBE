#alignment using STAR
#Requires star/2.7.2b
STAR --genomeDir hg38_index/ --runThreadN 20 --readFilesIn Sample.1.fastq Sample.2.fastq --outFilterType BySJout --outFilterMultimapNmax 20 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 --outFileNamePrefix Sample --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate --outSAMmapqUnique 60 --twopassMode Basic --outFilterMatchNmin 16 --outFilterMismatchNoverLmax 0.07
#Processing BAM using Picard
java -jar picard.jar ReorderSam I=SampleAligned.sortedByCoord.out.bam O=Sample_ordered.bam R=resources-broad-hg38-v0-Homo_sapiens_assembly38.fasta ALLOW_CONTIG_LENGTH_DISCORDANCE=True ALLOW_INCOMPLETE_DICT_CONCORDANCE=True VALIDATION_STRINGENCY=SILENT
java -jar picard.jar AddOrReplaceReadGroups I=Sample_ordered.bam O=Sample_rg_added.bam RGID=Sample RGLB=lib1 RGPL=illumina RGPU=unit1 RGSM=Sample
java -jar picard.jar MarkDuplicates INPUT=Sample_rg_added.bam METRICS_FILE=Sample_metrics.txt REMOVE_DUPLICATES=true OUTPUT=Sample_dedupped.bam CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT

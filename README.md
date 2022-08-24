# agoTRIBE editing site calling pipeline
Steps to Follow
1. Run alignment with STAR tool and remove duplicate reads using Picard tool - code in alignment_and_picard.sh
2. Convert BAM to table and extract variants with Phred score higher than threshold and based on number of reads containing the alternate nucleotide - code in variant_calling.sh
3. dbSNP, REDIportal and adding gene ID and strand informtaion to VCF file - code in annotating_variant_files.sh

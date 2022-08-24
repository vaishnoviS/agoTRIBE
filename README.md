# agoTRIBE detects microRNA-target interactions transcriptome-wide in single cells

#### Abstract

MicroRNAs are gene regulatory molecules that play important roles in numerous biological processes including human health. The function of a given microRNA is defined by its selection of target transcripts, yet current state-of-the-art experimental methods to identify microRNA targets are laborious and require millions of cells. We have overcome these limitations by fusing the microRNA effector protein Argonaute2 to the RNA editing domain of ADAR2, allowing for the first time the detection of microRNA targets transcriptome-wide in single cells. Our agoTRIBE method reports functional microRNA targets which are additionally supported by evolutionary sequence conservation. As a proof-of-principle, we study microRNA interactions in single cells, and find substantial differential targeting across the cell cycle. Lastly, agoTRIBE additionally provides transcriptome-wide measurements of RNA abundance and will allow the deconvolution of microRNA targeting in complex tissues at the single-cell level.

#### Read the full research at https://doi.org/10.1101/2022.08.10.503472 





#### agoTRIBE editing site calling pipeline
Steps to Follow
1. Run alignment with STAR tool and remove duplicate reads using Picard tool - code in alignment_and_picard.sh
2. Convert BAM to table and extract variants with Phred score higher than threshold and based on number of reads containing the alternate nucleotide - code in variant_calling.sh
3. dbSNP, REDIportal and adding gene ID and strand informtaion to VCF file - code in annotating_variant_files.sh

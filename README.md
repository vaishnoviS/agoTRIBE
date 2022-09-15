# agoTRIBE detects microRNA-target interactions transcriptome-wide in single cells

#### Abstract

MicroRNAs are gene regulatory molecules that play important roles in numerous biological processes including human health. The function of a given microRNA is defined by its selection of target transcripts, yet current state-of-the-art experimental methods to identify microRNA targets are laborious and require millions of cells. We have overcome these limitations by fusing the microRNA effector protein Argonaute2 to the RNA editing domain of ADAR2, allowing for the first time the detection of microRNA targets transcriptome-wide in single cells. Our agoTRIBE method reports functional microRNA targets which are additionally supported by evolutionary sequence conservation. As a proof-of-principle, we study microRNA interactions in single cells, and find substantial differential targeting across the cell cycle. Lastly, agoTRIBE additionally provides transcriptome-wide measurements of RNA abundance and will allow the deconvolution of microRNA targeting in complex tissues at the single-cell level.

#### Read the full research at https://doi.org/10.1101/2022.08.10.503472 





#### agoTRIBE editing site calling pipeline
Steps to Follow
1. Run alignment with STAR tool and remove duplicate reads using Picard tool - code in alignment_and_picard.sh
2. Convert BAM to table and extract variants with Phred score higher than threshold and based on number of reads containing the alternate nucleotide - code in variant_calling.sh
3. dbSNP, REDIportal and adding gene ID and strand informtaion to VCF file - code in annotating_variant_files.sh


# Supplementary table for the manuscipt can be found under directory SupplementaryTables

# References
1. Dobin, A. et al. STAR: ultrafast universal RNA-seq aligner. Bioinformatics 29, 15-21 (2013).

2. Tarasov, A., Vilella, A.J., Cuppen, E., Nijman, I.J. & Prins, P. Sambamba: fast processing of NG alignment formats. Bioinformatics 31, 2032-2034 (2015).

3. Liao, Y., Smyth, G.K. & Shi, W. featureCounts: an efficient general purpose program for assigning sequence reads to genomic features. Bioinformatics 30, 923-930 (2014).

4. Sherry, S.T., Ward, M. & Sirotkin, K. dbSNP-database for single nucleotide polymorphisms and other classes of minor genetic variation. Genome research 9, 677-679 (1999).

5. Picardi, E., D'Erchia, A.M., Lo Giudice, C. & Pesole, G. REDIportal: a comprehensive database of A-to-I RNA editing events in humans. Nucleic acids research 45, D750-D757 (2017).

6. Blin, K. et al. DoRiNA 2.0--upgrading the doRiNA database of RNA interactions in posttranscriptional regulation. Nucleic acids research 43, D160-167 (2015).

7. Lindenbaum, Pierre: JVarkit: java-based utilities for Bioinformatics. figshare. http://dx.doi.org/10.6084/m9.figshare.1425030 (2015)

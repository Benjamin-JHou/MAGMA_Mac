# MAGMA_Mac
![Image text](https://user-images.githubusercontent.com/147773802/278640350-52513be5-1e74-4db1-928e-31b673f8c47a.png)
MAGMA_Mac is an extensively used tool for gene-based analysis, gene-set enrichment analysis, and gene property analysis. 

---
# 🌋 MAGMA Gene Visualization Guide

This guide provides an overview of the visualization techniques used for the gene identity analysis and Gene Ontology (GO) enrichment results based on the MAGMA analysis.

1. Gene Identity Analysis  visualization: the gene expression levels across different tissue types. The visualization highlights the average expression values and uses a brown line to indicate the Bonferroni threshold. Genes with expression levels above this threshold are of particular interest, as they may be more strongly associated with the phenotype under study.

[🔗 View the Gene Identity Analysis Script](https://github.com/Benjamin-JHou/MAGMA_Mac/blob/main/gene_identity.R)

2. Gene Ontology (GO) Enrichment visualization: which helps in understanding the functional aspects of the genes of interest. It categorizes genes based on their involvement in various biological processes, cellular components, and molecular functions. Genes are grouped by their GO terms, and the significance of each term is denoted by its p-value. A brown line on the visualization represents the Bonferroni threshold, aiding in the identification of significantly enriched terms.

[🔗 View the GO Enrichment Script](https://github.com/Benjamin-JHou/MAGMA_Mac/blob/main/GO_enrichment.R)

For more details on MAGMA and its applications, refer to the official [MAGMA documentation](https://ctg.cncr.nl/software/magma).

---
## 📊 Required data: a file containing SNP locations and a file containing gene locations.
---
## 🍏 Installing MAGMA on Mac

1. Download the Mac version of MAGMA. [Download the ZIP file](https://ctg.cncr.nl/software/MAGMA/prog/magma_v1.10_mac.zip)
2. Unzip the downloaded file.
3. Move the MAGMA binary to an appropriate directory and ensure directory in system path.
---
## 📖 Annotation with MAGMA

Reference population selection
- 😊 [East Asian](https://ctg.cncr.nl/software/MAGMA/ref_data/g1000_eas.zip)
- 😃 [European](https://ctg.cncr.nl/software/MAGMA/ref_data/g1000_eur.zip)
- 😄 [African](https://ctg.cncr.nl/software/MAGMA/ref_data/g1000_afr.zip)
- 😊 [South Asian](https://ctg.cncr.nl/software/MAGMA/ref_data/g1000_sas.zip)
- 😆 [Middle/South American](https://ctg.cncr.nl/software/MAGMA/ref_data/g1000_amr.zip)

On a Mac, perform gene annotation using the following command:

```bash
magma --annotate --snp-loc g1000_eas.bim --gene-loc gene.loc --out [OUTPUT_PREFIX]
```
---
## 🧬 GENE-BASED ANALYSIS
### ⚠️ Notice:
1. Consistency between reference sample and annotation: We used a reference sample named g1000_eas, which is data for the East Asian population. For accurate results, ensure that the annotation file is consistent with the population source of the reference sample.
2. Parameters for the P-value file: We specified the P-value with --pval snp N=8436. The snp here should be the path to the GWAS result file, that is, [GWAS_PVAL_FILE]. Make sure the file name is correct and that the file actually exists in the current working directory.

```bash
magma --bfile g1000_eas --pval SNP N=8436 --gene-annot g1000_eas.genes.annot --out genebased
```
---
## 🔓 Interpretation of gene-based association analysis results
- **GENE**: the gene ID as specified in the annotation file
- **CHR**: the chromosome the gene is on
- **START/STOP**: the annotation boundaries of the gene on that chromosome (this includes any window around the gene applied during annotation)
- **NSNPS**: the number of SNPs annotated to that gene that were found in the data and were not excluded based on internal SNP QC
- **NPARAM**: the number of relevant parameters used in the model. For the SNP-wise models this is an approximate value; for the principal components regression (raw data default) this is set to the number of principal components retained after pruning; for the multimodels this is the mean NPARAM value of the component base models
- **N**: the sample size used when analysing that gene; can differ for allosomal chromosomes or when analysing SNP p-value input with variable sample size by SNP (due to missingness or differences in coverage in meta-analysis)
- **ZSTAT**: the Z-value for the gene, based on its (permutation) p-value; this is what is used as the measure of gene association in the gene-level analyses
- **P**: the gene p-value
---
## 📈 gene-set enrichment analysis (GSEA)
On Mac, performing MAGMA-based gene-set enrichment analysis (GSEA) involves the following steps:
1. Gene score calculation: First, a score is calculated for each gene based on the results of gene association analysis.
2. Gene set enrichment analysis: Then, using the gene scores calculated in the previous step, gene set enrichment analysis was performed.
### ⚠️ Notice:
1. [BINARY_PED_FILE_PREFIX] is the prefix of binary ped files (such as .bed/.bim/.fam files).
2. [GENE_ANALYSIS_OUTPUT_FILE] is the path to the gene association analysis output file.
3. [GENE_SCORES_OUTPUT_PREFIX] is the prefix of the gene score output file.
4. [GENE_SET_FILE] is the file containing the gene set definition.
5. [GENE_SCORES_OUTPUT_FILE] is the path to the gene score file.
6. [GSEA_OUTPUT_PREFIX] is the prefix of the GSEA output file.

```bash
# Compute gene-level statistics
magma --bfile [BINARY_PED_FILE_PREFIX] --gene-results [GENE_ANALYSIS_OUTPUT_FILE] --out [GENE_SCORES_OUTPUT_PREFIX]

# Perform gene-set enrichment analysis
magma --gene-set [GENE_SET_FILE] --gene-scores [GENE_SCORES_OUTPUT_FILE] --out [GSEA_OUTPUT_PREFIX]
```
## 🔓 Interpretation of gene-set enrichment analysis(GSEA) 
- **GENESET**: The name or ID of the gene set.
- **NGENES**: The number of genes in the gene set.
- **NINDATA**: The number of genes in the gene set that were also found in the gene analysis results.
- **ZSTAT**: The Z-value for the gene set, based on its permutation p-value.
- **P**: The p-value for the gene set's enrichment.
- **NROT**: The number of rotations (or permutations) that were run.
- **P_BONF**: The Bonferroni-corrected p-value.
---
## 🧬 GENE-PROPERTY ANALYSIS
### ⚠️ Notice:
1. [GENE_PROPERTY_FILE] is a file containing gene property information.
2. [GENE_SCORES_OUTPUT_FILE] is the path to the gene score file.
3. [GENE_PROPERTY_OUTPUT_PREFIX] is the prefix of the gene property analysis output file.
```bash
magma --gene-property [GENE_PROPERTY_FILE] --gene-scores [GENE_SCORES_OUTPUT_FILE] --out [GENE_PROPERTY_OUTPUT_PREFIX]
```
## 🔓 Interpretation of gene property analysis
- **PROPERTY**: The gene property being analyzed.
- **NGENES**: The number of genes that have this property.
- **NINDATA**: The number of genes with this property that were also found in the gene analysis results.
- **ZSTAT**: The Z-value for the gene property, based on its permutation p-value.
- **P**: The p-value for the gene property's association with the trait.
- **NROT**: The number of rotations (or permutations) that were run.
- **P_BONF**: The Bonferroni-corrected p-value.
---
## 🔗 Links and Resources
- 🙏 [MAGMA Software, Resources & GWAS SumstatsSoftware, Resources & GWAS Sumstats](https://ctg.cncr.nl/software/magma)
- 📖 [MAGMA User Manual](https://ctg.cncr.nl/software/MAGMA/doc/manual_v1.10.pdf)

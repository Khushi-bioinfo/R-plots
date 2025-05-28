# Load required libraries
library(DESeq2)
library(ggplot2)
library(GEOquery)
library(dplyr)
library(tidyverse)

# ---------------create metadata---------------------------------------------------------------------------------------

# Load the data
raw<- read.csv("GSE183947_fpkm.csv.gz")
dim(raw)

#get metadata from GEO Query
gse<-getGEO(GEO="GSE183947",GSEMatrix=TRUE)
gse

metadata<-pData(gse[[1]])
head(metadata)
metadata_subset <- metadata[, c(1, 10, 11, 17)]
names(metadata_subset)[2] <- "tissue"
names(metadata_subset)[3] <- "metastasis"
names(metadata_subset)[4] <- "description"


metadata_subset$tissue <- gsub("tissue: ", "", metadata$tissue)
metadata_subset$metastasis <- gsub("metastasis: ", "", metadata$metastasis)

head(metadata_subset)

#----create count data and merge it with metadata------------------------------------
counts <- read.delim("GSE183947_raw_counts.tsv.gz", row.names = 1)

dim(counts)      # Should return genes x samples
dim(metadata)    # Should return samples x metadata variables

# checking how count and metadata looks

sample_names <- colnames(counts)
sample_names

head(metadata[, 1:5])

rownames(metadata) <- metadata$geo_accession
metadata_subset <- metadata[sample_names, ]
dim(metadata_subset)  # Should be 12 x 41 if you have 12 samples
all(rownames(metadata_subset) == sample_names)  # Should return TRUE

colnames(metadata_subset)  # To see exact column name

table(metadata_subset$`tissue:ch1`)
table(metadata_subset$`metastasis:ch1`)
table(metadata_subset$`donor:ch1`)
# to match both metadata and count

metadata_subset$Metastasis <- metadata_subset$`metastasis:ch1`

dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = metadata_subset,
                              design = ~ Metastasis)

dds <- DESeq(dds)
res <- results(dds)

#------Different R plots---------------------------------------------------------------------

#----------------------- MA
plotMA(res,alpha=0.2,ylim = c(-5, 5))
res$pval_sig <- res$pvalue < 0.05
plotMA(res, alpha = 1)  # disables padj threshold

#--------------------------PCA plot
vsd <- vst(dds, blind = FALSE)
plotPCA(vsd, intgroup = "Metastasis")

#--------------Heat Map---------------------
# Order results by adjusted p-value top 30
topGenes <- head(order(res$padj, na.last = NA), 30)

library(DESeq2)

# Use vst for visualization (you may have done this already)
vsd <- vst(dds, blind = FALSE)

# Extract matrix for top genes
mat <- assay(vsd)[topGenes, ]

# Optional: Z-score normalization by gene
mat <- t(scale(t(mat)))

annotation_col <- as.data.frame(colData(vsd)[, "Metastasis", drop = FALSE])

install.packages("pheatmap")
library(pheatmap)

pheatmap(mat,
         annotation_col = annotation_col,
         show_rownames = TRUE,
         show_colnames = TRUE,
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         scale = "row",  # if not already scaled manually
         fontsize_row = 8,
         fontsize_col = 10,
         main = "Top 30 Differentially Expressed Genes")

#--------------volcano plot--------------------------------------------
# Convert results to data frame
res_df <- as.data.frame(res)

# Remove NAs
res_df <- res_df[!is.na(res_df$padj), ]

# Significance
res_df$threshold <- "Not Sig"
res_df$threshold[res_df$pvalue < 0.01 & res_df$log2FoldChange > 1] <- "Up"
res_df$threshold[res_df$pvalue < 0.01 & res_df$log2FoldChange < -1] <- "Down"

ggplot(res_df, aes(x = log2FoldChange, y = -log10(pvalue), color = threshold)) +
  geom_point(alpha = 0.6, size = 1.5) +
  scale_color_manual(values = c("Up" = "red", "Down" = "green", "Not Sig" = "grey")) +
  theme_minimal() +
  labs(
    title = "Exploratory Volcano Plot",
    x = "Log2 Fold Change",
    y = "-Log10 P-value"
  ) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "black") +
  geom_hline(yintercept = -log10(0.01), linetype = "dashed", color = "black")


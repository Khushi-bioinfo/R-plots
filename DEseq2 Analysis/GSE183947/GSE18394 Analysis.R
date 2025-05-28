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

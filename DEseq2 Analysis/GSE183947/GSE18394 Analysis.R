# Load required libraries
library(DESeq2)
library(ggplot2)
library(GEOquery)
library(dbplyr)
library(tidyverse)

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

counts <- read.delim("GSE212787_raw_counts.tsv.gz", row.names = 1)
setwd("D:/CliniLaunch/geo")


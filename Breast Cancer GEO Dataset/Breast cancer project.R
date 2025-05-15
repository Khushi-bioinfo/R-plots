# Load necessary libraries
library(GEOquery)
library(ggplot2)
library(dplyr)
library(tidyr)

# Download dataset from GEO
gse <- getGEO("GSE15852", GSEMatrix = TRUE)

# Extract expression matrix (genes x samples)
expr_matrix <- exprs(gse[[1]])

# Extract sample metadata
metadata <- pData(gse[[1]])

# Create a Condition column based on 'title' field
metadata$Condition <- ifelse(grepl("normal", metadata$title, ignore.case = TRUE),
                             "Normal", "Tumor")

# Convert matrix to data frame and add gene names
expr_df <- as.data.frame(expr_matrix)
expr_df$Gene <- rownames(expr_df)

# Convert to long (tidy) format: Gene | Sample | Expression
long_expr <- pivot_longer(expr_df, cols = -Gene,
                          names_to = "Sample", values_to = "Expression")

# Add Tumor/Normal condition to expression data
long_expr <- left_join(long_expr,
                       metadata %>% select(geo_accession, Condition),
                       by = c("Sample" = "geo_accession"))

# Add Tumor/Normal condition to expression data
long_expr <- left_join(long_expr,
                       metadata %>% select(geo_accession, Condition),
                       by = c("Sample" = "geo_accession"))

# Choose a gene to visualize
gene_of_interest <- "1861_at"

# Filter data to only this gene
gene_data <- long_expr %>%
  filter(Gene == gene_of_interest)

head(unique(long_expr$Gene), 20) # to check different genes
names(gene_data)

#plot boxplot per gene
a<-ggplot(data=gene_data,aes(x=Condition,y=Expression,fill=Condition))
a+geom_jitter(aes(colour=Condition))+geom_boxplot(alpha=0.5)+
  xlab("Condition")+
  ylab("Expression Level")+
  ggtitle("Expression of ESR1 in Tumor vs Normal Tissue")+
  theme_minimal()+
theme(plot.title = element_text(hjust = 0.5))

gene_data <- gene_data %>%
  rename(Condition = Condition.x)

# t test and checking number of normal and tumor samples taken
t.test(Expression ~ Condition, data = gene_data)
table(gene_data$Condition)

#Violon Plot
a<-ggplot(data=gene_data,aes(x=Condition,y=Expression,fill=Condition))
a+geom_violin(trim = FALSE,alpha=0.5)+
  geom_boxplot(width=0.1,fill="white")+
  ggtitle("Violin Plot of ESR1 Expression in Tumor vs Normal Tissue") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))




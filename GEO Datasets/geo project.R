# The data has to be formatted before analysed 
# Step 1: Load the data

raw_metadata<-read.delim("GSE212787_series_matrix.txt.gz") # table is unorganised

raw_metadata <- read.delim("GSE212787_series_matrix.txt.gz", header = FALSE, stringsAsFactors = FALSE)
#header = FALSE
#Meaning: The file does not have a header row (column names) at the top.
#Effect: R will automatically assign generic column names like V1, V2, etc.
#Why this matters here:
#GEO Series Matrix files have many metadata lines starting with "!" 
#they don't follow typical tabular structure, so treating them as a data frame with headers would be incorrect.
#stringsAsFactors = FALSE
#Meaning: Treat character/text columns as character strings, not as factors.
#Effect: Prevents R from automatically converting text to a categorical variable (factor).
#read.csv does not load geo matrix dataset correctly use read.delim
# to see how some part of it looks select the loaded data from environment
# lot of data present we need only certain things, it has to be extracted

# Extract Sample IDs
sample_ids <- unlist(strsplit(raw_metadata[grep("!Sample_geo_accession",raw_metadata$V1), ], "\t"))[-1]

# Extract Sample Titles (Descriptive Labels)
sample_titles <- unlist(strsplit(metadata_raw[grep("!Sample_title", metadata_raw$V1), ], "\t"))[-1]

# Extract Disease State
disease_state <- unlist(strsplit(metadata_raw[grep("disease state", metadata_raw$V1), ], "\t"))[-1]

# Extracting Sample ID 
#parse specific lines based on pattern matching (e.g., grep("!Sample_geo_accession", raw_metadata$V1)

# Find the line containing "!Sample_geo_accession"
sample_line <- raw_metadata$V1[grep("!Sample_geo_accession", raw_metadata$V1)]

# Now split it by tab and remove the first label
sample_ids <- unlist(strsplit(sample_line, "\t"))[-1]
length(sample_ids)

sample_line <- raw_metadata$V1[grep("geo accession", raw_metadata$V1, ignore.case = TRUE)]
sample_ids <- unlist(strsplit(sample_line, "\t"))[-1]


# Extract the line containing "!Sample_title"
title_line <- raw_metadata$V1[grep("!Sample_title", raw_metadata$V1)]

# Split the line by tab, and remove the label part
sample_titles <- unlist(strsplit(title_line, "\t"))[-1] 

# Find the line containing "disease state"
disease_line <- raw_metadata$V1[grep("disease state", raw_metadata$V1)]

# Split by tab and remove the label
disease_state <- unlist(strsplit(disease_line, "\t"))[-1]



# Step 1: Load as plain text
raw_metadata <- readLines("GSE212787_series_matrix.txt.gz")

# Step 2: Extract sample IDs
sample_line <- raw_metadata[grep("!Sample_geo_accession", raw_metadata)]
sample_ids <- unlist(strsplit(sample_line, "\t"))[-1]

# Step 3: Extract titles
title_line <- raw_metadata[grep("!Sample_title", raw_metadata)]
sample_titles <- unlist(strsplit(title_line, "\t"))[-1]

# Step 4: Extract disease state
disease_line <- raw_metadata[grep("disease state", raw_metadata, ignore.case = TRUE)]
disease_state <- unlist(strsplit(disease_line, "\t"))[-1]

length(sample_ids)
length(sample_titles)
length(disease_state)

# create metadata
metadata <- data.frame(
  Sample_ID = sample_ids, 
  Title = sample_titles,
  Disease_State = disease_state,
  stringsAsFactors = FALSE
)

# Assuming you have all lines in a character vector
# Example: lines <- readLines("GSE212787_series_matrix.txt")

disease_lines <- grep("disease state", lines, value = TRUE)

# Clean up the lines to extract just the label (remove "disease state: " prefix)
disease_state <- gsub(".*disease state:\\s*", "", disease_lines)

# View result
print(disease_state)







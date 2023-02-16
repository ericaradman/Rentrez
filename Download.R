# Part 1 

# Specifying the ids being used 
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

# rentrez packages provides functions to search for, discover, and download data from the NCBI's databases useing this EUtils function
library(rentrez)

# entrez_fetch is a function to pass unique identifiers to an NCBI database and receive data files in a variety of formats
  # where: 
    # db = is the character, name of database to use
    # id = is the vector (numeric or character), unique ID(s) for records in database db
    # rettype = is the character, format, in which to get data (fasta, xml...)
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

# Looking at data 

str(Bburg)
head(Bburg)

Sequences<- strsplit(Bburg, split = "\\n")[[1]]
print(Sequences)

Sequences<-unlist(Sequences)
print(Sequences)

header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

Sequences$Sequence <- gsub("\\n", "", Sequences$Sequence)
print(Sequences)

write.csv(Sequences,"Sequences.csv")

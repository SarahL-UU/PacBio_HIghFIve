#SNP and SV comparison

install.packages("VennDiagram")

library(readr)
library(VennDiagram)

############# PLAN ##################
# 1. Generate VCF files of unique variants and variants in common. 
# 2. Count variants in each and make a Venn-diagram

########

# records private to  first.vcf.gz
cat first_second/0000.vcf | grep -v "^#" | wc -l
70529

# records private to  second.vcf.gz
cat first_second/0001.vcf | grep -v "^#" | wc -l
70017

# records from first.vcf.gz shared by both    first.vcf.gz second.vcf.gz
cat first_second/0002.vcf | grep -v "^#" | wc -l
70350

# records from second.vcf.gz shared by both   first.vcf.gz second.vcf.gz
cat first_second/0003.vcf | grep -v "^#" | wc -l
70350

#######

# 3. Plot for ex Chr1 all variants with their positions on the X axis.
# 3.5 Divide the chromosome into ex 1000 bp (might need to be bigger) blocks and make histogram with is (see notes)

###### D36117 ######### 
#Load files, load all columns as characters, not double
Unique_SR_46863 <- read_delim("~/46863.D36117.SNP.indel.PASS/0000.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 237360 Columns: 10 

Unique_LR_46863 <- read_delim("~/46863.D36117.SNP.indel.PASS/0001.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 4491656 Columns: 10 

Common_SR_46863 <- read_delim("~/46863.D36117.SNP.indel.PASS/0002.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 121363 Columns: 10  

Common_LR_46863 <- read_delim("~/46863.D36117.SNP.indel.PASS/0003.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 121363 Columns: 10 

#Combine CHROM and POS column to create a unique identifier for each variant
Unique_LR_46863$Combined <- paste(Unique_LR_46863$CHROM, Unique_LR_46863$POS, sep = ":")
Unique_SR_46863$Combined <- paste(Unique_SR_46863$CHROM, Unique_SR_46863$POS, sep = ":")
Common_SR_46863$Combined <- paste(Common_SR_46863$CHROM, Common_SR_46863$POS, sep = ":")
Common_LR_46863$Combined <- paste(Common_LR_46863$CHROM, Common_LR_46863$POS, sep = ":")

#Create a Venn diagram
set1 <- c(Unique_LR_46863$Combined, Common_SR_46863$Combined)
set2 <- c(Unique_SR_46863$Combined, Common_SR_46863$Combined)

grid.newpage()
par(mar = c(6, 6, 5, 13))
venn.plot <- venn.diagram(
  x = list(
    File1 = set1,
    File2 = set2
  ),
  category.names = c("Long-read", "Short-read"),
  fill = c("#375E97", "lightgreen"),
  alpha = 0.7,
  filename = NULL,
  cat.dist = c(0.03, 0.03),
  cex = 1
)

grid.draw(venn.plot)


##### D49374 ######
#Load files, load all columns as characters, not double
Unique_SR_D19_02017 <- read_delim("~/D19-02017.D49374.SNP.indel.PASS/0000.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 237360 Columns: 10 

Unique_LR_D19_02017 <- read_delim("~/D19-02017.D49374.SNP.indel.PASS/0001.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 4491656 Columns: 10 

Common_SR_D19_02017 <- read_delim("~/D19-02017.D49374.SNP.indel.PASS/0002.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 121363 Columns: 10  

Common_LR_D19_02017 <- read_delim("~/D19-02017.D49374.SNP.indel.PASS/0003.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 121363 Columns: 10 

#Combine CHROM and POS column to create a unique identifier for each variant
Unique_LR_D19_02017$Combined <- paste(Unique_LR_D19_02017$CHROM, Unique_LR_D19_02017$POS, sep = ":")
Unique_SR_D19_02017$Combined <- paste(Unique_SR_D19_02017$CHROM, Unique_SR_D19_02017$POS, sep = ":")
Common_SR_D19_02017$Combined <- paste(Common_SR_D19_02017$CHROM, Common_SR_D19_02017$POS, sep = ":")
Common_LR_D19_02017$Combined <- paste(Common_LR_D19_02017$CHROM, Common_LR_D19_02017$POS, sep = ":")

#Create a Venn diagram
set1 <- c(Unique_LR_D19_02017$Combined, Common_SR_D19_02017$Combined)
set2 <- c(Unique_SR_D19_02017$Combined, Common_SR_D19_02017$Combined)

grid.newpage()
par(mar = c(6, 6, 5, 13))
venn.plot <- venn.diagram(
  x = list(
    File1 = set1,
    File2 = set2
  ),
  category.names = c("Long-read", "Short-read"),
  fill = c("#375E97", "lightgreen"),
  alpha = 0.7,
  filename = NULL,
  cat.dist = c(0.03, 0.03),
  cex = 1
)

grid.draw(venn.plot)


###### D36117 SV ######### 
#Load files, load all columns as characters, not double
Unique_SR_46863 <- read_delim("~/46863.D36117.sv/0001.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 140987 Columns: 8 

Unique_LR_46863 <- read_delim("~/46863.D36117.sv/0000.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 37249 Columns: 10 

Common_SR_46863 <- read_delim("~/46863.D36117.sv/0002.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 13245 Columns: 10  

Common_LR_46863 <- read_delim("~/46863.D36117.sv/0003.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 13245 Columns: 8

#Combine CHROM and POS column to create a unique identifier for each variant
Unique_LR_46863$Combined <- paste(Unique_LR_46863$CHROM, Unique_LR_46863$POS, sep = ":")
Unique_SR_46863$Combined <- paste(Unique_SR_46863$CHROM, Unique_SR_46863$POS, sep = ":")
Common_SR_46863$Combined <- paste(Common_SR_46863$CHROM, Common_SR_46863$POS, sep = ":")
Common_LR_46863$Combined <- paste(Common_LR_46863$CHROM, Common_LR_46863$POS, sep = ":")

#Create a Venn diagram
set1 <- c(Unique_LR_46863$Combined, Common_SR_46863$Combined)
set2 <- c(Unique_SR_46863$Combined, Common_SR_46863$Combined)

grid.newpage()
par(mar = c(6, 6, 5, 13))
venn.plot <- venn.diagram(
  x = list(
    File1 = set1,
    File2 = set2
  ),
  category.names = c("Long-read", "Short-read"),
  fill = c("#375E97", "lightgreen"),
  alpha = 0.7,
  filename = NULL,
  cat.dist = c(0.03, 0.03),
  cex = 1
)

grid.draw(venn.plot)


##### D49374 SV ######
#Load files, load all columns as characters, not double
Unique_SR_D19_02017 <- read_delim("~/D19-02017.D49374.SNP.indel.PASS/0000.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 237360 Columns: 10 

Unique_LR_D19_02017 <- read_delim("~/D19-02017.D49374.SNP.indel.PASS/0001.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 4491656 Columns: 10 

Common_SR_D19_02017 <- read_delim("~/D19-02017.D49374.SNP.indel.PASS/0002.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 121363 Columns: 10  

Common_LR_D19_02017 <- read_delim("~/D19-02017.D49374.SNP.indel.PASS/0003.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 121363 Columns: 10 

#Combine CHROM and POS column to create a unique identifier for each variant
Unique_LR_D19_02017$Combined <- paste(Unique_LR_D19_02017$CHROM, Unique_LR_D19_02017$POS, sep = ":")
Unique_SR_D19_02017$Combined <- paste(Unique_SR_D19_02017$CHROM, Unique_SR_D19_02017$POS, sep = ":")
Common_SR_D19_02017$Combined <- paste(Common_SR_D19_02017$CHROM, Common_SR_D19_02017$POS, sep = ":")
Common_LR_D19_02017$Combined <- paste(Common_LR_D19_02017$CHROM, Common_LR_D19_02017$POS, sep = ":")

#Create a Venn diagram
set1 <- c(Unique_LR_D19_02017$Combined, Common_SR_D19_02017$Combined)
set2 <- c(Unique_SR_D19_02017$Combined, Common_SR_D19_02017$Combined)

grid.newpage()
par(mar = c(6, 6, 5, 13))
venn.plot <- venn.diagram(
  x = list(
    File1 = set1,
    File2 = set2
  ),
  category.names = c("Long-read", "Short-read"),
  fill = c("#375E97", "lightgreen"),
  alpha = 0.7,
  filename = NULL,
  cat.dist = c(0.03, 0.03),
  cex = 1
)

grid.draw(venn.plot)


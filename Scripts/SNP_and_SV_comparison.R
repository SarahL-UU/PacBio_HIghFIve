#SNP and SV comparison

install.packages("VennDiagram")

library(readr)
library(VennDiagram)

###### D36117 ######### 
#Load files, load all columns as characters, not double
Unique_SR_46863 <- read_delim("~/Family2.SNP.indel.PASS/0000.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 237360 Columns: 10 

Unique_LR_46863 <- read_delim("~/Family2.SNP.indel.PASS/0001.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 4491656 Columns: 10 

Common_SR_46863 <- read_delim("~/Family2.SNP.indel.PASS/0002.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 121363 Columns: 10  

Common_LR_46863 <- read_delim("~/Family2.SNP.indel.PASS/0003.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
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
Unique_SR_D19_02017 <- read_delim("~/Family1.SNP.indel.PASS/0000.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 237360 Columns: 10 

Unique_LR_D19_02017 <- read_delim("~/Family1.SNP.indel.PASS/0001.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 4491656 Columns: 10 

Common_SR_D19_02017 <- read_delim("~/Family1.SNP.indel.PASS/0002.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 121363 Columns: 10  

Common_LR_D19_02017 <- read_delim("~/Family1.SNP.indel.PASS/0003.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
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
Unique_SR_46863 <- read_delim("~/Family2.sv/0001.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 140987 Columns: 8 

Unique_LR_46863 <- read_delim("~/Family2.sv/0000.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 37249 Columns: 10 

Common_SR_46863 <- read_delim("~/Family2.sv/0002.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 13245 Columns: 10  

Common_LR_46863 <- read_delim("~/Family2.sv/0003.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
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
Unique_SR_D19_02017 <- read_delim("~/Family1.sv/0000.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 237360 Columns: 10 

Unique_LR_D19_02017 <- read_delim("~/Family1.sv/0001.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 4491656 Columns: 10 

Common_SR_D19_02017 <- read_delim("~/Family1.sv/0002.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#Rows: 121363 Columns: 10  

Common_LR_D19_02017 <- read_delim("~/Family1.sv/0003.vcf", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
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


#Load excel file with results from Hap.py
library(readxl)
Old_benchmark <- read_excel("~/Desktop/Old_benchmark.xlsx")

#Rename the column for the metrics
colnames(Happy_summary)[12] <- "Recall"
colnames(Happy_summary)[13] <- "Precision"
colnames(Happy_summary)[14] <- "F1_Score"

#Subset the data into separade SNP and INDEL dataframes
New_INDEL <- Happy_summary[c(1, 3, 5, 7, 9), c(12, 13, 15)]
colnames(New_INDEL) <- c("Recall_INDEL", "Precision_INDEL", "F1_Score_INDEL")
New_SNP <- Happy_summary[c(2, 4, 6, 8, 10), c(12, 13, 15)]
colnames(New_SNP) <- c("Recall_SNP", "Precision_SNP", "F1_Score_SNP")

New_subset <- cbind(New_SNP, New_INDEL)

#Create a barplot
New_samples <- c("HG002", "HG003", "HG004", "NA12828", "NA24385")
New_data <- Happy_summary[, c("Recall", "Precision", "F1_Score")]

par(mar = c(5, 5, 4, 11))
barplot(as.matrix(t(New_subset[,c(1, 2, 3, 4, 5, 6)])),
        beside = TRUE,
        names.arg = New_samples,
        col = c("#B85042", "#1995AD", "#FFBB00", "#A7BEAE", "#375E97", "#FB6542"),
        width = 4,
        ylim = c(0.98, 1),# Change this later to maybe 0.9, 1 eftersom det är så liten skillnad
        ylab = "Score",
        xlab = "Sample",
        main = "Barplot for all GIAB samples")

par(xpd = TRUE)
legend(x = "topright",
       legend = c("Recall_SNP", "Precision_SNP", "F1_Score_SNP", "Recall_INDEL", "Precision_INDEL", "F1_Score_INDEL" ),
       fill = c("#B85042", "#1995AD", "#FFBB00", "#A7BEAE", "#375E97", "#FB6542"),
       inset = c(-0.4, 0),
       cex = 1)

args.legend = list(x = 28, y = 1, cex = 0.8),

#Nice Hex codes: 
c("#B85042", "#E7E8D1", "#A7BEAE"),
c("#962E2A", "#E3867D", "#CEE6F2")
c("#2A3132", "#763626", "#90AFC5")
c("#1995AD", "#A1D6E2", "#375E97", "#FB6542", "#FFBB00", "#A1BE95", "#F98866")
c("#2C5F2D", "#97BC62")


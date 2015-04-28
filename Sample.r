# locale_name <- Sys.getlocale("LC_CTYPE")
# if(locale_name!="Korean_Korea.UTF-8") Sys.setlocale("LC_CTYPE", "Korean_Korea.UTF-8")
type1 <- c("Saaty")
type2 <- c("Alonso-Lamata")
source("./source_code/findRI.r")
rRI <- findRI(12, styRI=type2)

# Sys.setlocale("LC_CTYPE", locale_name)

source("./source_code/readCFG.r")
ansTYPE <- readCFG("TYP_MEAN")

a <- matrix(c(1,2,3,4), ncol=2)
source("./source_code/findMean.r")
M <- findMean(a, ansTYPE)

mData <- matrix(c(1, 2, 1/3, 1/2, 1, 1/5, 3, 5, 1), ncol=3)
colnames(mData) <- c("대안1", "대안2", "대안3")
rownames(mData) <- c("대안1", "대안2", "대안3")

srcData <- matrix(c(1, 2, 1/2, 1), ncol=2)
colnames(srcData) <- c("대안1", "대안2")
rownames(srcData) <- c("대안1", "대안2")

mSrcData <- read.csv("/Volumes/JHBae-Data/Dropbox/data.csv", header = T)
mSrcData <- mSrcData[1:205,]
mSrcData <- mSrcData[,2:7]
View(mSrcData)

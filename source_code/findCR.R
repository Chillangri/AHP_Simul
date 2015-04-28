# =====================================================================
#      This is the program to calculate value of CI and CR.
#                                           Created by Dr. Jaeho H. BAE
#                                                   Assistant Professor
#            Dept. of Logistics & Distribution Mgmt. at Hyechon College
#                                                            May, 2013.
#                                                  chillangri@gmail.com
# =====================================================================

findCR <- function(mData) {
  source("./source_code/findRI.r")
  source("./source_code/readCFG.r")
    flgRI   <- readCFG("STY_RI")
  tmpNum    <- ncol(mData)
  tmpRI     <- findRI(numAlternatives=tmpNum, styRI=flgRI)
  tmpEig    <- eigen(mData)$values
  tmpLambda <- max(as.numeric(tmpEig[Im(tmpEig)==0]), na.rm=TRUE)
  
  CI <- (tmpLambda - tmpNum)/(tmpNum - 1)
  CR <- CI / tmpRI
  rtnCICR <- c(CI, CR)
  names(rtnCICR) <- c("CI", "CR")
  return(rtnCICR)
}
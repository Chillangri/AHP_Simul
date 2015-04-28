# =====================================================================
# This is the program to calculate Pari-wise Comp. for Rect. Matrix.
#                                           Created by Dr. Jaeho H. BAE
#                                                   Assistant Professor
#            Dept. of Logistics & Distribution Mgmt. at Hyechon College
#                                                            May, 2013.
#                                                  chillangri@gmail.com
# =====================================================================

# Number of Comparision >= 3
calPWC <- function(mData){
  source("./source_code/nrmData.r")
  source("./source_code/findCR.r")
  mData <- round(mData, digits=4)
  nData <- round(nrmData(mData), digits=4)
  cnsCICR  <- round(findCR(mData), digits=4)
  lstData <- list(oriData=mData, nrmData=nData, CICR=cnsCICR)
  
  return(lstData)
}

# Number of Comparision == 2
calPWC2 <- function(mData){
  source("./source_code/nrmData.r")
  source("./source_code/findCR.r")
  mData <- round(mData, digits=4)
  nData <- round(nrmData(mData), digits=4)
  cnsCICR  <- c(0,0)
  lstData <- list(oriData=mData, nrmData=nData, CICR=cnsCICR)

  return(lstData)
}
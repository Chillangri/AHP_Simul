# =====================================================================
#     This is the program to find a result of Pairwise Comparison.
#                                           Created by Dr. Jaeho H. BAE
#                                                   Assistant Professor
#            Dept. of Logistics & Distribution Mgmt. at Hyechon College
#                                                            May, 2013.
#                                                  chillangri@gmail.com
# =====================================================================

PWCompare <- function(mData) {
  source("./source_code/calPWC.r")
  source("./source_code/calMultiPWC.r")
  
  if((ncol(mData)==nrow(mData))&&(mData[1,1]==1)) {
    if(ncol(mData)<3){
      resultPWC <- calPWC2(mData)
    } else resultPWC <- calPWC(mData)
  } else {
    if(ncol(mData)==1){
      tmpMeanMatrix <- makeMeanMatrix(mData)
      resultPWC <- calPWC2(tmpMeanMatrix)
    } else {
      mCICR <- calMultiPWC(mData)
      tmpMeanMatrix <- makeMeanMatrix(mData)
      resultPWC <- calPWC(tmpMeanMatrix)
    }
  }
}
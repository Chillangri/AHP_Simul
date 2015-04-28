# =====================================================================
# This is the program to calculate Pari-wise Comp. for Rect. Matrix.
#                                           Created by Dr. Jaeho H. BAE
#                                                   Assistant Professor
#            Dept. of Logistics & Distribution Mgmt. at Hyechon College
#                                                            May, 2013.
#                                                  chillangri@gmail.com
# =====================================================================

# Number of Comparision >= 3 form Multiple Case
calMultiPWC <- function(mSrcData) {
  source("./source_code/nrmData.r")
  source("./source_code/findCR.r")
  source("./source_code/calPWC.r")
  
  tmpNumCom <- ncol(mSrcData)
  totCases  <- nrow(mSrcData)
  numAlter  <- as.integer((1+sqrt(1+8*tmpNumCom))/2)
  loopCases <- 1:totCases
  tmpCICR     <- matrix(c(rep(0, totCases*2)), ncol=2)
  
  for(idx in loopCases) {
    smallData <- matrix(c(rep(0, numAlter*numAlter)), ncol=numAlter)
    flag = 1
    loopAlter <- 1:numAlter
    
    for(jdx in loopAlter) {
      for(kdx in loopAlter) {
        if(jdx == kdx) {
          smallData[jdx, kdx] <- 1
        } else if(jdx < kdx) {
          smallData[jdx, kdx] <- mSrcData[idx, flag]
          flag = flag+1
        } else {
          smallData[jdx, kdx] <- 1/smallData[kdx, jdx]
        }
      }
    }
    tmpCICR[idx,] <- findCR(smallData)
  }
  tmpCICR <- round(tmpCICR, 5)
  return(tmpCICR)
}


# Number of Comparision >= 3 form Multiple Case
makeMeanMatrix <- function(mSrcData) {
  source("./source_code/findMean.r")
  source("./source_code/readCFG.r")
  
  tmpNumCom <- ncol(mSrcData)
  numAlter  <- as.integer((1+sqrt(1+8*tmpNumCom))/2)
  cntNumCom <- 1:tmpNumCom
  meanMatrix <- matrix(c(rep(0, tmpNumCom)), nrow=1)
  
  for(idx in cntNumCom){
    meanMatrix[idx] <- findMean(mSrcData[,idx], typeMean=readCFG("TYP_MEAN"))
  }
  
  numAlter  <- as.integer((1+sqrt(1+8*tmpNumCom))/2)
  smallData <- matrix(c(rep(0, numAlter*numAlter)), ncol=numAlter)
  
    flag = 1
    loopAlter <- 1:numAlter
    
    for(jdx in loopAlter) {
      for(kdx in loopAlter) {
        if(jdx == kdx) {
          smallData[jdx, kdx] <- 1
        } else if(jdx < kdx) {
          smallData[jdx, kdx] <- meanMatrix[1, flag]
          flag = flag+1
        } else {
          smallData[jdx, kdx] <- 1/smallData[kdx, jdx]
        }
      }
    }
  return(smallData)
}

# Number of Comparision == 2 form Multiple Case
makeMeanMatrix2 <- function(mSrcData) {
  source("./source_code/findMean.r")
  source("./source_code/readCFG.r")
  
  mSrcData <- as.data.frame(mSrcData)
  tmpNumCom <- ncol(mSrcData)
  numAlter  <- as.integer((1+sqrt(1+8*tmpNumCom))/2)
  cntNumCom <- 1:tmpNumCom
  meanMatrix <- matrix(c(rep(0, tmpNumCom)), nrow=1)
  
  for(idx in cntNumCom){
    meanMatrix[idx] <- findMean(mSrcData[,idx], typeMean=readCFG("TYP_MEAN"))
  }
  
  numAlter  <- as.integer((1+sqrt(1+8*tmpNumCom))/2)
  smallData <- matrix(c(rep(0, numAlter*numAlter)), ncol=numAlter)
  
  flag = 1
  loopAlter <- 1:numAlter
  
  for(jdx in loopAlter) {
    for(kdx in loopAlter) {
      if(jdx == kdx) {
        smallData[jdx, kdx] <- 1
      } else if(jdx < kdx) {
        smallData[jdx, kdx] <- meanMatrix[1, flag]
        flag = flag+1
      } else {
        smallData[jdx, kdx] <- 1/smallData[kdx, jdx]
      }
    }
  }
  return(smallData)
}
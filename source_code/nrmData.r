# =====================================================================
#          This is the program to normalize a source matrix.
#                                           Created by Dr. Jaeho H. BAE
#                                                   Assistant Professor
#            Dept. of Logistics & Distribution Mgmt. at Hyechon College
#                                                            May, 2013.
#                                                  chillangri@gmail.com
# =====================================================================

nrmData <- function(srcData) {
  # Calculate Column Sums
  # tempSum <- colSums(srcData)
  
  # Make this a diagonal matrix
  # tempSum <- diag(tempSum)
  
  # Make a normalized Matrix
  # nData <- srcData %*% tempSum
  # numData <- srcData
  nData <- srcData %*% solve(diag(colSums(srcData)))
  colnames(nData) <- c(colnames(srcData))
  rownames(nData) <- c(colnames(srcData))
  return(nData)
}
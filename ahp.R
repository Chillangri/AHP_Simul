# =====================================================================
#     This is the program to find a result of AHP Analysis.
#                                           Created by Dr. Jaeho H. BAE
#                                                   Assistant Professor
#            Dept. of Logistics & Distribution Mgmt. at Hyechon College
#                                                            May, 2013.
#                                                  chillangri@gmail.com
# =====================================================================

dataLoad <- function() {
  library(XLConnect)
  source("./source_code/PWCompare.r")
  source("./source_code/funtionSet.r")
  
  dataFile <- getFileName()
  
  dataWB   <- loadWorkbook(dataFile)
  dataWS   <- getSheets(dataWB)
  
  cat("All Sheets on this file are followings:\n", dataWS)
  numSelect <- readline("Which is the Worksheet for CRITERIA Comparision? (number) ")
  numSelect <- as.integer(numSelect)
  dataCriteria <- readWorksheet(dataWB, sheet=dataWS[numSelect])
  
  numOfCriteria <- as.integer((1+sqrt(1+8*ncol(dataCriteria)))/2)
  
}

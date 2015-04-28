getFileName <- function() {
  currentWD <- getwd()
  cat("Your DATA file must be ", currentWD, "/data", "\n")
  ANS <- readline("Is it right? (Y/y or N/n): ")
  
  if ((substr(ANS, 1, 1)=="n") || (substr(ANS, 1, 1)=="N")) {
    return()
  } else {
    fileName <- readline("What is the file Name? ")
    fileName <- paste(currentWD, "/", "data/", fileName, sep="")
    return(fileName)
  }
}
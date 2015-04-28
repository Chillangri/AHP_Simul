# =====================================================================
#       This is the program to find a configuration value.
#                                           Created by Dr. Jaeho H. BAE
#                                                   Assistant Professor
#            Dept. of Logistics & Distribution Mgmt. at Hyechon College
#                                                            May, 2013.
#                                                  chillangri@gmail.com
# =====================================================================

readCFG <- function(valOpt) {
  Opt_CFG <- "./source_code/option.cfg"
  CFG <- as.data.frame(read.csv(Opt_CFG, header = TRUE, sep = ",", quote="\"", dec=".", comment.char="#"))
  
  valResult <- as.data.frame(subset(CFG, Name==valOpt, select=c(Option_Value)))
  valResult <- as.character(valResult$Option_Value)
  return(gsub(" ", "", valResult))
}
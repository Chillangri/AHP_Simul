# =====================================================================
#       This is the program to find a value of Randomized RI.
#                                           Created by Dr. Jaeho H. BAE
#                                                   Assistant Professor
#            Dept. of Logistics & Distribution Mgmt. at Hyechon College
#                                                            May, 2013.
#                                                  chillangri@gmail.com
# =====================================================================

findRI <- function(numAlternatives, ..., styRI){
	if (missing(styRI)) styRI <- "Alonso-Lamata"

    if(styRI == "Saaty") { 
        # Original RI values by Satty
        rRI <- c(0, 0, 0.58, 0.90, 1.12, 1.24, 1.32, 1.41, 1.45, 1.49, 1.51, 1.54, 1.56, 1.57, 1.59)
    } else {
        # Alonso-Lamata RI values (100,000 matrices)
        rRI <- c(0, 0, 0.5245, 0.8815, 1.1086, 1.2479, 1.3417, 1.4056, 1.4499, 1.4854, 1.5141, 1.5365, 1.5551, 1.5713, 1.5838)
    }

    if(numAlternatives > length(rRI)) {
    	return(NaN)
    } else {
    	return(rRI[numAlternatives])
    }
}
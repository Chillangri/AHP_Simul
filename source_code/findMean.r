# =====================================================================
#       This is the program to find a various type of mean.
#                                           Created by Dr. Jaeho H. BAE
#                                                   Assistant Professor
#            Dept. of Logistics & Distribution Mgmt. at Hyechon College
#                                                            May, 2013.
#                                                  chillangri@gmail.com
# =====================================================================


findMean <- function(vecData, typeMean){
	if (is.numeric(vecData)) {
		# Vectorize for all input matrix and vector
		vecData <- c(vecData)
	} else {
		return(NaN)
		break
	}

	if (typeMean=="A" || typeMean=="a") {
		# Compute the Arithmetic Mean
		valMean <- mean(vecData)
	} else if (typeMean=="H" || typeMean=="h") {
		# Compute the Harmonic Mean
		valMean <- 1/mean(1/vecData)
	} else {
		# Compute the Geometric Mean
		valMean <- prod(vecData)^(1/length(vecData))
	}
	return(valMean)
}
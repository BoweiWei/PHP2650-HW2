## A template for submitting your homework

## include libraries available from  CRAN only
require(ggplot2) == T || install.packages("ggplot2", repos="https://cloud.r-project.org/")


##  Do not source any other files, because only one file is allowed

## Include the names of all team members
authors <- function() {
    c("Zhicong Chu", "Bowei Wei")
}

## Question 1
## find files
files <- dir(pattern="sub.+\\.txt$")

## Create the function for Fisher's Z transform
Fcal <- function(anum) {
  return(log((1+anum)/(1-anum))/2)
}


re <- NULL
re.matrix <- NULL
for (i in seq_along(files)) {
  f <- files[i]
  d <- read.csv(f, header=F, sep = " ")
##  calculate matrix
  cor.m <- cor(d)
  re[[i]]<- matrix(mapply(Fcal, cor.m), c(15,15))
  re[[i]][is.infinite(re[[i]])] = 1
  }


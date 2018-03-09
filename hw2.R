## A template for submitting your homework
library(stringr)
## include libraries available from  CRAN only
require(ggplot2) == T || install.packages("ggplot2", repos="https://cloud.r-project.org/")


##  Do not source any other files, because only one file is allowed

## Include the names of all team members
authors <- function() {
    c("Zhicong Chu", "Jiarou Quan", "Bowei Wei")
}

## Question 1
## find files
files <- dir(pattern="sub.+\\.txt$")

## Create the function for Fisher's Z transform
Fcal <- function(anum) {
  return(log((1+anum)/(1-anum))/2)
}


re <- list(NULL)


for (i in seq_along(files)) {
  f <- files[i]
  d <- read.csv(f, sep = " ")
##  calculate matrix
  cor.m <- cor(d)
  re[[i]] <- matrix(mapply(Fcal, cor.m), c(15,15))
  re[[i]][is.infinite(re[[i]])] = 1
}

f <- files[1]
d <- read.csv(f, header = F, sep = " ")
m <- cor(d)
a <- matrix(mapply(Fcal, m), c(15,15))
a[is.infinite(a)] = 1
seq_along(files)

## Question 2
## mean calculation
fn <- list(NULL)
for (i in seq_along(files)) {
  f <- files[i]
  d <- read.csv(f, sep = " ")
  ##  calculate matrix
  fn[[i]] <- mapply(mean, d)
}
fn <- data.frame(fn)
write.csv(fn, "fn.csv")

## variance calculation
fv <- list(NULL)
for (i in seq_along(files)) {
  f <- files[i]
  d <- read.csv(f, sep = " ")
  ##  calculate matrix
  fv[[i]] <- mapply(mean, d)
}
fv <- data.frame(fv)
write.csv(fv, "fv.csv")


## Question 3
files <- data.frame(files)
files$num <- str_extract(files$files, "[[:digit:]]+")
files <- files[order(files$num, decreasing = FALSE), ]

Ftrainlist <- files$files[1:410]
a <- list(NULL)
for (i in length(Ftrainlist)) {
  f <- files[i]
  d <- read.csv(f, sep = " ")
  ##  calculate matrix
  a[[i]] <- mapply(mean, d)
}
a <- data.frame(a)
write.csv(a, "Ftrain.csv")

Ftestlist <- files$files[411:820]
b <- list(NULL)
for (i in length(Ftestlist)) {
  f <- files[i]
  d <- read.csv(f, sep = " ")
  ##  calculate matrix
  b[[i]] <- mapply(mean, d)
}
b <- data.frame(b)
write.csv(a, "Ftest.csv")



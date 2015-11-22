dat <- read.csv(file = "~/work/Teradata Hackathon/refugees_by_country_and_year.csv", header = TRUE, sep = ",")
dat2 <- read.csv(file = "~/work/Teradata Hackathon/terrorist_attacks_per_country_1992-2010.csv", header = TRUE, sep = ",")


# transpose dat
# first remember the names
n <- dat$Country.Name

# transpose all but the first column (name)
dat <- as.data.frame(t(dat[,-1]))
colnames(dat) <- n
dat$myfactor <- factor(row.names(dat))

# transpose dat2
# first remember the names
n2 <- dat2$Country.Name

# transpose all but the first column (name)
dat2 <- as.data.frame(t(dat2[,-1]))
colnames(dat2) <- n2
dat2$myfactor <- factor(row.names(dat2))
#}

# making the NA's 0
dat[is.na(dat)] <- 0
dat2[is.na(dat2)] <- 0

countries = "default"
correlations = 0
i = 1
j = 1

while (i <= dim(dat)[2] && j <= dim(dat2)[2])
{
  if (colnames(dat[i]) < colnames(dat2[j])) { 
    i = i+1
  } else if (colnames(dat[i]) > colnames(dat2[j])) {
    j = j+1
  } else if (colnames(dat[i]) == colnames(dat2[j])) {
    countries = c(countries, colnames(dat[i]))
    tempcor = cor(dat[[i]], dat2[[j]])
    correlations = c(correlations, tempcor)
    print (colnames(dat[i]))
    print (tempcor)
    i = i+1
    j = j+1
  }
}

data.frame(Correlation = correlations)
x = data.frame(Correlation = correlations)
rownames(x) = countries[1:156]
length(countries)
length(correlations)


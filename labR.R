install.packages("distributionsrd")
library(distributionsrd)
# Показательное распределение
exp<-rexp(10000,21)
exp1000<-exp[1:1000]
exp100<-exp[1:100]
plot(density(exp), col = "blue",main = "Density plot")
curve(dexp(x,21), xlim = c(0, 0.5),add =T, col = "red")
plot(density(exp1000), col = "blue",main = "Density plot")
curve(dexp(x,21), xlim = c(0, 0.5),add =T, col = "red")
plot(density(exp100), col = "blue",main = "Density plot")
curve(dexp(x,21), xlim = c(0, 0.5),add =T, col = "red")

# Нормальное распределение
norm<-rnorm(10000,21,1)
norm1000<-norm[1:1000]
norm100<-norm[1:100]
plot(density(norm), col = "blue",main = "Density plot")
curve(dnorm(x,21,1), xlim = c(18, 24),add =T, col = "red")
plot(density(norm1000), col = "blue",main = "Density plot")
curve(dnorm(x,21,1), xlim = c(18, 24),add =T, col = "red")
plot(density(norm100), col = "blue",main = "Density plot")
curve(dnorm(x,21,1), xlim = c(18, 24),add =T, col = "red")


samples_avgs <- rep(NA, 10000)

for (n in 1:10000){
  samples_avgs[n] <- mean(sample(norm, n))
}

plot(samples_avgs, type = 'l', xlab = "размер выборки", ylab = "выборочные средние",
     xlim = c(0, 10000))

abline(h = 21, col = "red", lwd = 2, lty = 2)

sample_means_un <- rep(NA, 1000)

for (i in 1:1000){
  sample_means_un[i] <- mean(sample(norm, 10))
}

hist(sample_means_un, breaks = 20, col = "tomato", freq = FALSE, 
     main ="Распределение выборочных средних",
     xlab = "средние значения по выборкам" ,
     ylab = "плотность", ylim = c(0, 5))

curve(dnorm(x, mean = mean(sample_means_un), sd = sd(sample_means_un)), 
      add = TRUE, col = "navy", lwd = 2)

hist(sample_means_un,col = "red",border = "black")
ks.test(sample_means_un, "pnorm", mean=21, sd=sd(sample_means_un) )

# Распределение Парето
U<-runif(10000, min = 0, max = 1)
par <- rep(NA, 10000)
for (i in 1:10000){
  par[i] <- 1/(1-U[i])^(1/23)}
par1000<-par[1:1000]
par100<-par[1:100]

plot(density(par), col = "blue",main = "Density plot",xlab="N=10000")
curve(dpareto(x, k = 23, xmin = 1, log = FALSE, na.rm = FALSE), xlim = c(0, 1.4),add =T, col = "red")
plot(density(par1000), col = "blue",main = "Density plot",xlab="N=1000")
curve(dpareto(x, k = 23, xmin = 1, log = FALSE, na.rm = FALSE), xlim = c(0, 1.4),add =T, col = "red")
plot(density(par100), col = "blue",main = "Density plot",xlab="N=100")
curve(dpareto(x, k = 23, xmin = 1, log = FALSE, na.rm = FALSE), xlim = c(0, 1.4),add =T, col = "red")

rm(list=ls())
setwd("C:/R_labs/simulation modeling/")

library("rgl")
N <- 3
n <- 100
R = 1 # Радиус шара
center = sample(1:5, 3, replace=T) # Центр шара генерируем произвольный
center_hemisphere = c(0,0,0)
gamma = sample(1:5, 1)
sum_V = 0
# В пространстве расположен шар 𝑀 с центром в точке (𝑥0, 𝑦0, 𝑧0) и радиусом 𝑅.
# Требуется с помощью методов Монте-Карло вычислить интеграл
# При расчетах воспользоваться методом существенной выборки, взяв в качестве
# вспомогательное распределение
# Сравнить результаты со стандартным методом Монте-Карло
# (генерация равномерно распределенных точек на полусфере) 
# в терминах дисперсии оценок.

diskrim <- function(a, b, c) {
  d <- b * b - 4 * a * c
  # пересекает шар
  if (d > 0) {
    V=1
  }
  # не пересекает шар
  else{
    V=0
  }
  return(V)
}

#Генерация метода Монте-Карло
generate_MonteCarlo = function(n) { 
  points = list()
  for (i in 1:n){
    U <-runif(1)
    #угол между вектором направления w и осью z
    #для сферы умножается U на 2
    theta <- acos(1-U) 
    phi <- runif(1,0,2*pi) #угол между вектором направления w и осью х
    X <- R*sin(theta) * cos(phi)
    Y <- R*sin(theta) * sin(phi)
    Z <- R*cos(theta)
    points[[i]] = c(X,Y,Z)
    #print(points)
    #запишем все получившиеся координаты n точек в один вектор
    #point = unlist(points)
    #print("point") 
    #print(point)
  }
  return (points)
}

# Проверка на пересечение с шаром
calc_s = function(generated_points){
  for (i in 1:n){
    a = sum(generated_points[[i]]^2) 
    b = -2*(generated_points[[i]][1]*center[1]+generated_points[[i]][2]*center[2]+generated_points[[i]][3]*center[3])
    c = sum(center^2)-R^2
    #V - так называемая функция видимости,
    #если прямая  направляющим вектором w  пересекает шар, то 1, иначе 0
    V = diskrim(a,b,c)
    #print("V")
    #print(V)
    if (V == 1){
      sum_V <- sum_V + 1
    }
  }
  #print(sum_V)
  return (2 * pi / ((gamma+1)*n) * sum_V)
}

#Генерация метода существенной выборки 
generate_ImpSampling = function(n){
  points = list()
  for (i in 1:n){
    U <-runif(1)
    #угол между вектором направления w и осью z
    #для сферы умножается U на 2
    theta = acos((1 - runif(1)^(1/(gamma+1))))  
    phi = runif(1, 0, pi/2) #угол между вектором направления w и осью х
    X <- R*sin(theta) * cos(phi)
    Y <- R*sin(theta) * sin(phi)
    Z <- R*cos(theta)
    points[[i]] = c(X,Y,Z)
  }
  return (points)
}

s1 = c(rep(0,N))
s2 = c(rep(0,N))

for(i in 1:N) {
  # Генерация n координат точек методом М-К
  points_MonteCarlo = generate_MonteCarlo(n) 
  for (i in 1:length(points_MonteCarlo)){
    points3d(points_MonteCarlo[[i]],col="red")
  }
  # Расчет оценок М-К
  sum_V <- 0
  s1 <- c(s1, calc_s(points_MonteCarlo))
  s1
  
  # Генерация n координат точек методом существенной выборки 
  points_ImpSamplingb = generate_ImpSampling(n)
  for (i in 1:length(points_MonteCarlo)){
    points3d(points_ImpSamplingb[[i]],col="red")
  }
  sum_V <- 0
  s2 <- c(s2, calc_s(points_ImpSamplingb)) # Расчет оценок
  s2
}

cat(mean(s1), "\n")
cat(mean(s2), "\n")
cat(var(s1), "\n")
cat(var(s2), "\n")

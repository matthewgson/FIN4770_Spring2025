stock_price <- 130
if (stock_price > 120) {
  print("The stock price has surged!")
} else if (stock_price > 110) {
  print("The stock price has increased moderately.")
}

PMT <- 750
if (PMT > 1000) {
  PMT <- PMT + 10000
} else if (PMT > 500) {
  PMT <- PMT + 100
} else {
  PMT <- 0
}

x <- c("a", "b", "c", "d")
x[1]
x[2]
x[3]
x[4]

seq_along(x)

for (q in seq_along(x)) {
  print(q)
}

for (q in x) {
  print(q)
}

i <- 3
i == 4
for (i in 1:5) {
  if (i == 4) {
    break
  }
  print(i)
}

principal <- 10000
interest_rate <- 0.05
N <- 10

output <- vector("double", length = N)

for (n in 1:N) {
  output[[n]] <- principal * (1 + interest_rate)^n
}
print(output)

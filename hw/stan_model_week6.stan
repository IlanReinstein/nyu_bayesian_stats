
data {
  int<lower = 0> N; //number of observations
  int<lower = 0> K; // number of predictors
  
  matrix[N, K] X; //design matrix of predictors
  int<lower = 0, upper = 1> y[N]; //outcomes
  
  vector[K] loc;
  vector<lower = 0>[K] scal;
}

parameters {
  vector[K] beta;
}

model {
  vector[N] eta = X * beta; // linear algebra way
  
  target += normal_lpdf(beta | loc, scal)
  target += bernoulli_lpmf(y | Phi(eta));
}


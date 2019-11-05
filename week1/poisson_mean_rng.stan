functions{
  real poisson_mean_rng(int N, real mu){
    real S = 0;
    if(N < 0) reject("N must be non-negative");
    if (mu <= 0) reject("mu must be non-negative");
    for(i in 1:N){
      int y = poisson_rng(mu);
      S += y;
    }
    return S/N;
  }
}

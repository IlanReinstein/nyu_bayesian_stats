functions {
  matrix topcoded_PPD_rng(int S, vector x, real top) {
    int N = rows(x); matrix[S, N] draws;
    vector[N] x_ = x - mean(x); // centered
    for (s in 1:S) {
      // draw from a prior on the intercept
      real alpha = normal_rng(0,100);
      // draw from a prior on the slope
      real beta = normal_rng(0, 10);
      // draw from a prior on the error standard deviation
      real sigma = exponential_rng(1)*2;
      // construct the conditional mean vector
      vector[N] mu = alpha + beta*x_;
      for (n in 1:N) {
        // draw an error from a normal distribution
        real epsilon = normal_rng(0, sigma);
        // add the error to the n-th conditional mean
        real y = mu[n] + epsilon;
        // if the sum is less than top, but it in draws[s, n]
        draws[s,n] = y > top ? top : y;
        // if it is greater than top, put top in draws[s, n]
      }
    }
    return draws;
  }  
}


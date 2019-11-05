functions { /* censored_PPD_rng.stan */
  matrix censored_PPD_rng(int S, vector loc, 
                          vector scale, 
                          vector x, real end) {
    int N = rows(x); matrix[S, N] out;
    vector[N] x_ = x - mean(x);
    for (s in 1:S) {
      real alpha = cauchy_rng(loc[1], scale[1]);
      real beta = cauchy_rng(loc[2], scale[2]);
      real sigma = exponential_rng(1 / loc[3]);
      vector[N] eta = alpha + beta * x_;
      for (n in 1:N) {
        real t = exp(normal_rng(eta[n], sigma));
        out[s, n] = t < end ? t : end;
      }
    }
    return out;
  }
}

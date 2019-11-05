functions { /* saved as kernel.stan in R's working directory */
  vector kernel(vector mu, real M, real Emu, int[] y) {
    real b = 1 / (Emu - M);
    real a = Emu * b;
    int K = rows(mu);
    vector[K] log_mu = log(mu);
    vector[K] log_prior =     (a - 1) * log_mu - mu * b;       // omits normalizing constant
    vector[K] log_likelihood = sum(y) * log_mu - mu * size(y); // omits sum of log-factorials
    if (a < 1 || b < 0) reject("M and Emu are inconsistent");
    return exp(log_prior + log_likelihood);
  }
}

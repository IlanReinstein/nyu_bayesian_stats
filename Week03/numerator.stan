functions { /* saved as numerator.stan in R's working directory */
  vector numerator(vector pi, real M, real m, int N, int y) {
    real common = 3 * (M - m);
    real a = (m * (4 * M - 3) + M) / common;
    real b = (m * (1 - 4 * M) + 5 * M - 2) / common;
    int K = rows(pi); vector[K] log_pi = log(pi);
    vector[K] log1m_pi = log1m(pi); // log1m(x) == log(1 - x) but numerically accurate
    vector[K] log_prior = (a - 1) * log_pi + (b - 1) * log1m_pi - lbeta(a, b);   // l prefix
    vector[K] log_likelihood =  y * log_pi + (N - y) * log1m_pi + lchoose(N, y); // means log
    return exp(log_prior + log_likelihood); // equals exp(log_prior) * exp(log_likelihood)
  }
}

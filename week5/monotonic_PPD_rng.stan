functions { /* monotonic_PPD_rng.stan */
  matrix monotonic_PPD_rng(int S, 
    real m, vector a, int[] x) {
      int N = num_elements(x); 
      int J = rows(a); matrix[S, N] draws;
      for (s in 1:S) {
        vector[J] theta = dirichlet_rng(a);
        real gamma = exponential_rng(1) * m;
        vector[J] beta = gamma * 
                         cumulative_sum(theta);
        real alpha = normal_rng(0, 3);
        for (n in 1:N) {
          real eta = alpha + beta[x[n]];
          real u = eta + logistic_rng(0, 1);
          draws[s, n] = u > 0;
        }
      }
      return draws;
  }
}

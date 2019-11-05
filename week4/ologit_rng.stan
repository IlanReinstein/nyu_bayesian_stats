functions { /* saved as ologit_rng.stan */
  matrix ologit_rng(int S, int J, real a, 
                    real loc, real scale, 
                    vector x) {
    int N = rows(x); matrix[S, N] out;
    vector[J] a_vec = rep_vector(a, J);
    for (s in 1:S) {
      vector[J] cutpoints = logit(
        cumulative_sum(dirichlet_rng(a_vec)));
      real beta = normal_rng(loc, scale);
      vector[N] eta = beta * x;
      for (n in 1:N) {
        real u = eta[n] + logistic_rng(0, 1);
        int y = 1;
        while (u > cutpoints[y]) y += 1;
        out[s, n] = y;
      }
    }
    return out;
  }
}

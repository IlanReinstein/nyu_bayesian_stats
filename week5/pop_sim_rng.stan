functions { /* saved as pop_sim_rng.stan */
  row_vector binormal_rng(real mu_X, real mu_Y, real sigma_X, real sigma_Y, real rho) {
    real beta = rho * sigma_Y / sigma_X;
    real sigma = sigma_Y * sqrt(1 - square(rho));
    real x = normal_rng(mu_X, sigma_X);
    real y = normal_rng(mu_Y + beta * (x - mu_X), sigma);
    return [x, y];
  }
  matrix pop_sim_rng(int N) { // only draws once
    matrix[N, 2] draws;
    real a = normal_rng(3.5, 1.0 / 3);
    real b = normal_rng(-1, 0.1);
    real sigma_a = fabs(normal_rng(1, 0.1));
    real sigma_b = fabs(normal_rng(0.5, 0.1));
    real rho = uniform_rng(-1, 0);
    for (n in 1:N)
      draws[n, ] = binormal_rng(a, b, sigma_a, sigma_b, rho);
    return draws;
  }
  
  matrix PPD_rng(int S, int N, int[] time, real rate) {
    matrix[S, N] y_tilde;
    for (s in 1:S) {
      matrix[N, 2] params = pop_sim_rng(N);
      real sigma = exponential_rng(rate);
      for (n in 1:N) {
        real mu = params[n, 1] + params[n, 2] * time[n];
        y_tilde[s, n] = normal_rng(mu, sigma);
      }
    }
    return y_tilde;
  }
} // end functions block

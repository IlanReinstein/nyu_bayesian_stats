functions { /* saved as binormal_rng.stan in R's working directory */
  matrix binormal_rng(int S, real mu_X, real mu_Y, real sigma_X, real sigma_Y, real rho) {
    matrix[S, 2] draws; 
    real beta = rho * sigma_Y / sigma_X;          // calculate such constants once ...
    real sigma = sigma_Y * sqrt(1 - square(rho)); // ... before the loop begins
    for (s in 1:S) {
      real x = normal_rng(mu_X, sigma_X);
      real y = normal_rng(mu_Y + beta * (x - mu_X), sigma);
      draws[s, 1] = x; draws[s, 2] = y;
    }
    return draws;
  }
}

functions { /* monotonic_kernel.stan */
  real monotonic_kernel(real alpha, 
    vector theta, real gamma,
    real m, vector a, int[] x, int[] y) {
      // return the log-kernel
      int N = num_elements(x);
      int J = rows(a);
      real p_alpha = normal_lpdf(alpha | 0, 3);
      real p_gamma = exponential_lpdf(gamma | 1/m);
      real p_theta = dirichlet_lpdf(theta | a); // multilvariate distribution over simplex
      
      vector[J] beta = gamma * cumulative_sum(theta);
      vector[N] eta = alpha + beta[x];
      
      
      real log_likelihood = bernoulli_logit_lpmf(y | eta);
      return p_alpha + p_gamma + p_theta + log_likelihood;
  }
}

functions {
  vector conditional_rng(int S, real a, real b, int[] y){
    int sum_y = sum(y);
    vector[S] post;
    int s = 1;
    if (a <= 0 || b <= 0) reject("a and b must be positive");
    while (s <= S) {
      real mu_tilde = gamma_rng(a, b);
      int y_tilde[size(y)]; // prior predictive distribution
      for (n in 1:size(y)) y_tilde[n] = poisson_rng(mu_tilde);
      if (sum_y == sum(y_tilde)){
        post[s] = mu_tilde;
        s += 1;
      }
    }
    return sort_asc(post);
  }
}

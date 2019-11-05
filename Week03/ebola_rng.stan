functions { /* saved as ebola_rng.stan in R's working directory */
  vector ebola_rng(int S, real M, real m, int N, int y) { // must have a _rng suffix
    real common = 3 * (M - m);
    real a = (m * (4 * M - 3) + M) / common;
    real b = (m * (1 - 4 * M) + 5 * M - 2) / common;
    vector[S] post; // size equal to number of simulations
    int s = 1;
    if (a < 1 || b < 1) reject("M and m are inconsistent");
    while (s <= S) {
      real pi_tilde = beta_rng(a, b);          // draw from prior distribution
      int y_tilde = binomial_rng(N, pi_tilde); // draw from prior predictive distribution
      if (y_tilde == y) {                      // keep iff matches observed data
        post[s] = pi_tilde;                    // indexing (mostly) works like in R
        s += 1;                                // s += 1; is equivalent to s = s + 1;
      }
    }
    return sort_asc(post);                     // easier to plot CDF if sorted ascending
  }
}

functions { /* saved as residences_rng in R's working directory */
  vector residences_rng(int S, real M, real Emu, int[] y) { // y is a 1D integer array
    real b = 1 / (Emu - M); real a = Emu * b;
    int sum_y = sum(y); // must declare everything, such as ...
    vector[S] post;
    int s = 1;
    if (a < 1 || b < 0) reject("M and Emu are inconsistent"); // before evaluating anything
    while (s <= S) {
      real mu_tilde = gamma_rng(a, b); // but get to make new declarations after any opening {
      int y_tilde[size(y)]; // holds prior predictive distribution for entire sample
      for (n in 1:size(y)) y_tilde[n] = poisson_rng(mu_tilde);
      if (sum_y == sum(y_tilde)) {
        post[s] = mu_tilde;
        s += 1;
      }
    }
    return sort_asc(post);
  }
}

functions { /* saved as AR1_rng.stan in R's working directory */
  vector AR1_rng(int S, int T, real mu, real rho, real sigma) {
    vector[S] rho_hat;  // holds OLS estimates of rho 
    real alpha = mu * (1 - rho); int Tm1 = T - 1;
    if (sigma <= 0) reject("sigma must be positive");
    if (rho < -1 || rho > 1) reject("rho must be between -1 and 1");
    for (s in 1:S) { // repeatedly simulate data under an AR1 process ...
      vector[T] Y; Y[1] = 0;                                              // outcome at time 1
      for (t in 2:T) Y[t] = alpha + rho * Y[t - 1] + normal_rng(0, sigma);// outcome at time t
      { // ... and apply some function to that simulated data
        vector[Tm1] y_lag  = Y[1:Tm1]; vector[Tm1] y_temp = Y[2:T];
        rho_hat[s] = sum(y_temp .* y_lag) / sum(square(y_lag)); // .* multiplies elementwise 
      }
    }
    return sort_asc(rho_hat);
  }
}

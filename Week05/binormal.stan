functions {
  real binormal_lpdf(row_vector xy, real mu_X, real mu_Y, real sigma_X, real sigma_Y, real rho) {
    real beta = rho * sigma_Y / sigma_X; 
    real sigma = sigma_Y * sqrt(1 - square(rho));
    return normal_lpdf(xy[1] | mu_X, sigma_X) + 
           normal_lpdf(xy[2] | mu_Y + beta * (xy[1] - mu_X), sigma);
  }
}
parameters {
  real x;
  real y;
}
model {
  target += binormal_lpdf([x, y] | 0, 0, 1, 1, 0.75);
}

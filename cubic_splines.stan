functions {
  vector cube_pos(vector u) {
    vector[rows(u)] out;
    for (n in 1:rows(u)) out[n] = u[n] > 0 ? u[n] : 0;
    out .*= square(out); // ^^^ is like ifelse() in R
    return out;
  }

  matrix rcs(vector V, vector k) {
    int N = rows(V);
    int n = rows(k);
    matrix[N, n - 1] out;
    real denom = square(k[n] - k[1]);
    real kn_knm1 = k[n] - k[n - 1];
    out[ , 1] = V;
    /* finish the rest with a loop that calls cube_pos() */
    for (i in 1:n-2){
      out[, i + 1] = (cube_pos(V - k[i]) - (cube_pos(V - k[n-1])*(k[n] - k[i]) - 
                      cube_pos(V - k[n]) * (k[n - 1] - k[i])) / kn_knm1) / denom;
    }
    return out;
  }
}

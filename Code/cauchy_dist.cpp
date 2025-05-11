
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector dist_cauchy(int n, int num_samples){
  
  NumericVector means(num_samples);
  
  for (int i = 0; i < num_samples; i++){
    
    NumericVector sample = rcauchy(n);
    double sum = 0;
    
    for (int j = 0; j < n; j++){
      sum = sum + sample[j];
    }
    means[i] = sum / n;
  }
  return means;
}
















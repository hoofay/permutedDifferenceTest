
#' filename: permuted_differences.R
#' function to perform a permuted difference test on two datasets
#'
#' @param a control dataset. vector of numerical values. 
#' @param b test dataset. vector of numerical values.
#' @param alpha confidence. numerical value; default at 0.05
#'
#' @return list:
#' pvalue = the fraction of how many times the permuted difference is equal or more extreme than the observed difference.
#' a pvalue of 0.04 means that the permuted dataset was only more extreme than b from a on 0.04 occasions
#' permuted mean = mean of differences between the purmuted datasets.
#' result = significance test result.
#' basedata = control dataset.
#' testdata = test dataset.
#' alpha = alpha.
#' @export
#'
#' @examples 
#' permutedDiffTest(rnorm(50, mean = 0, sd = 1),rnorm(50, mean = 0.5, sd = 2),0.05) 
#' permutedDiffTest(0.5,rnorm(50, mean = 0.75, sd = 0.2),0.05)
#' 
permutedDiffTest <- function(a,b,alpha=0.05){
  
  # combine the two datasets into a single dataset
  # i.e., under the null hypothesis, there is no difference between the two groups
  combined <- c(a,b)

  # observed difference
  diff_observed <- mean(b) - mean(a)

  number_of_permutations <- 1000

  diff_random <- NULL
  for (i in 1 : number_of_permutations) {
  
    # sample from the combined dataset without replacement
    shuffled <- sample (combined, length(combined))
  
    a_random <- shuffled[1 : length(a)]
    b_random <- shuffled[(length(a) + 1) : length(combined)]
  
    # null (permuted) difference
    diff_random[i] <- mean(b_random) - mean(a_random)
  }

  pvalue = sum(abs(diff_random) >= abs(diff_observed)) / number_of_permutations

  # p-value = (two-tailed) 
  pvalue

  # mean of differences between means of permuted datasets = 
  mean(diff_random)

  testResult <- if(pvalue < alpha){'Reject Null'}else{'Accept Null'}

  # provide results
  out <- list('pvalue'=pvalue,'permutedmean'=mean(diff_random),
              'result'=testResult,'basedata'=a,'testdata'=b,'alpha'=alpha)

  return(out)
}


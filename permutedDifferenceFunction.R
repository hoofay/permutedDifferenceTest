# filename: permutedDifferenceFunction.R
# author: Daniel Hough
# date: 2017-10-06

permutedDiffTest <- function(a,b,alpha=0.05){
  ### function to perform a permuted difference test on two datasets ###
  
  # Combine the two datasets into a single dataset
  # i.e., under the null hypothesis, there is no difference between the two groups
  combined <- c(a,b)

  # Observed difference
  diff_observed <- mean(b) - mean(a)

  number_of_permutations <- 1000

  diff_random <- NULL
  for (i in 1 : number_of_permutations) {
  
    # Sample from the combined dataset without replacement
    shuffled <- sample (combined, length(combined))
  
    a_random <- shuffled[1 : length(a)]
    b_random <- shuffled[(length(a) + 1) : length(combined)]
  
    # Null (permuated) difference
    diff_random[i] <- mean(b_random) - mean(a_random)
  }

  # p-value is the fraction of how many times the permuted difference is equal or more extreme than the observed difference
  # p-value = 0.04 means that the permuted dataset was only more extreme than b from a on 0.04 occasions
  # we would reject null if alpha = 0.05 or accept null if alpha = 0.025.
  pvalue = sum(abs(diff_random) >= abs(diff_observed)) / number_of_permutations

  # p-value = (two-tailed) 
  pvalue

  #Mean of differences between means of permuted datasets = 
  mean(diff_random)

  testResult <- if(pvalue < alpha){'Reject Null'}else{'Accept Null'}

  # provide results
  out <- list('pvalue'=pvalue,'permutedmean'=mean(diff_random),
              'result'=testResult,'basedata'=a,'testdata'=b,'alpha'=alpha)

  return(out)
}

permutedDiffTest(rnorm(50, mean = 0, sd = 1),rnorm(50, mean = 0.5, sd = 2),0.05)

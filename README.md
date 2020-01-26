# permutedDifferenceTest
A function to perform a permuted difference test on two numeric vectors

Three arguments:
a = dataset 1 (vector, numerics)
b = dataset 2 (vector, numerics)
alpha = test statistic (0.05 by default)

outputs:

'pvalue'= pvalue 'p-value is the fraction of how many times the permuted difference is equal or more extreme than the observed difference'.
'permutedmean'= Mean of differences between means of permuted datasets.
'result'= the result of the hypothesis test 'under the null hypothesis, there is no difference between the two groups'.
'basedata'= dataset 1
'testdata'= dataset 2
'alpha'= test statistic


#
# usage: rscript generate.r
#

source('utils.r');

lambda = seq(0.1, 10, 0.1);
N = length(lambda);

likelihood = poisson(2, lambda);
priors = rep(1/N, times=N);
posterior = bayes(likelihood, priors);

plot(lambda, posterior, type="o", xlab="lambda", ylab="P(lambda|X=2)");


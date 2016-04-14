
poisson = function(x, lambda)
{
	# Only do it this way for very small values of x
	return (  ( exp(-lambda) * (lambda ^ 2) ) / factorial(x)  ); 
};

bayes = function(likelihoods, priors)
{
	lp = likelihoods * priors;
	evidence = sum(lp);
	return( lp/evidence );
};

lambda = seq(0.1, 20, 0.1);
N = length(lambda);

likelihood = poisson(2, lambda);
priors = rep(1/N, times=N);
posterior = bayes(likelihood, priors);

plot(lambda, posterior, type="o", xlab="lambda", ylab="P(lambda|X=2)");

p = function(t)
{
	possibities = exp(-lambda*t);
	return(sum(possibities*posterior));
};

cat( paste('p(1.72)=', p(1.72), '\n'));


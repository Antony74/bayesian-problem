
poisson = function(x, lambda)
{
	# Only do it this way for very small values of x
	( exp(-lambda) * (lambda ^ 2) ) / factorial(x); 
};

bayes = function(likelihoods, priors)
{
	lp = likelihoods * priors;
	evidence = sum(lp);
	lp/evidence;
};


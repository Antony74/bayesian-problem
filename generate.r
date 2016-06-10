
poisson = function(x, lambda)
{
	# Only do it this way for very small values of x
	return (  ( exp(-lambda) * (lambda ^ x) ) / factorial(x)  ); 
};

bayes = function(likelihood, prior)
{
	lp = likelihood * prior;
	evidence = sum(lp);
	return( lp/evidence );
};

lambda = seq(0.1, 20, 0.1);
N = length(lambda);

likelihood = poisson(2, lambda);
prior = rep(1/N, times=N);
posterior = bayes(likelihood, prior);

p = function(t)
{
	possibities = exp(-lambda*t);
	return(sum(possibities*posterior));
};

cat( paste('p(1.72)=', p(1.72), '\n'));

#
# Calculation complete, let's graph it
#

par(mfrow=c(4,1)); # four rows and one column of graphs
xlab = expression(lambda);

ylab = expression(paste("P(", lambda, ")"));
plot(c(0,20), c(0,0.03), type="n", main="Prior", xlab=xlab, ylab=ylab);
grid();
lines( lambda, prior, col="blue", lwd=2);

ylab = expression(paste("P(X=2|", lambda, ")"));
plot(c(0,20), c(0,0.3), type="n", main="Likelihood", xlab=xlab, ylab=ylab);
grid();
lines(lambda, likelihood, col="red", lwd=2);

ylab = expression(paste("P(", lambda, "|X=2)"));
plot(c(0,20), c(0,0.03), type="n", main="Posterior", xlab=xlab, ylab=ylab);
grid();
lines(lambda, posterior, col="blue", lwd=2);

T = seq(0.1, 5, 0.1);
pt = c();
for (t in T)
{
	pt = c(pt, p(t));
}

plot(T, pt, type="l", xlab="t", ylab="P(X=0)", main="Chance of no failure goes under 5% just before t=1.72", col="red", lwd=2);
grid();
lines(c(1.72, 1.72), c(-1, 1), col="dark green");
lines(c(0, 5), c(0.05, 0.05), col="dark green");

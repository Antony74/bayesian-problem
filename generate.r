
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

#png("c:\\temp\\bayesplot.png", 640, 900, type = "cairo-png", pointsize=16);

par(mfrow=c(4,1)); # four rows and one column of graphs
xlab = expression(lambda);

main = expression(paste("Prior, P(", lambda, ")"));
plot(c(0,20), c(0,0.03), type="n", main=main, xlab=xlab, ylab="");
grid();
lines( lambda, prior, col="blue", lwd=2);

main = expression(paste("Likelihood, P(X=2|", lambda, ")"));
plot(c(0,20), c(0,0.3), type="n", main=main, xlab=xlab, ylab="");
grid();
lines(lambda, likelihood, col="red", lwd=2);

main = expression(paste("Posterior, P(", lambda, "|X=2)"));
plot(c(0,20), c(0,0.03), type="n", main=main, xlab=xlab, ylab="");
grid();
lines(lambda, posterior, col="blue", lwd=2);

T = seq(0.1, 5, 0.1);
pt = c();
for (t in T)
{
	pt = c(pt, p(t));
}

main = expression(paste("Chance of no failure goes under 5% just before t=1.72"));
plot(T, pt, type="l", xlab="t", ylab="", main=main, col="red", lwd=2);
grid();
lines(c(1.72, 1.72), c(-1, 1), col="dark green");
lines(c(0, 5), c(0.05, 0.05), col="dark green");

#dev.off();

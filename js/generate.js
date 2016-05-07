
var ndarray = require('ndarray');
var ops = require('ndarray-ops');

// Choose a sample of possible lambda
var lambda = [];
for (var n = 0.1; n <= 20; n += 0.1)
{
	lambda.push(n);
}

var N = lambda.length;
lambda = ndarray(lambda);

// Provision some additional rows of registers for storing intermediate calculations
var priors = ndarray(Array(N));
var likelihoods = ndarray(Array(N));
var posterior = ndarray(Array(N));
var r1 = ndarray(Array(N));
var r2 = ndarray(Array(N));
var r3 = ndarray(Array(N));

function factorial(x)
{
	var f = 1;
	for (var n = 1; n <= x; ++n)
	{
		f *= n;
	}

	return f;
}

function possion(poss, x, lambda)
{
	// Only do it this way for very small values of x
	ops.neg(r1, lambda);
	ops.expeq(r1);
	ops.pows(r2, lambda, x);
	ops.mul(r3, r1, r2);
	ops.divs(poss, r3, factorial(x));
}

function bayes(posterior, likelihoods, priors)
{
	ops.mul(r1, likelihoods, priors);
	var evidence = ops.sum(r1);
	ops.divs(posterior, r1, evidence);
}

ops.assigns(priors, 1/N);
possion(likelihoods, 2, lambda);
bayes(posterior, likelihoods, priors);

function p(t)
{
	ops.neg(r1, lambda);
	ops.muls(r2, r1, t);
	ops.expeq(r2);
	ops.mul(r3, r2, posterior);
	return ops.sum(r3);
}

console.log('p(1.72)=' + p(1.72));


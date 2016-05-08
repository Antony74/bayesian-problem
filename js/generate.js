
var ndarray = require('ndarray');
var ops = require('ndarray-ops');

function wrap(sFunctionName)
{
	return function(a, b)
	{
		var retval = ndarray(Array(a.shape[0]));
		ops[sFunctionName](retval, a, b);
		return retval;
	};
}

// Define various wrappers
var divs = wrap('divs');
var mul  = wrap('mul' );
var muls = wrap('muls');
var exp  = wrap('exp' );
var neg  = wrap('neg' );
var pows = wrap('pows');

function factorial(x)
{
	var f = 1;
	for (var n = 1; n <= x; ++n)
	{
		f *= n;
	}

	return f;
}

function possion(x, lambda)
{
	// Only do it this way for very small values of x
	return divs(
				mul( exp( neg(lambda)),
				     pows(lambda, x)),
				factorial(x));
}

function bayes(likelihoods, priors)
{
	var lp = mul(likelihoods, priors);
	var evidence = ops.sum(lp);
	return divs(lp, evidence);
}

// Choose a sample of possible lambda
var lambda = [];
for (var n = 0.1; n <= 20; n += 0.1)
{
	lambda.push(n);
}

var N = lambda.length;
lambda = ndarray(lambda);

// Choose some priors
var priors = ndarray(Array(N));
ops.assigns(priors, 1/N);

// Calculate likelihoods
var likelihoods = possion(2, lambda);

// Calculate posteriors
var posteriors = bayes(likelihoods, priors);

function p(t)
{
	var possibities = exp(neg(muls(lambda, t)));
	return ops.sum(mul(possibities, posteriors));
}

console.log('p(1.72)=' + p(1.72));



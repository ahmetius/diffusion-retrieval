% function generating toy dataset of 3 manifolds in the 2D space
% X = banana3(n);
% n: number of points per manifold
% X: [3N x 2] matrix of data points
%
% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% Use rng(155); n = 100; to identically fit our Figure 1 in the CVPR 2017 paper.
function X = banana3(n)

	if nargin < 1, n = 100; end

	a = .25;
	s = 1:n;
	m = n + 1;
	R = [1 0; 0 -1];
	A = banana(m) + repmat([1-a, 0], [m 1]);
	B = banana(m) + repmat([3+a, 0], [m 1]);
	C = banana(n) * R + repmat([2, a], [n 1]);
	X = [A(s+1,:); B(s,:); C];
end

function X = banana(n, a, b)

	if nargin < 2, a = .12; end
	if nargin < 3, b = .1; end

	t = linspace(0, pi, n)';
	u = (1 - 2 * b) * t + b * pi;
	r = a * randn(n, 1) .* sin(u) + 1;
	X = [r .* cos(t) r .* sin(t)];

end

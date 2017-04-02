% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% compute k-nearest neighbors of a query set to a database set 
function [knn, s] = knn_batch(v, vq, k, batch_size)

	if ~exist('batch_size'), batch_size = 1000; end;

	Nq = size(vq, 2);
	N = size(v, 2);
	batch_size = min(batch_size, Nq);	
	knn = zeros(k, Nq);
	s = zeros(k, Nq);

	for i = 1:ceil(Nq/batch_size)
			rng = (i-1) * batch_size + [1:batch_size];
			rng(rng>Nq) = [];

			x = v'*vq(:, rng);
			[sx, ix] = sort(x, 'descend');
			knn(:, rng) = ix(1:k, :);
			s(:, rng) = sx(1:k, :);
	end

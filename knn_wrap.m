% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% compute k-nearest neighbors of a query set to a database set
% wrapper that uses built-in or yael_nn 
function [knn, s] = knn_wrap(v, vq, k, batch_size)

	if ~exist('yael_nn')
		[knn, s] = knn_batch(v, vq, k, batch_size);
	else
		[knn, s] = yael_nn(v, -vq, k, 16);
    	s = -s;
	end

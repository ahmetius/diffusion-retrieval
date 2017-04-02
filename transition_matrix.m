% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% construct transition matrix S from affinity matrix W
function [S,D] = transition_matrix(W)

	np = size (W, 1);
	D = full(sum(W,2)).^-0.5;;
	D = spdiags (D, 0, np, np);
	S = D * W * D;

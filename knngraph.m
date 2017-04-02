% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% A = knngraph(knn, sim)
% create the affinity matrix for the mutual kNN graph based on the knn lists
% knn: kxN list of knn per vector
% sim: kxN list of corresponding similarities for knn
% A: sparse affinity matrix NxN
function A = knngraph(knn, sim)

	N = size(knn, 2);
	sim(sim<0) = 0; % similarity should be non-negative

	I = [];
	J = [];
	W = [];
	for i = 1:N
		mem = sum(ismember(knn(:, knn(:, i)), i), 1);
		if any(mem)
			nk = sum(mem);
			I(end+[1:nk]) = i * ones(nk, 1);
			J(end+[1:nk]) = knn(find(mem), i);
			W(end+[1:nk]) = sim(find(mem), i);
		end
	end

	A = sparse(I,J,double(W), N, N, numel(W));
  	A(1:size(A,1)+1:end) = 0;  % diagonal to 0
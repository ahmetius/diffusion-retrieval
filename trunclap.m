% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% create truncated Laplacian 
function L = trunclap(A, sub, alpha)

    T = transition_matrix(A(sub, sub));
    L = speye(size(T)) - alpha * T;

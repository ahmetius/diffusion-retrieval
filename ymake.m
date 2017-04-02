% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% construction of vector y for the query vector
% y = ymake(V, qv, k, gamma)
% v: dataset vectors
% qv: query vector
% k: number of nearest neighors to keep
% gamma: similarity exponent  
function y = ymake(v, qv, k, gamma)

    N = size(v, 2);
    [knn, s] = knn_wrap(v, qv, k, 100);  
    sc = accumarray(knn(:), s(:), [N 1]);
    [s,knn] = sort(sc,'descend');
  
    y = zeros(N,1);
    y(knn(1:k)) = max(s(1:k) .^ gamma , 0);
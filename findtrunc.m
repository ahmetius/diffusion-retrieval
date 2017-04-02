% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% find index for the truncated affinity
function f = findtrunc(v, qv, k, imids)

   [knn, ~] = knn_wrap(v, qv, k,100);
   f = find(ismember(imids,knn));

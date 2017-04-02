% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% function to compute generalized max pooling weights
% v: dxM set of regional vectors for the dataset
% imids: MX1 vector of image ids per regional vector
% coeff: GMP weightss
function coeff = gmpweights(v, imids)

    lambda = 1;

    coeff = zeros(size(imids));
    for i = 1:max(imids)
        % weights for generalized max pooling
        b = double((v(:,imids==i)'*v(:,imids==i)) + lambda.*eye(sum(imids==i))) \ double(ones(sum(imids==i),1)); 
        assert( ~any(isnan(b)),'NaN Value')
        coeff(imids==i) = b;
    end

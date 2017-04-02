% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% create image and feature ids for features of an image collection
% [image_ids, feature_ids] = imgfeatids (nof)
% nof: Nx1 vector with number of features per image
% image_ids: Mx1 image id per feature. M = sum(nof)
% feautre_ids: Mx1 unique feature ids
function [image_ids, feature_ids] = imgfeatids (nof)

% image ids for each database descriptor
cs = cumsum(double (nof));
[~, image_ids] = histc (1: cs (end), [1 cs+1]); %image ids here

% to create feature ids
feature_ids = 1:sum (nof);
rng = cs (1) + 1: length (feature_ids); %range such that values of first image are left unchanged
feature_ids (rng) = feature_ids (rng) - cs ( image_ids (rng) - 1); % subtract number of features of previous images such that fids becomes number of feature id per image
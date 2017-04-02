% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 

function [knn_, s_] = load_approx_knn( graph_file )


if ~exist(graph_file,'file')
    error(sprintf(['Precomputed approximate knn file not found.\n', ...
        'You are strongly advised to download the precomputed knn file for large-scale.\n',...
        'Otherwise run the following line in run_test.m. Beware that it may take a while to compute it\n']))
    %             coeff = poolweights(lvecs, imids, featureMode, poolMethod);
else
    fprintf('Warning! Loading the precomputed approximate nearest neighbors for large-scale \n')
    load(graph_file);
end

s_ = -s_;

end


% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 

alpha               = 0.99;                         % alpha for diffusion
it                  = 20;                           % iterations for CG
tol                 = 1e-6;                         % tolerance for CG
gamma               = 3;                            % similarity exponent

test_set            = 'oxford5k';                   % oxford5k, paris6k, instre, oxford105k, paris106k
cnn_model           = 'siamac';                     % siamac or resnet
feature_type        = 'regional';                   % regional or global    

data_dir            = 'data/';                      % this is where descriptors should be stored
load_vectors;

ndes = cell2mat(cellfun(@(x)size(x, 2), V, 'un', 0));  % number of vectors per image
[imids, ~] = imgfeatids (ndes);                        % image and region ids here
lvecs = cell2mat(V);                                   % set of all database vectors
Nf = numel(imids);                                     % number of database vectors
N = max(imids);                                        % number of images

fprintf('**** %s - Diffuse %s **** \n',test_set,feature_type);

% Off-line regional pooling weights
fprintf('Computing the pooling weights... \n') 
coeff = gmpweights(lvecs, imids);

% Diffusion parameters
if strcmp(feature_type,'global'), k = 50; kq = 10;
elseif strcmp(feature_type,'regional'), k = 200; kq = k;
else error('Wrong feature mode.'); end
  
% Enable truncation for large-scale
if (strcmp('oxford105k',test_set) || strcmp('paris106k',test_set)) && strcmp(feature_type,'regional'), dotrunc = 1; topn = 10000; else dotrunc = 0; end

% Create the graph
if (strcmp('oxford105k',test_set) || strcmp('paris106k',test_set)) && strcmp(feature_type,'regional')
    fprintf('Loading pre-computed kNN graph for large scale regional\n')  
    [knn_, s_] = load_approx_knn( graph_file );
else
    fprintf('Computing kNN graph\n')  
    [knn_, s_] = knn_wrap(lvecs, lvecs, k, 100);
end
A_ = knngraph(knn_(1:k, :), s_(1:k, :) .^ gamma);

% in case of truncation the Laplacian is computed per query
if ~dotrunc 
    S = transition_matrix(A_);
    A = speye(size(S)) - alpha * S;
    clear A_ S; 
end

% Query
clear scores;
for q = 1:numel(gnd); % number of queries

    if ~dotrunc
        y = ymake(lvecs, qV{q}, kq, gamma);                 % construction of y vector
        f = dfs(A,y,tol,it)';                               % diffusion
    else
        sub = findtrunc(Vextra, qVextra(:,q), topn, imids);  % sub-index for truncation
        L = trunclap(A_, sub, alpha);                       % truncated Laplacian
        y = ymake(lvecs(:, sub), qV{q}, kq, gamma);         % construction of y vector
        f = zeros(1,numel(imids)); 
        f(sub) = dfs(L,y,tol,it);                           % diffusion 
    end

    % pooling step for regional case
    if strcmp(feature_type, 'regional')
       f = accumarray(imids', f .*coeff, [N 1])';  
    end
    scores{q} = f;
end

% sort images and evaluate
[~, ranks] = sort (cell2mat(scores')', 'descend');
map = compute_map (ranks, gnd);
fprintf('k %d, map %.4f\n', k, map);

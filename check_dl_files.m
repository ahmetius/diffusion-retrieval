% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% Check if the required files exist, download them otherwise
function [data_file, gnd_file, graph_file] = check_dl_files(data_dir,test_set,cnn_model,feature_mode)

    data_file = sprintf('%s/%s_%s.mat',data_dir,test_set,cnn_model);
    gnd_file = sprintf('%s/gnd_%s.mat',data_dir,test_set);
    graph_file = sprintf('%s/%s_knn_kgraph_%s.mat',data_dir,test_set,cnn_model);

    if ~exist(data_file,'file')
        if ~exist(data_dir,'dir')
            mkdir(data_dir)
        end 
        warning('Warning: Downloading descriptors...')
    	system(sprintf('wget ftp://ftp.irisa.fr/local/texmex/corpus/diffusion/data/%s_%s.mat -O %s',test_set,cnn_model,data_file)); 
    end

    if ~exist(gnd_file,'file')
        if ~exist(data_dir,'dir')
            mkdir(data_dir)
        end
        warning('Warning: Downloading the ground-truth...')
    	system(sprintf('wget ftp://ftp.irisa.fr/local/texmex/corpus/diffusion/gnd/gnd_%s.mat -O %s',test_set,gnd_file)); 
    end

    % Download the precomputed approximate knn graph for regional large-scale
    if ~exist(graph_file,'file') && ( strcmp(test_set,'oxford105k') || strcmp(test_set,'paris106k') ) && strcmp(feature_mode,'regional')
        warning('Warning: Downloading the graph file for large-scale...')
    	system(sprintf('wget ftp://ftp.irisa.fr/local/texmex/corpus/diffusion/data/%s_knn_kgraph_%s.mat -O %s',test_set,cnn_model,graph_file)); 
    end

end


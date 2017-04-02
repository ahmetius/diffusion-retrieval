% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% script to load saved vectors 

% Check if feature and ground-truth files exist,download them otherwise
[data_file, gnd_file, graph_file] = check_dl_files(data_dir,test_set,cnn_model,feature_type);

% Load features and ground-truth files
load(data_file);
load(gnd_file);

switch feature_type
    case 'regional'
        V = reg.V;
        qV = reg.Q;
        
        % Keep the global vectors for truncation in large-scale 
        if strcmp(test_set,'oxford105k') || strcmp(test_set,'paris106k')
            Vextra = cell2mat(glob.V);
            qVextra = cell2mat(glob.Q);  
        end
       
    case 'global'
        V = glob.V;
        qV = glob.Q;
end

clear reg;
clear glob;
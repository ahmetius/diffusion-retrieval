% This function computes the mAP for a given set of returned results.
%
% Usage: map = compute_map (ranks, gnd);
%
% Notes:
% 1) ranks starts from 1, size(ranks) = db_size X #queries
% 2) The junk results (e.g., the query itself) should be declared in the gnd stuct array
function [map, aps] = compute_map (ranks, gnd, isJunkOk, verbose)

if nargin < 3
    verbose = false;
    isJunkOk = false;
end

if nargin < 4
    verbose = false;
end


map = 0;
nq = numel (gnd);   % number of queries
aps = zeros (nq, 1);

for i = 1:nq
    qgnd = gnd(i).ok;
    
    if isJunkOk
        qgndj = [];
        qgnd = [qgnd gnd(i).junk];
    else    
        if isfield (gnd(i), 'junk')
            qgndj = gnd(i).junk;
        else
            qgndj = [];
        end
    end
    
    % positions of positive and junk images
    [~, pos] = intersect (ranks (:,i), qgnd);
    [~, junk] = intersect (ranks (:,i), qgndj);
    
    pos = sort(pos);
    junk = sort(junk);
    
    k = 0;
    ij = 1;
    
    if length (junk)
        % decrease positions of positives based on the number of junk images appearing before them
        ip = 1;
        while ip <= numel (pos)
            
            while ( ij <= length (junk) & pos (ip) > junk (ij) )
                k = k + 1;
                ij = ij + 1;
            end
            
            pos (ip) = pos (ip) - k;
            ip = ip + 1;
        end
    end
    
    ap = score_ap_from_ranks1 (pos, length (qgnd));
    
    if verbose
        fprintf ('query no %d -> gnd = ', i);
        fprintf ('%d ', qgnd);
        fprintf ('\n              tp ranks = ');
        fprintf ('%d ', pos);
        fprintf (' -> ap=%.3f\n', ap);
    end
    map = map + ap;
    aps (i) = ap;
    
end
map = map / nq;

end


% This function computes the AP for a query
function ap = score_ap_from_ranks1 (ranks, nres)

% number of images ranked by the system
nimgranks = length (ranks);
ranks = ranks - 1;

% accumulate trapezoids in PR-plot
ap = 0;

recall_step = 1 / nres;

for j = 1:nimgranks
    rank = ranks(j);
    
    if rank == 0
        precision_0 = 1.0;
    else
        precision_0 = (j - 1) / rank;
    end
    
    precision_1 = j / (rank + 1);
    ap = ap + (precision_0 + precision_1) * recall_step / 2;
end

end

% Authors: A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. 2017. 
% function to perform diffusion
% solving system A*f = y
function f = dfs(A, y, tol, it)
	if nargin < 4, it = 20;	end
	if nargin < 3, tol = 1e-10; end
		
   [f,~,~,~] = pcg(A,y,tol,it);
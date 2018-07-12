 function P = getCameraMatrix(x, X) 
 
 A = getA(x, X);
 [U, S, V] = svd(A); 
 P = V(:, size(V,2));
 P = reshape(P, 4, 3)';
 
 return
 
 
 

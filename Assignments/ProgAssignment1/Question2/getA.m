function A = getA(x, X)
 n = size(x, 2);

 h = 1;
 for k =1:n
A(h, :) = [X(1, k) X(2, k) X(3, k) 1 0 0 0 0 -x(1, k)*X(1, k) -x(1, k)*X(2, k) -x(1, k)*X(3, k) -x(1, k)];
A(h + 1, :) = [0 0 0 0 X(1, k) X(2, k) X(3, k) 1 -x(2, k)*X(1, k) -x(2, k)*X(2, k) -x(2, k)*X(3, k) -x(2, k)];

 h = h + 2;
 

 end
 return;
 
 %DLT is being implemented here for a camera calibration matrix%
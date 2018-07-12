% Function to validate arguments values
    
function [x1, x2] = checkargs(argmnt);
    
    if length(argmnt) == 2
	x1 = argmnt{1};
	x2 = argmnt{2};
	if ~all(size(x1)==size(x2))
	    error('x1 and x2 should have same size');
	elseif size(x1,1) ~= 3
	    error('x1 and x2 must be 3xN');
	end
	
    elseif length(argmnt) == 1
	if size(argmnt{1},1) ~= 6
	    error('Single argument of x must be 6xN');
	else
	    x1 = argmnt{1}(1:3,:);
	    x2 = argmnt{1}(4:6,:);
	end
    else
	error('Wrong no. of args applied');
    end

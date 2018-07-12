function Order4dd=FourthOrderDiscreteDerivative(inputpoints)

    u   = ones(inputpoints - 2, 1);
    w   = -4 * ones(inputpoints - 1, 1);
    v   = 6 * ones(inputpoints, 1);
    Order4dd  = diag(u, 2) + diag(u, -2)+ diag(v) + diag(w, 1) + diag(w, -1);
    
    Order4dd(1, inputpoints)      = -4;
    Order4dd(inputpoints, 1)      = -4;
    Order4dd(1, inputpoints-1)    = 1;
    Order4dd(inputpoints - 1, 1)  = 1;
    Order4dd(2, inputpoints)      = 1;
    Order4dd(inputpoints, 2)      = 1;
    
end
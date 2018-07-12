function Order2dd=SecondOrderDiscreteDerivative(inputpoints)
    w   = 1 * ones(inputpoints-1, 1);
    v   = -2 * ones(inputpoints, 1);
    Order2dd  = diag(v)+diag(w, 1) + diag(w, -1);
    
    Order2dd(1, inputpoints) = 1;
    Order2dd(inputpoints, 1) = 1;
end

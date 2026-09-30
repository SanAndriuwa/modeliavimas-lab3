function [x,fx,history] = newtons(f,x0,tolerance,maxIterations)
% Newton method with a central-difference Jacobian and step damping.
x = x0(:)';
history = zeros(maxIterations+1,length(x));
history(1,:) = x;
h = 1e-5;
for iteration = 1:maxIterations
    fx = f(x); fx = fx(:);
    if norm(fx,inf) < tolerance
        history = history(1:iteration,:);
        return;
    end
    J = zeros(length(x));
    for j = 1:length(x)
        shift = zeros(size(x)); shift(j) = h;
        plus = f(x+shift); minus = f(x-shift);
        J(:,j) = (plus(:)-minus(:))/(2*h);
    end
    step = -(J\fx)';
    factor = 1;
    candidate = x+step;
    % The diode parameters are positive in the chosen scaled coordinates.
    while any(candidate <= 0) || norm(f(candidate)) >= norm(fx)
        factor = factor/2;
        candidate = x+factor*step;
        if factor < 1e-10
            error('Newton method cannot find a decreasing step.');
        end
    end
    x = candidate;
    history(iteration+1,:) = x;
end
history = history(1:maxIterations+1,:);
fx = f(x);
if norm(fx,inf) >= tolerance
    error('Newton method reached the iteration limit.');
end
end

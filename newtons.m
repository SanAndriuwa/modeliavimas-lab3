function [x,fx,xx] = newtons(f,x0,TolX,MaxIter,varargin)
% Supplied newtons.m: numerical Jacobian and three damped trial steps.
if nargin < 4, MaxIter = 100; end
if nargin < 3, TolX = 1e-6; end
h = 1e-4; TolFun = eps;
fx = feval(f,x0,varargin{:});
Nf = length(fx); Nx = length(x0);
if Nf ~= Nx
    error('Incompatible dimensions of f and x0.');
end
xx = zeros(MaxIter+1,Nx);
xx(1,:) = x0(:)';
fx0 = norm(fx);
for k = 1:MaxIter
    dx = -jacob(f,xx(k,:),h,varargin{:})\fx(:);
    for trial = 1:3
        dx = dx/2;
        xx(k+1,:) = xx(k,:)+dx';
        fx = feval(f,xx(k+1,:),varargin{:});
        fxn = norm(fx);
        if fxn < fx0, break; end
    end
    if fxn < TolFun || norm(dx) < TolX, break; end
    fx0 = fxn;
end
x = xx(k+1,:);
xx = xx(1:k+1,:);
if k == MaxIter
    fprintf('The best result in %d iterations.\n',MaxIter);
end
end

function g = jacob(f,x,h,varargin)
% Central-difference Jacobian from the supplied function.
h2 = 2*h; N = length(x); x = x(:)'; I = eye(N);
g = zeros(N);
for n = 1:N
    plus = feval(f,x+I(n,:)*h,varargin{:});
    minus = feval(f,x-I(n,:)*h,varargin{:});
    % Accept either a row or column residual vector.
    g(:,n) = (plus(:)-minus(:))/h2;
end
end

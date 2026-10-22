function [x,k,priezastis] = newtons(f,df,x,N,tolX,tolY)
% Niutono formule: x_naujas = x - f(x)/f'(x).
k = 0;
priezastis = 'N';
if abs(f(x)) <= tolY
    priezastis = 'tolY';
    return;
end
for k = 1:N
    d = df(x);
    if d == 0
        error('Isvestine lygi nuliui. Pakeiskite x0.');
    end
    x_naujas = x-f(x)/d;
    skirtumas = abs(x_naujas-x);
    x = x_naujas;
    if abs(f(x)) <= tolY
        priezastis = 'tolY';
        break;
    end
    if skirtumas <= tolX
        priezastis = 'tolX';
        break;
    end
end
end

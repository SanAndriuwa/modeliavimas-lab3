% Niutono metodas vienai netiesinei lygciai.
clear; clc; close all;
studento_nr = 20194658;
variantas = mod(studento_nr,15)+1;
N = 100; tolX = 1e-8; tolY = 1e-8;
x0 = 1; % Teigiamas pradinis artinys tinka ir logaritmams.

if variantas <= 8
    laipsniai = [3 3 3 3 4 4 4 5];
    konstantos = [2 3 5 10 2 5 16 7];
    p = laipsniai(variantas); c = konstantos(variantas);
    f = @(x) x.^p-c;
    df = @(x) p*x.^(p-1);
elseif variantas <= 12
    konstantos = [2 3 5 10];
    c = konstantos(variantas-8);
    f = @(x) exp(x)-c;
    df = @(x) exp(x);
else
    konstantos = [1 2 0.5];
    c = konstantos(variantas-12);
    f = @(x) log(x)-c;
    df = @(x) 1./x;
end

[x,k,priezastis] = newtons(f,df,x0,N,tolX,tolY);
fprintf('Variantas = %d\nx = %.12f\nf(x) = %.3e\n',variantas,x,f(x));
fprintf('Iteraciju skaicius = %d\nSustojimo priezastis: %s\n',k,priezastis);
xx = linspace(0.1,max(3,x+1),500);
plot(xx,f(xx),'b-',x,f(x),'ro','LineWidth',1.2);
yline(0,'k:'); grid on;
xlabel('x'); ylabel('f(x)');
title(sprintf('Newton method, variant %d',variantas));
legend('f(x)','Computed point','Location','best');

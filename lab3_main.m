% Diode parameters from two points read approximately from the PDF plot.
clear; clc; close all;
variants = 1:3;
k = 1.38e-23;
e = 1.602e-19;
Udata = [0.08 0.12]; % V
% Rows correspond to the solid, dashed, and dash-dot curves.
% These are rounded graph readings, not exact experimental observations.
Igraph = [33 197; 102 491; 151 662]*1e-6; % A
for variant = variants
fprintf('\nDIODE CURVE %d\n',variant);
if ~ismember(variant,1:3)
    error('variant must be from 1 to 3.');
end
Idata = Igraph(variant,:);

% x(1) = I0 in microamperes; x(2) = T in hundreds of kelvins.
% Scaling keeps the two unknowns and the two residuals comparable.
model = @(x,U) x(1)*1e-6*(exp(U*e/(k*x(2)*100))-1);
equations = @(x) (model(x,Udata)-Idata)./Idata;
x0 = [3 3];
[xNewton,residual,history] = newtons(equations,x0,1e-10,100);
hasFsolve = exist('fsolve','file') == 2;
if hasFsolve
    options = optimoptions('fsolve','Display','off', ...
        'FunctionTolerance',1e-12,'StepTolerance',1e-12);
    [xFsolve,~,exitflag] = fsolve(equations,x0,options);
    if exitflag <= 0
        error('fsolve did not converge.');
    end
else
    xFsolve = [NaN NaN];
    fprintf('Optimization Toolbox is unavailable: fsolve() was not executed.\n');
end
if norm(residual,inf) > 1e-8
    error('The parameter estimation did not converge.');
end

I0 = [xNewton(1); xFsolve(1)];
temperature = [xNewton(2); xFsolve(2)]*100-273.15;
Method = {'Newton'; 'fsolve'};
disp(table(Method,I0,temperature, ...
    'VariableNames',{'Method','I0_microA','Temperature_C'}));
fprintf('Newton iterations: %d\n',size(history,1)-1);
fprintf('Maximum relative equation residual: %.3e\n',norm(residual,inf));
if hasFsolve
    fprintf('Newton-fsolve parameter difference: %.3e\n',norm(xNewton-xFsolve(:)'));
end
% The PDF reference is used only after estimation, for comparison.
referenceI0 = [1 5 9]; referenceT = [-10 30 50];
fprintf('PDF reference: I0 = %g microA, t = %g C\n', ...
    referenceI0(variant),referenceT(variant));

U = linspace(-0.05,0.17,500);
figure;
plot(U,model(xNewton,U),'-',Udata,Idata,'ko','LineWidth',1.3);
if hasFsolve
    hold on; plot(U,model(xFsolve,U),'--','LineWidth',1.3);
    legend('Newton','PDF graph readings','fsolve','Location','best');
else
    legend('Newton','PDF graph readings','Location','best');
end
xlabel('U, V'); ylabel('I, A'); grid on;
title(sprintf('Diode curve %d',variant));
figure;
subplot(2,1,1); plot(0:size(history,1)-1,history(:,1),'-o');
ylabel('I0, microA'); xlabel('Iteration'); grid on;
subplot(2,1,2); plot(0:size(history,1)-1,history(:,2)*100-273.15,'-o');
ylabel('Temperature, C'); xlabel('Iteration'); grid on;
end

% Keep plots readable when MATLAB uses a dark theme.
set(findall(groot,'Type','figure'),'Color','w');
set(findall(groot,'Type','axes'),'Color','w','XColor','k','YColor','k');
set(findall(groot,'Type','legend'),'Color','w','TextColor','k');
set(findall(groot,'Type','text'),'Color','k');

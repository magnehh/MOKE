
clear;

N = 35;
step_length = 5;

Hc = zeros(1,N);
Ho = zeros(1,N);

theta = zeros(1,N);

% get data from files
for i = 1:N
    theta(i) = (i-1)*step_length;
    filename = strcat(int2str(theta(i)), 'deg.pro');
    [H, V] = Hysteresis(filename);
    Hc(i) = H(1);
    Ho(i) = H(2);
end

% plot figure with formating
close all;
f = figure;

% plot coercivity
subplot(2,1,1);
f1 = plot(theta, Hc, '-');
grid;
f1.Marker = 'o'; f1.Color = 'red';
xlabel('$\theta [\deg]$','Interpreter','LaTex');
ylabel('$H_c [Oe]$','Interpreter','LaTex');
title('Coercivity');

% plot offset
subplot(2,1,2);
f2 = plot(theta, Ho, '-');
grid;
f2.Marker = 'o'; f2.Color = 'blue';
xlabel('$\theta [\deg]$','Interpreter','LaTex');
ylabel('$H_o [Oe]$','Interpreter','LaTex');
title('Offset');

% save as eps
saveas(f,'HysteresisData','epsc');

% save as png
saveas(f,'HysteresisData.png');



function PlotHysteresis( filename )
%PLOTHYSTERESIS Plots the hysteresis curve from a .pro file.
%   PLOTHYSTERESIS( FILENAME ) plots the hysteresis from a .pro file and
%   saves it to .png and .eps formats.

% get data from file
[data, header] = ReadPro(filename);
[H, V] = Hysteresis(filename);

Hc = H(1);
Ho = H(2);
H1 = H(3);
H2 = H(4);

V_top = V(1);
V_bot = V(2);

% plot figure with formating
close all;
figure;
hold on;
f = plot(data(:,3), data(:,4), '-');
grid;   xlabel('H_x [Oe]');   ylabel('Longitudinal Kerr [mV]');
title('Hysteresis from MOKE');

% % plot top and bot
plot(get(gca,'xlim'), [V_top V_top], 'magenta');
plot(get(gca,'xlim'), [V_bot V_bot], 'magenta');

% plot coercivity lines
plot([H1 H1],get(gca,'ylim'), 'red');
plot([H2 H2],get(gca,'ylim'), 'red');

% plot offset line
plot([Ho Ho],get(gca,'ylim'), 'green');

% save as eps
saveas(f,'Hysteresis','epsc');

% save as png
saveas(f,'Hysteresis.png');

% print coercivity
fprintf('Hysteresis:\n\nCoercivity: Hc = %f [Oe]\nOffset: %f [Oe]\n\n', Hc, Ho);

end


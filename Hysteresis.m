function [H, V] = Hysteresis( filename )
%HYSTERESIS Get hysteresis data from .pro file.
%   [H, V] = HYSTERESIS( FILENAME ) returns two arrays: H = [Hc, Ho, H1, H2
%   ](Hc = coercivity, Ho = offset, H1 and H2 = mid-point edges) and
%   V = [V_top, V_bot] (V_top = top point after smoothing at 90%, V_bot =
%   bot point after smoothing at 10%).

% get data from file
[data, header] = ReadPro(filename);

% longditunal kerr value (in mV)
kerr = data(:,4);

% get min and max value
dmax = max(kerr);
dmin = min(kerr);

% define averaging range
range_top = 0.4;
range_bot = 0.2;

diff = dmax - dmin;
bot_lim_low = dmin + range_bot*diff;
bot_lim_high = dmin + range_top*diff;
top_lim_low = dmax - range_top*diff;
top_lim_high = dmax - range_bot*diff;

% find average in range (smoothing the edges)
n_top = 0;
sum_top = 0;
n_bot = 0;
sum_bot = 0;

for i = 1:length(kerr);
    if kerr(i) >= top_lim_low && kerr(i) <= top_lim_high
        n_top = n_top + 1;
        sum_top = sum_top + kerr(i);
    elseif kerr(i) >= bot_lim_low && kerr(i) <= bot_lim_high
        n_bot = n_bot + 1;
        sum_bot = sum_bot + kerr(i);
    end
end

% find top and bot after smoothing
V_top = sum_top/n_top;
V_bot = sum_bot/n_bot;



% find mid point
mid_point = (V_top - V_bot)/2 + V_bot;

% find closest sample to mid point
closest = dmax;
index_1 = 1;
for i = 1:length(kerr)
    if abs(kerr(i) - mid_point) < abs(closest - mid_point)
        closest = kerr(i);
        index_1 = i;
    end
end

% find closest sample to mid point that lies outside a buffer of 25% of the
% sample space
closest = dmax;
index_2 = 1;
for i = 1:length(kerr)
    if abs(kerr(i) - mid_point) < abs(closest - mid_point) && abs(i - index_1) > 0.25*length(kerr)
        closest = kerr(i);
        index_2 = i;
    end
end

% calculate edge points
H1 = data(index_1,3);
H2 = data(index_2,3);

% calculate coercivity
Hc = abs((H1-H2)/2);

% calculate offset
h_diff = abs(H2 - H1)/2;
Ho = min([H1 H2]) + h_diff;

H = [Hc, Ho, H1, H2];
V = [V_top, V_bot];

end


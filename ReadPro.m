function [data, header] = ReadPro( filename )
%READPRO Get data from .pro file.
%   [data, header] = READPRO( FILENAME ) returns Nx4 matrix containing the
%   data from a .pro file with N rows. It also returns the file header as a
%   string array.

% open file for reading
fileID = fopen(filename, 'rt');

% check if file is valid
if fileID < 0
    error('\nError opening file %s\n\n', filename);
end

% get first line of file (file header)
h = fgets(fileID);
Ch = textscan(h, '%s %s %s %s %s %s %s');
header(1) = Ch{1};
header(2) = Ch{2};
header(3) = strcat(Ch{3}, Ch{4});
header(4) = strcat(Ch{5}, Ch{6}, Ch{7});


% get first data line
line = fgets(fileID);
n = 1;


while ischar(line)
    
    % get numerical values from each line
    Cd = textscan(line, '%f %f %f %f');
    
    % store values in output matrix
    for i = 1:4
        data(n, i) = Cd{i};
    end
    
    % get next line
    line = fgets(fileID);
    n = n + 1;
end

% close file
fclose(fileID);
end


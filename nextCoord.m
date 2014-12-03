% calculates the xy coordinates that are 'distance' from x0,y0 and at in
% the direction of 'angle'
% 'angle' is in radians, 'distance' is the euclidean norm of the difference
% between (x,y) and (x0,y0)
function [x,y] = nextCoord( x0,y0 , angle, distance)
x = x0 + (distance * cos(angle));
y = y0 + (distance * sin(angle));
end
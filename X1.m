% takes an ordered pair X0 and returns an ordered pair X1 which is at
% 'angle' and 'distance' from X0
% 'angle' is in radians
function x1 = X1(X0,angle,distance)
x1 = zeros(1,2);
x1(1) = X0(1) + cos(angle) * distance;
x1(2) = X0(2) + sin(angle) * distance;
end
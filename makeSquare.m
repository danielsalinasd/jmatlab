% takes an xy pair 'center' and a side length 'size' and plots a square
% to the current figure of color 'color'
function makeSquare(center,size,color)
x = center(1) - (size/2);
y = center(2) - (size/2);
rectangle('Position',[x,y,size,size],'FaceColor',color);
end
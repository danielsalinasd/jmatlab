% takes two coordinates (xy pairs) and draws a rectangle at C1 and connects
% it to C0 via a line
function connect(C0,C1,color)
line([ C0(1), C1(1)], [ C0(2), C1(2) ]);
makeSquare(C1,1,color);
end
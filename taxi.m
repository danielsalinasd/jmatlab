% takes a column vector F and plots it out in the 'taxi' configuration
% the map is composed of squares and lines that join squares
% I is the number of each reaction in the original matrix
function taxi(F,I)
[R,~] = size(F);

% LOC is a C by 2 array. consider it a vector a x-y coordinates.
% these are the coordinates of the squares
% LIN are the indices of the locations to be joined by a line
[LOC, LIN] = reactionCoordinates();

% draw the lines
[LR,~] = size(LIN);
for i = 1:LR
    P1 = LOC( LIN(i,1),: );
    P2 = LOC( LIN(i,2),: );
    X = [ P1(1) P2(1) ];
    Y = [ P1(2) P2(2) ];
    line( X,Y ); 
end

% draw the squares
COL = colorSquares(F);
for i = 1:R
    makeSquare(LOC(i,:),1.4,COL(i,:));
    %
    text(LOC(i,1)-0.2,LOC(i,2),  num2str(I(i))  );
    text(LOC(i,1)-0.6,LOC(i,2)-1,  sprintf('%0.3e',F(i))  );
end
set(gca, 'XTick', []);
set(gca, 'YTick', []);
%remove the axes
%set(gca,'Visible','off');
end
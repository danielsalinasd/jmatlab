% takes a 3D array PIC, where the first two dimensions are arbitrary, and the
% third dimension is of size three. this represents the RGB code of an
% image.
% also takes a 2D array XY, with an arbitrary number of rows, and two
% columns. each row represents an x-y coordinate for a marker to be placed
% finally, takes a vector INT (intensities) marking the intensity of each
% marker. the markers with the highest positive value will be full red,
% while the markers with the lowest negative value will be full blue.
% XY and INT should have the same number of rows
function placeMarkers(PIC,XY,INT)
imshow(PIC);
[rows,~] = size(XY);
COL = getColors(INT);
for i = 1:rows
    %rectangle('Position', [ XY(i,1), XY(i,2), 25, 25 ], 'Curvature', [1,1], 'FaceColor', COL(i,:));
    text(XY(i,1), XY(i,2), num2str(INT(i)));
end
%saveas(PIC,'pic.png','png');
end

% come up with a color for each of the colum vector FV's elements
% this color is normalized according to the largest positive and the
% largest negative value. The largest positive value will be full red, zero
% will be white, and the largest negative value will be full blue.
function colors = getColors(FV)
[rows,~] = size(FV);
colors = zeros(rows,3);
pMax = max(FV);
if pMax < 0
    pMax = 0;
end

nMin = min(FV);
if nMin > 0
    nMin = 0;
end
for i = 1:rows
    if FV(i) > 0
        %set red
        colors(i,1) = 1;
        %set gb -- closer to zero, closer to white
        gb = 1 - (FV(i) / pMax);
        %colors(i,2) = gb;
        %colors(i,3) = gb;
    elseif FV(i) < 0
        % set blue
        colors(i,3) = 1;
    else
        %set white
        colors(i,:) = [1 1 1];
    end
    
end

end
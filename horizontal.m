function coordinates = horizontal(start,E)
coordinates = zeros(E,2);
coordinates(1,:) = start ;
for i = 2:E
    [x1, y1] = nextCoord(coordinates(i-1,1),coordinates(i-1,2),0,3);
    coordinates(i,:) = [x1, y1];
end
end
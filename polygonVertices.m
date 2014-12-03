function VERTICES =  polygonVertices(start,N, side)
VERTICES = zeros(N,2);
VERTICES(1,1) = start(1) ;
VERTICES(1,2) = start(2);
offset = ( (N - 2) * pi / N ) ;
for i = 2:N
    [VERTICES(i,1), VERTICES(i,2)] = nextCoord( VERTICES(i-1,1), VERTICES(i-1,2), offset * i, side);
end
end
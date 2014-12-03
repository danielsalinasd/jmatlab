% input: two vectors V1 and V2
% output: the angle between the vectors in degrees
function ANG = vector_angles(V1,V2)
ANG = acosd( dot(V1,V2) / ( norm(V1) * norm(V2) ) );
end
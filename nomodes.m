% takes a column vector F and a 2D matrix M
% attempts to find the component of F that is orthogonal to the columnspace
% of M
function FNM = nomodes(F,M)
FNM = F;
[~,C] = size(M);
for i = 1:C
    op = orthogonalProjection(FNM,M(:,i));
    FNM = FNM - op ;
end
end

function p = orthogonalProjection(u,v)
%p = u . v / (norm(v)^2) * v
p = dot(u,v);
p = p / (norm(v)^2);
p = p * v ;
end
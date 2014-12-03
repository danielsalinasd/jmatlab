% takes a vector F and a 2D matrix M
% returns the orthogonal projection of F onto the columnspace of M
% the columns of M must be linearly independent
function p = projection(F,M)
[~,c] = size(M);
p = zeros(size(F));
for i = 1:c
    pi = dot( F, M(:,i) );
    pi = pi / dot( M(:,i), M(:,i) );
    pi = pi * (M(:,i));
    p = p + pi ;
end
end

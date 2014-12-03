% given a 2d array DATA and a 2d array key return the standard deviation of
% each of the row samples
% DATA is a 2D array, partitioned into columns 1 to x, x + 1 to y, etc.
% each column represents a sample and each row represents an element of
% that sample, e.g. each row represents a metabolite reading, and each
% column represents the cell from which the reading was taken. columns x to
% y represent a group of cells that was exposed to the same conditions
% for three cell groups j to k, m to n, a to b, key would be an array as
% follows [j,k; m,n; a,b]
function SD = sd(DATA,key)
[region,~] = size(key);
[element,~] = size(DATA);
SD = zeros(element,region);
for i = 1:region
    sample = DATA(:, key(i,1):key(i,2) );
    SD(:,i) = std(sample,0,2);
end
end
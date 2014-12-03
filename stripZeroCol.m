% input 2D array A
% output 2D array noZeros, which consists of all the columns of A minus 
% the columns that were composed of only zeros and the indices of the 
% columns that were not included in noZeros the columns in noZeros retain 
% the same relative order as in A
function [noZeros, indicesDropped] = stripZeroCol(A)
[~, columns] = size(A);
indicesDropped = zeros(1,columns);
% go through each column, record the ones that are nonzero
for index = 1:columns
    if all( A(:,index) == 0 )
        indicesDropped(index) = index;
    end
end
noZeros = A(:,setdiff(1:columns,indicesDropped));
indicesDropped = setdiff(indicesDropped,0);
end
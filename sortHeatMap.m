function SORTEDHM = sortHeatMap(HM)
% input: a 2D array HM
% output: a 2D array SORTEDHM where each row SORTEDHM(:,I) is a reordered
% version of HM(I,:). Since all the rows are reordered according to the
% same criterion SORTEDHM can be thought of HM where the columns have
% switched places.
% the reordering is done by sorting the first row of HM. This sorting
% yields a set of indices that indicate the new ordering of the columns of
% HM, i.e. for HM = | 3 2 |
%                   | 5 6 |
% sort( HM(1,:) ) yields [2,1] as the index reordering, indicating that one
% would have to move column to into index one and column 1 into index two
% to sort the row.
% this reordering of the first row is used to reorder the rest of the rows.
% i.e. SORTEDHM would look like this | 2 3 |
%                                    | 6 5 |
SORTEDHM = HM;
[nRows,~] = size(HM);
[~,reordering] = sort( HM(1,:) );

for rowIndex = 1:nRows
    SORTEDHM(rowIndex,:) = HM(rowIndex,reordering);
end
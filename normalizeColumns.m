function [NORMCOLUMNS] = normalizeColumns(M)
% input: M is a 2D array with valid numbers
% output: NORMCOLUMNS is a 2D array. the value of each cell
% NORMCOLUMNS[i][j] is the value of M[i][j] / 1-norm( column J )
NORMCOLUMNS = M;
[~,nColumns] = size(M);

% go through each column and divide it by its norm
for columnIndex = 1:nColumns
    colNorm = norm(NORMCOLUMNS(:,columnIndex),1);
    NORMCOLUMNS(:,columnIndex) = NORMCOLUMNS(:,columnIndex) / colNorm;
end
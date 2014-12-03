# takes a 2D array M and puts it in row-echelon form by applying elementary row operations one by one.
# also takes a column vector A and applies each elementary row operation applied to M to A
#
# the first output redM is the row-echelon form of M
# the second output redA is A after the elementary row operations applied to M have been applied to A
# 
# the intent is that this function can be used to solve Mx = A via back-substitution given redMx = redA

function [redM, redA] = findref(M,A)
	[rows, columns] = size(M);
	
	redM = M;
	redA = A;
	
	for i = 1:rows
		pivotI = find( redM(i,:), 1, 'first' );
		if pivotI
			[redM, redA] = applyRowOps(redM, redA, pivotI, i);
		end
	end
end

# takes a 2D array pM, a vector pA, the column index of the pivot pCol, and the row index of the pivot pRow
# applies elementary row operations to pM and to pA.
# the elementary row operations applied will clear column pCol of any nonzero values below the row pRow.
#
# the intent is to use this to clear a single column of zero values given a single pivot.

function [clearedM, clearedA] = applyRowOps(pM, pA, pCol, pRow)
	[nRows, nCols] = size(pM);
	pivot = pM(pRow, pCol);
	clearedM = pM;
	clearedA = pA;
	for r = (pRow + 1):nRows
		columnVal = pM(r,pCol);
		if columnVal != 0
			#disp('pivot');
			#disp(pivot);
			#disp('knock out');
			#disp(columnVal);
			#row r = (pivotrow * factor) + row r
			factor = -columnVal / pivot ;
			clearedM(r,:) = ( clearedM(pRow,:) * factor ) + clearedM(r,:);
			clearedA(r,:) = ( clearedA(pRow,:) * factor ) + clearedA(r,:);
		end
	end
end

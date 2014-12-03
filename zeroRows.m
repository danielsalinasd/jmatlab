# takes in a 2D matrix A and finds rows that are all zeros
# returns the indices of the rows in the form of the vector Z
function z = zeroRows(A)
	[rows,~] = size(A);
	for i = 1:rows
		if all( A(i,:)==0 )
			disp(i)
	end
	z = 0;
end

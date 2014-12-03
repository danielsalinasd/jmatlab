function v = randomized_vector(vSize, vMagnitude)
% returns a column vector with number of elements vSize and magnitude
% vMagnitude
% come up with vSize numbers between 0 and 1
v = rand(vSize,1);

% give v a magnitude of 1
v = v / norm(v);

% give v a magnitude of vMagnitude
v = v * vMagnitude;
end
% get the variances of the difference between two means as calculated
% from standard deviation and sample sizes of each mean
% as calculated in ch 9 of intro to statistics by waldpole (2 ed)
% inputs are all column vectors, N1 a vector of the sample sizes for the
% first means with corresponding standard deviation1 S1. Same for N2,S2
% all inputs should be column vectors
function V = variances(N1,S1,N2,S2)
[n,~] = size(N1);
V = ones(n,1);
for i=1:n
    V(i) = calculate_variance(N1(i),S1(i),N2(i),S2(i));
end
end
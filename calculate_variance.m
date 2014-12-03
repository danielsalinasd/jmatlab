% returns the variance of the difference between two means as calculated
% from standard deviation and sample sizes of each mean.
% for this quantity as calculated in ch 9 of intro to statistics by waldpole
%(2 ed).
function variance = calculate_variance(n1,s1,n2,s2)
if n1 >= 30 & n2 >= 30
    variance = ( (s1^2) / n1 ) + ( (s2^2) / n2 );
else
    if n1 ~= n2
        variance = (s1 * s1 / n1) + (s2 * s2 / n2);
    else
        variance = (((n1 - 1) * s1^2) + ((n2 - 1) * s2^2)) / (n1 + n2 - 2);
    end
end

end
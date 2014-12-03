% calculates the expected value of the difference between two random
% variables, itself a random variable. more importantly, returns the variance
% for this quantity as calculated in ch 9 of intro to statistics by waldpole
%(2 ed).
function variance = calulate_variance(n1,s1,n2,s2)
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
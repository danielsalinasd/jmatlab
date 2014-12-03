% given two averages xbar1 and xbar2 with two respective standard
% deviations s1 and s2 and two respective sample sizes n1 and n2, and a
% a confidence percentage conf, this function returns the
% confidence interval for the difference xbar1 - xbar2 as a min-max pair
function CI = difference_stconfint(xbar1,n1,s1,xbar2,n2,s2,conf)
estimate = xbar1 - xbar2;
err = getError(n1,s1,n2,s2,conf);
CI = [estimate - err, estimate + err];
end

function error = getError(n1,s1,n2,s2,conf)
alpha2 = (1 - conf) / 2;
if n1 ~= n2
    v = getVNE(n1,s1,n2,s2);
    sboth = sqrt((s1 * s1 / n1) + (s2 * s2 / n2)); 
else
    v = getVEQ(n1,n2);
    varp = (((n1 - 1) * s1^2) + ((n2 - 1) * s2^2)) / (n1 + n2 - 2);
    sboth = sqrt(varp) * sqrt((1/n1) + (1/n2));
end
t = tinv(conf + alpha2,v);
error = t * sboth;
end

% use this when the populations are not likely to have equal variance
% and the sample size is not equal and sample size is less than 30 for at
% least one
function v = getVNE(n1,s1,n2,s2)
vnum = (s1 * s1 / n1) + (s2 * s2 / n2) ;
vnum = vnum * vnum;
vden = ((s1 * s1 / n1)^2 / (n1 - 1)) + ((s2 * s2 / n2)^2 / (n2 - 1));
v = vnum / vden;
end

% use this when the sample sizes are equal AND both populations are normal
% (or you can reasonably assume this)
function v = getVEQ(n1,n2)
v = n1 + n2 - 2;
end
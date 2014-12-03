% find the confidence interval of the difference between the elements of
% each column AVG, given standard deviations and samples SD and samples N
% AVG is a 2D array, SD is a 2D array, and N is a row vector
% Each column in AVG represents the average of several samples for a single
% timestep
% Each column in SD represents the standard deviation of the corresponding
% column in AVG
% Each column N represents the size of the sample of the corresponding
% column in AVG
% the function returns a 3D array CI, where the rows correspond to the
% element, the columns correspond to the interval between time steps, and
% the third dimension corresponds to the min-max values, e.g. CI(1,2,1)
% would be the minimum of the confidence interval for the difference
% between timestep 2 and timestep 3, for the first element
% the confidence is a number between 0 and 1 and (not inclusive) that
% reflects the confidence we wish to have for the interval, e.g. 0.95
% should we want 95% confidence
function CI = timestep_difference_CI(AVG,SD,N,conf)
[element,tstep] = size(AVG);
CI = zeros(element,tstep-1,2);
for t=1:tstep-1
    for e=1:element
        CI(e,t,:) = difference_stconfint(AVG(e,t+1),N(t+1),SD(e,t+1),AVG(e,t),N(t),SD(e,t),conf);     
    end
end
end
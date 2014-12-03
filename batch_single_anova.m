% what we want to do is run one factor anova to prove that the experimental
% populations changed over time
% input DATA is a 2D array where each column is a measurement of
% metabolites, KEY is a 2D array where each row is the start and end index
% of which columns belong to the same sample, e.g. if columns 1 - 5 belong
% to the same sample row 1 is 1,5 ; group values is the actual value
% corresponding to the sample (e.g. sample 2 had a factor level of 15)
function P = batch_single_anova(DATA,KEY,GROUPVALUES)
[mets,~] = size(DATA);
P = ones(mets,1) * -1;
labels = make_group(KEY,GROUPVALUES);
for i=1:mets
    metabolite_over_time = DATA(i,:);
    P(i) = anova1( metabolite_over_time, labels );
    if P(i) <= 0.10
        disp(i);
    end
end
end

% a group is simply the labeling of each sample
function G =  make_group(KEY,GROUPVALUES)
[tsteps,~] = size(KEY);
G = [];
for i = 1:tsteps
    nsamples = KEY(i,2) - KEY(i,1) + 1;
    new_section = repmat(GROUPVALUES(i),nsamples,1);
    G = [G ; new_section];
end
end
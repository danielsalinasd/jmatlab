% input the data
% output the metabolites which have been affected by time compressed but
% not by time experimental
% we're going to try to do this using anova
% so the questions we want to answer answer really are, do the populations
% being compressed 15 and not being compressed 15 belong to a single
% population? which ones don't? so...does 2-way help us answer? so I think.
% it will dispute several hypotheses, well 2. the first
% hypothesis H0A refers to factor A, that is the means of the values of the
% subpopulations of A are all really the same mean (assuming they have the
% same variance?)make factor A time elapsed since beginning of experiment
% rejecting the null hypothesis then advocates that for non-compression,
% the concentrations do not really change (this would be desirable) the
% second null hypothesis is HOB and of course relates to compression, we
% want to reject this one

% output: a 2D matrix H0
%     each row of the matrix corresponds to a single metabolite
%     each column corresponds to a factor
%     each cell relates whether the null hypothesis was accepted or
%     rejected for that factor in metabolite j
% input DATA is a 2D matrix of measurements, one row for each metabolite
%     GROUP is a cell array, each cell corresponds to a row in DATA (a
%     metabolite) see anovan function to see the structure for each element
%     of GROUP)
function H0 = batchANOVA(DATA,GROUP)
[nRow, ~] = size(DATA);
[~,nGroup] = size( GROUP{1} );
H0 = zeros(nRow,nGroup);
for r=1:nRow
    g = GROUP{r};
    H0(r,:) = anovan( DATA(r,:), g )';
end
end
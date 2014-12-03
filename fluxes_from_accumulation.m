function [fluxes, resnorm, residual] = fluxes_from_accumulation(SM, ACDATA)
% get the accumulation vectors from the concentration data
AC = compute_accumulation_vector( ACDATA , tsteps(1) );

% modify the matrix so that only the linearly independent columns remain.
% this reduces the number of variables so that the problem becomes more
% defined.
% indcols is set of columns that were used for this computation, i.e. the
% reactions numbers from the original sm
% resnorm is the l2 norm of the residual vector, also returned
[SM_independent, indcols] = licols(SM);
disp('Reduced Matrix Size:');
disp(size(SM_independent));
disp('Measured Metabolite Concentations');
[metabolitesWeKnow,~] = size(current_mapping());
disp(metabolitesWeKnow);

% reconcile the accumulation vector with one that is sized for the
% stoichiometric matrix -- replace all the unknown accumulations with zeros
[acSize,nReactions] = size(SM_independent);
smAC = reconcile_accumulations(acSize,current_mapping(),AC);

% process each accumulation vector
[~,nTimesteps] = size(smAC);
%bargraph: data to be plotted, has a row for every reaction flux, a column for
%every time step
BARGRAPH = zeros(nReactions,nTimesteps);
for t = 1:nTimesteps
    % print out diagnostics
    [fluxes, resnorm, residual, exitflag, output] = compute_fluxes(SM_independent,smAC(:,t),[],[],[],[],[],[]);
    %[fluxes, resnorm, residual, exitflag, output] = mumey_flux(SM_independent,smAC(:,t),1e-19);
    disp('residual magnitude');
    disp(resnorm);
    disp('residuals');
    disp(residual);
    report_error(exitflag);
    % set each flux so that we can compare them in a bar graph
    BARGRAPH(:,t) = fluxes;
end
bar(BARGRAPH)
legend('T = 15', 'T = 30')
title('Shift in Flux for each Reaction')
xlabel('Reaction Number')
ylabel('Raw Flux Magnitude')

heatmap = BARGRAPH';
heatmap = normalizeColumns(heatmap);
heatmap = sortHeatMap(heatmap);
imagesc(heatmap)
xlabel('Reaction')
ylabel('Time Step')


end
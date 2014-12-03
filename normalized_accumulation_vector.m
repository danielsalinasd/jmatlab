function differences = normalized_accumulation_vector(TIMESERIES, TIMESTEP)
% INPUT: a 2d matrix TIMESERIES, where each cell c_ij represents the concentration of
% a metabolite i in sample j, sample j belongs to a time step I
% a 2d matrix TIMESTEP, each row I contains two indices, the first is the
% first column of time step I and the second the last column of time step
% I, a column belongs to a time step I if its samples were taken at time
% step I. therefore, samples that belong to a single time step are assumed
% to be adjacent to each other in this matrix.
[nSteps,~] = size(TIMESTEP);
[nMetabolites, ~] = size(TIMESERIES);

% this is the matrix that will be returned
% the average accumulations will be attached as columns to this initial
% column of zeros. this column will not be returned as part of the matrix
accumulation = zeros(nMetabolites,1);
means = zeros(nMetabolites,nSteps);
stds = zeros(nMetabolites,nSteps);

% first we isolate the measurements that belong to a single time step
% the fundamental assumption is that samples from the same time step are in
% adjacent columns
for stepI = 1:nSteps
    firstMeasurement = TIMESTEP(stepI,1);
    lastMeasurement = TIMESTEP(stepI,2);
    
    % then we take a slice of the array that we want, by slice I mean
    % section. the slice that wer're interested in is: all rows (the
    % concentrations of all metabolites) but columns between
    % firstMeasurement and lastMeasurement inclusive, (all samples of a
    % single time step. so, in summary, the following takes a submatrix
    % that holds all concentrations of all samples of a single time step
    timestepMeasurements = TIMESERIES(:,firstMeasurement:lastMeasurement);
    
    % once we have collected all samples for a time step, we take the
    % average accumulation per metabolite over all samples in that time
    % step. because mean() treats averages the columns rather than the
    % rows, we'll have to specify the dimension as number 2
    timestepAverage = mean(timestepMeasurements,2);
    means(:,stepI) = timestepAverage;
    stds(:,stepI) = std(timestepMeasurements,1,2);
    accumulation = cat(2,accumulation,timestepAverage);
end

% return timestep(I) - timestep(I - 1)
differences = accumulation(:,2:end) - accumulation(:,1:end-1);
% get rid of the first difference (timestepI - zero vector)
differences = differences(:,2:end);

% normalize the differences according to the original value, i.e. we
% measure how much things changed by taking the difference of acccumulation
% at t=30 and the accumulation at t=15 and then dividing that difference by
% the accumulation values at t=15
for i = 1:(nSteps - 1);
    for j = 1:nMetabolites
        differences(j,i) = differences(j,i) / stds(j,i);
    end
end

end
function [best_random, best_residual, best_resnorm] = compare_with_random(original,SM,target,repetitions)
% repeatedly calculates target - SM * x, where 'x' is a randomized vector of
% magnitude equal to that of the vector 'original'
% the best random vector is kept and returned
% the comparison is repeated 'repetitions' times
% displays a scatter plot showing distance from original (independent var.)
% vs. residual magnitude

% determine the magnitude and size of the randomized vectors
rMagnitude = norm(original);
rSize = size(original);

% set up containers for the plot data
distance_from_original = zeros(repetition);
residual_magnitude = zeros(repetition);

% set up the loop variables
best_random = [];
best_residual = [];
best_resnorm = Inf;
for i = 1:repetitions
    x = randomized_vector(rSize,rMagnitude);
    
    residual = target - (SM * x);
    resnorm  = norm(residual);
    
    if resnorm < best_resnorm
        best_resnorm = resnorm;
        best_residual = residual;
        best_random = x;
    end
    
    distance_from_original(i) = norm(original - x);
    residual_magnitude(i) = resnorm;
    
end

figure
hold on
scatter(distance_from_original,residual_magnitude);

% find and plot the norm of the residual for the original flux
original_resnorm = norm(target - (SM * original));
plot([original_resnorm, original_resnorm]);

hold off
end
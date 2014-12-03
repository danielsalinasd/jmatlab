
% "core" function, does not modify input or report error. only chooses
% which algorithm to solve with.
function [fluxes, resnorm, residual, exitflag, output] = compute_fluxes( SM, ACC, FU, FL, A, b, Aeq, beq )
% Given:
%   a stoichiometric matrix SM
%   an accumulation vector ACC
%
%   optional: lower bounds for the fluxes FL
%   optional: upper bounds for the fluxes FU
%
%   optional: a set of extra linear contstraints Ax <= b
%   optional: a set of extra linear inequality constraints Aeq x = beq
%
% Output:
%   a flux vector 'fluxes' that minimizes the squared l2 norm of SM^T v = ACC
%   v is calculated using matlab's lsqlin

%this decides the algorithm to be appplied
if isempty(A) && isempty(Aeq) && ~isempty(FL) && isempty(FU) && all(FL >= 0)
% if we are given only a stoichiometric matrix and an accumulation vector
% then fluxes can be either positive or negative. 
% lsqnonneg is applied only if nonzero lower bounds are given and no upper
% bounds are given since lsqnonneg does not take upper bounds
    [fluxes, resnorm, residual, exitflag, output] = lsqnonneg(SM, ACC);
else
    % any other case is taken care of by lsqlin
    % the expected case is A, b, Aeq, beq, FU, FL are all empty
    % in this case the algorithm 
    [fluxes, resnorm, residual, exitflag, output] = lsqlin(SM,ACC, A, b, Aeq, beq, FL, FU);
end
end
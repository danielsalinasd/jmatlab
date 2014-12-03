function [fluxes, indcols,  resnorm, residual, exitflag, output] = get_fluxes(SM, ACC, FU, FL, A, b, Aeq, beq)
% modify the matrix so that only the linearly independent columns remain.
% this reduces the number of variables so that the problem becomes more
% defined.
% indcols is set of columns that were used for this computation, i.e. the
% reactions numbers from the original sm
% resnorm is the l2 norm of the residual vector, also returned
[SM_independent, indcols] = licols(SM);


% once we have a reduced matrix, use compute_fluxes with no constraints and
% no bounds. compute_fluxes minimizes difference between SM v = ACC over
% possible flux values v
[fluxes, resnorm, residual, exitflag, output] = compute_fluxes(SM_independent, ACC, FU, FL, A, b, Aeq, beq);

disp('size of matrix');
disp(size(SM_independent));

% report whether the optimization was successful
report_error(exitflag);
end
function error = report_error(error_code)
error = error_code;
if (error_code == 0)
    disp('Warning: Number of iterations exceeded.');
elseif(error_code == -2)
    disp('Warning: The problem is infeasible.');
elseif (error_code == -4)
    disp('Warning: Ill-conditioning prevents futher optimization.');
end
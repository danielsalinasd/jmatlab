function [fluxes, resnorm, residual, exitflag, output] = mumey_flux(SM, ACC, maxTolerance)
resnorm = Inf;
while(resnorm > maxTolerance)
    [fluxes, resnorm, residual, exitflag, output] = lsqlin(SM,ACC,[],[]);
    disp('x');
    disp(resnorm);
    ACC = SM * fluxes ;
end

end
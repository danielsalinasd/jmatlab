% calculate fluxes over 30 minutes

% calculate the difference in the average over 30 minutes for the
% expermental group
ex30dif = exavg(:,3) - exavg(:,1);
% calculate the difference in the average over 30 minutes for the
% control group
cn30dif = cnavg(:,3) - cnavg(:,1);

% add the etc metabolites for experimental group
ex30dif = [ex30dif; 0; 0; 0; 0; 0; 0 ];
% add the etc metabolites for control group
cn30dif = [cn30dif; 0; 0; 0; 0; 0; 0 ];

% compute the fluxes for the experimental group
fex30d = pinv(SM) * ex30dif ;
% compute the fluxes for the experimental group
fcn30d = pinv(SM) * cn30dif ;
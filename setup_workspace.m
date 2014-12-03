% this script computes several matrices/vectors that might be useful
% namely, given the current data (7-14-14) it computes b for several Ax = b
% systems: experimental at t = 15, 30, and control at t = 15, 30
% also solves the systems for the appropriate x using slash and pinv
% the matrices that are required are the current stoichiometric matrix,
% that is, the 35 by 30 matrix of rank 27, set in a variable called SM, and
% the raw experimental (29 by 15) and control (29 by 13) data, set into
% variables called EXP and CON, respectively.

% ACE: accumulation data for experimental group. each column is the
% difference between timesteps
ACE = compute_accumulation_vector(EXP,[1,5;6,10;11,15]);

% ACC: accumulation data for control group. each column is the
% difference between timesteps
ACC = compute_accumulation_vector(CON,[1,5;6,9;10,13]);


% For the next matrices, the extra zeroes are added
% because there are some metabolites who we know have a concentration of
% zero (electron transport chain)
% ACE15: accumulation vector for timestep 15 in the experimental group
ACE15 = [ACE(:,1); 0; 0; 0; 0; 0; 0];
% ACE30: accumulation vector for timestep 30 in the experimental group
ACE30 = [ACE(:,2); 0; 0; 0; 0; 0; 0];
% ACC15: accumulation vector for timestep 15 in the control group
ACC15 = [ACC(:,1); 0; 0; 0; 0; 0; 0];
% ACC30: accumulation vector for timestep 30 in the control group
ACC30 = [ACC(:,2); 0; 0; 0; 0; 0; 0];

% Solve the Ax = b systems
% fe15p: fluxes computed by the pseudoinverse for experimental group t=15
fe15p = pinv(SM) * ACE15;
% fe15s: fluxes computed by the slash for experimental group t=15
fe15s = SM \ ACE15;
% fe30p: fluxes computed by the pseudoinverse for experimental group t=30
fe30p = pinv(SM) * ACE30;
% fe30p: fluxes computed by the slash for experimental group t=30
fe30s = SM \ ACE30;
% fc15p: fluxes computed by the pseudoinverse for control group t=15
fc15p = pinv(SM) * ACC15 ;
% fc15s: fluxes computed by the slash for control group t=15
fc15s = SM \ ACC15;
% fc30p: fluxes computed by the pseudoinverse for control group t=30
fc30p = pinv(SM) * ACC30;
% fc30s: fluxes computed bythe slash for control group t=30
fc30s = SM \ ACC30 ;

%compute the residuals
fe15pr = (SM * fe15p) - ACE15 ;
fe15sr = (SM * fe15s) - ACE15 ;
fe30pr = (SM * fe30p) - ACE30 ;
fe30sr = (SM * fe30s) - ACE30 ;
fc15pr = (SM * fc15p) - ACC15 ;
fc15sr = (SM * fc15s) - ACC15 ;
fc30pr = (SM * fc30p) - ACC30 ;
fc30sr = (SM * fc30s) - ACC30 ;
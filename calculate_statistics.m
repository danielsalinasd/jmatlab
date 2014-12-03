% caluculate the confidence intervals for the differences between time
% steps -- make sure you import the data and run the setup_workspace script
% before you run this one

% 1 find the standard deviation
exts = [1,5; 6,10; 11,15]; % experimental data common time step columns
cnts = [1,5; 6,9;  10,13]; % control data common time step columns

exsd = sd(EXP,exts);
cnsd = sd(CON,cnts);

% 2 use the averages and the standard deviation to come up with the
% confidence interval
exavg = [mean(EXP(:,1:5),2),mean(EXP(:,6:10),2),mean(EXP(:,11:15),2)];
cnavg = [mean(CON(:,1:5),2),mean(CON(:,6:9),2),mean(CON(:,10:13),2)];
exCI = timestep_difference_CI(exavg,exsd,[5,5,5],0.95);
cnCI = timestep_difference_CI(cnavg,cnsd,[5,4,4],0.95);

% to do anova we need to make the groups and the data. we're doing a two
% way anova with two factors ( time compressed and time elapsed since the
% start of the experiment )

% make the data
anovaDATA = [EXP CON];

% make the groups
% there are two groups, one for the compression time and one for the time
% elapsed since the beginning of the experiment
% group one correponds to the time of compression
%group two corresponds to the time since the beginning of the experiment
anovaTimes = [0,15,30];
[ntimes,~] = size(exts);
g1exp = []; 
for tt=1:ntimes
    nsamples = exts(tt,2) - exts(tt,1) + 1;
    g1exp = [g1exp repmat(anovaTimes(tt),1,nsamples)];
end
g2exp = g1exp; % equal in the case of experimental data

[ntimes,~] = size(cnts);
g2cnt = [];
for tt=1:ntimes
    nsamples = cnts(tt,2) - cnts(tt,1) + 1;
    g2cnt = [g2cnt repmat(anovaTimes(tt),1,nsamples)];
end
g1cnt = zeros(size(g2cnt)); % control group does not get compressed

g1 = [g1exp g1cnt];
g2 = [g2exp g2cnt];
g = {g1 g2};

%EDIT: for the six-cell variation
gg1 = [g1exp g2cnt];
gg2 = {'exp';'exp';'exp';
    'exp';'exp';'exp';
    'exp';'exp';'exp';
    'exp';'exp';'exp';
    'exp';'exp';'exp';
    'con';'con';'con';
    'con';'con';'con';
    'con';'con';'con';
    'con';'con';'con';
    'con'};

%g = {gg1,gg2};
%EDIT: for the four-cell variation

ggg1 = [g1exp(6:end) g2cnt(6:end)];
ggg2 = {'exp';
    'exp';'exp';'exp';
    'exp';'exp';'exp';
    'exp';'exp';'exp';
    'con';
    'con';'con';'con';
    'con';'con';'con';
    'con'};

%g = {ggg1,ggg2};
%anovaDATA = [EXP(:,6:end) CON(:,6:end)];

% batchANOVA requires group information to be provided for each metabolite
[mt,~] = size(EXP);
anovaGROUP = cell(mt,1);
anovaGROUP(:) = {g};
pvals = batchANOVA(anovaDATA,anovaGROUP);

[pv,~] = size(pvals);
for i=1:pv
    if any( pvals(i,:) <= 0.1 )
        disp(i);
    end
end

% we're solving a variance weighted least squares. 
% each measurement of the difference between time steps will have an
% associated variance, and from those variances the weighting matrix w is
% made, where the diagonal is the weight of each metabolite ( the
% reciprocal of the variance )
ex15variances = variances(repmat(5,mt,1),exsd(:,1),repmat(5,mt,1),exsd(:,2));
ex30variances = variances(repmat(5,mt,1),exsd(:,2),repmat(5,mt,1),exsd(:,3));
cn15variances = variances(repmat(5,mt,1),cnsd(:,1),repmat(4,mt,1),cnsd(:,2));
cn30variances = variances(repmat(4,mt,1),cnsd(:,2),repmat(4,mt,1),cnsd(:,3));

% the ones are added to the end, you'd think this represents a simple
% weight of 1, but in the context of all the other weights (~e-7) this
% weights the etc metabolites very highly.
ex15W = diag( 1 ./ [ex15variances; 1; 1; 1; 1; 1; 1] );
ex30W = diag( 1 ./ [ex30variances; 1; 1; 1; 1; 1; 1] );
cn15W = diag( 1 ./ [cn15variances; 1; 1; 1; 1; 1; 1] );
cn30W = diag( 1 ./ [cn30variances; 1; 1; 1; 1; 1; 1] );

fe15vw = pinv(SM' * ex15W * SM) * SM' * ex15W * ACE15;
fe30vw = pinv(SM' * ex30W * SM) * SM' * ex30W * ACE30;
fc15vw = pinv(SM' * cn15W * SM) * SM' * cn15W * ACC15;
fc30vw = pinv(SM' * cn30W * SM) * SM' * cn30W * ACC30;

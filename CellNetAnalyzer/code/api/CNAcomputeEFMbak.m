function [efm,revs,idx] = CNAcomputeEFM(cnap,constraints,mexversion,irrev_flag,convbasis_flag,iso_flag,c_macro,display,efmtool_options)


% CellNetAnalyzer API function 'CNAcomputeEFM'
% ---------------------------------------------
% --> calculation of elementary modes resp. convex basis vectors
%
% Usage: [efm,revs,idx] = CNAcomputeEFM(cnap, constraints,...
%				mexversion, irrev_flag, convbasis_flag, iso_flag, c_macro, display, efmtool_options)
% 
% cnap is a CellNetAnalyzer (mass-flow) project variable and mandatory argument. 
% The function accesses the following fields in cnap (see also manual):
%   cnap.stoichmat: the stoichiometric matrix of the network
%   cnap.numr = number of reactions (columns in cnap.stoichMat)
%   cnap.mue: index of the biosynthesis reaction; can be empty
%   cnap.macroComposition: matrix defining the stoichiometry of the
%   cnap.specInternal: vector with the indices of the internal species
%   cnap.reacID: names of the columns (reactions) in cnap.stoichMat
%   cnap.specID: names of the rows (species) in cnap.stoichMat
%   cnap.macroID:  names of the macromolecules
%   cnap.macroDefault: default concentrations of the macromolecules
%   cnap.reacMin: lower boundaries of reaction rates
%       (if reacMin(i)=0 --> reaction i is irreversible)
%   cnap.reacMax: upper boundaries of reaction rates
%   cnap.epsilon : smallest number greater than zero (for numerical purposes)
%
% The other arguments are optional:  
%
%   constraints:   constrains is a (numrx1) vector. if(constraints(i)==0) then 
%     only those elementary modes are computed that do not include the reaction i;
%     if(constraints(i)~=0 and constraints(i)~=NaN) enforces reaction i, i.e. only 
%     those modes will be computed that involve reaction i; 
%     reaction i remains unconstrained if constraint(i)=NaN;
%     several reactions may be suppressed/enforced simultaneously
%     (default: [])
%
%   mexversion: [0|1|2|3|4] 0: scripts, 1: CNA mex files,
%     2: Metatool mex files, 3: CNA and Metatool mex files
%     4: Marco Terzer's EFM tool (see http://www.csb.ethz.ch/tools/index)
%       (the toolbox must be installed and in the MATLAB path)
%    (default:3)
%
%   irrev_flag: [0|1] wheter or not to consider reversibilities
%     of reactions 0: all reactions are reversible (default: 1)
%
%   convbasis_flag: [0|1] calculate elementary modes (0) or convex basis (1)
%     (default: 0)
%
%   iso_flag: [0|1] wheter or not to consider isoenzymes
%     (parallel reactions) only once (default: 0)
%
%   c_macro: vector containing the macromolecule values (concentrations); 
%     can be empty when cnap.mue or cnap.macroComposition is empty
%     (default: cnap.macroDefault)
%
%   display: control the detail of console output; choose one of 
%     {'None', 'Iteration', 'All', 'Details'}
%     default: 'All'
%
%   efmtool_options: cell array with input for the CreateFluxModeOpts function
%     default: {}   (some options will be set by default; cf. console
%                    output for the actual options used)
%
%
% The following results are returned:
%
%   efm:  matrix that contains the elementary modes row-wise;
%          the columns correspond to the reactions; the column indices of efms
%	   (with respect to the columns in cnap.stoichMat) are stored in
%          the returned variable idx (note that columns are removed in
%          efms if the corresponding reactions are not contained in any mode)
%
%   revs:  vector indicating for each mode whether it is reversible(0)/irreversible (1)
%
%   idx:   maps the columns in efm onto the column indices in cnap.stoichmat, 
%	   i.e. idx(i) refers to the column number in cnap.stoichmat (and to
%	   the row number in cnap.reacID)



efm=[];
revs=[];
idx=[];

if(nargin<1)
	warning('Not enough input arguments.');
	return;
end

cnap.local.val_mex=3;
cnap.local.rb=[];
cnap.local.val_irrev=1;
cnap.local.val_iso=0;
cnap.local.val_extreme=0;
cnap.local.c_makro=cnap.macroDefault;
cnap.local.display= 'All';
cnap.local.efmtool_options= {};

if(nargin>1 && ~isempty(constraints))
	rb=find(~isnan(constraints));
	if(size(rb,1)<size(rb,2) && ~isempty(rb))
		rb=rb';
		rb(:,2)=constraints(rb)';
    elseif(~isempty(rb))
		rb=[rb constraints(rb)];
		
	end
	cnap.local.rb=rb;
end
if(nargin>2)
	cnap.local.val_mex=mexversion;
end
if(nargin>3)
	cnap.local.val_irrev=irrev_flag;
end
if(nargin>4)
	cnap.local.val_extreme=convbasis_flag;
end
if(nargin>5)
	cnap.local.val_iso=iso_flag;
end
if(nargin>6)
	if(size(c_macro,1)<(size(c_macro,2)))
		c_macro=c_macro';
	end
	cnap.local.c_makro=c_macro;
end
if nargin > 7
  cnap.local.display= display;
end
if nargin > 8
  cnap.local.efmtool_options= efmtool_options;
end

cnap=compute_elmodes(cnap);

efm=cnap.local.elmoden;
revs=cnap.local.elm_consts;
idx=cnap.local.mode_rates;

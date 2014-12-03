function mapping = current_mapping()
% this is a matching between the metabolites given in the accumulation
% data and the ones in the matrix.
% the mapping is a 2d array -- each row corresponds to a metabolite
% the first number of each row is the number the metabolite has in the
% accumulation data, the second is the number the metabolite has in the
% stoichiometric matrix.
%
% THESE NUMBERS ARE BOTH COUNTED WITH 1 AS THE INDEX OF THE FIRST ROW, IN
% CONFORMANCE WITH MATLAB CONVENTION
mapping = [16,1;
    6,2;
    7,4;
    11,6;
    25,9;
    1,11;
    26,12;
    2,14;
    31,16;
    32,18;
    21,19;
    5,20;
    29,22;
    10,23;
    22,25;
    4,27;
    35,28;
    15,29;
    19,30;
    34,31;
    12,32;
    14,33;
    13,34;
    23,35;
    30,36;
    3,37;
    33,41;
    27,43;
    28,44];
end
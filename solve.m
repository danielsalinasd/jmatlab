% forward reactions; column indices
in = [ 1
     2
     3
     4
     5
     6
     7
     8
     9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    41
    42
    43
    44
    45
    46
    47
    48
    49
    56
    57
    58
    59
    60
    61
    62
];

SM_forward = SM(:,in);

% external metabolites; row indices
externals = [1
2
4
9
10
12
13
17
19
21
29
30
32
34
43
44
45
46
47
48
49
50
51
52];

%measured metabolites; row indices
measured = [2
4
9
12
19
29
30
32
34
43
44
];

%theoretically constrainted to be zero metabolites, row indices
known = [
45
46
47
48
49
50
51
52
];

k = [measured ; known];
% solve for fluxes of reactions that touch external metabolites
SM_E = SM_forward(k,:);
[SM_E, dropped] = stripZeroCol(SM_E);

% find the internal only matrix
internalMets = setdiff(1:52,k);
SM_IU = SM_forward(internalMets,dropped);

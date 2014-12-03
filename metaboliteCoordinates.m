function metaboliteCoordinates()

%{
Glucose
ATP
Glucose-6-Phosphate
ADP
Fructose-6-Phosphate
Fructose-1,6,bisphosphate
dihydroxyacetone phosphate
glyceraldehyde-3-phosphate
NAD+
Inorganic Phosphate
1,3-bisphosphoglycerate
NADH
H+
3-Phosphoglycerate
2-Phosphoglycerate
Phosphoenolpyruvate
Water
Pyruvate
HS-CoA
Acetyl-CoA
Carbon Dioxide
Oxaloacetate
Citrate
Cis-aconitate
Isocitrate
Oxalosuccinate
Alpha-ketoglutarate
Succinyl CoA
GDP
GTP
Succinate
FAD
Fumarate
FADH2
L-Malate
p-glucanolactone
6-P-gluconate
ribulose-5-phosphate
ribose-5-phosphate
xylulose-5-phosphate
sedoheptulose-7-phosphate
Erythrose-4-phosphate
NADP+
NADPH
Q
Hmatrix+
QH2
HIMS+
Cytochrome C3+
Cytochrome C2+
Oxygen
OH
%}

COOR = zeros(29,2);

short = 2;
medium = 5;
long = 10;

% glucose intake remains at 0,0
% from fructose to TCA we have 8 reactions, one after the other
% these start at 45 deg downwards from the origin
COOR(2,:) = X1(COOR(1,:),-pi/4,medium);
RI = 3; % RI: reaction index
for i = 1:7
    COOR(RI,:) = X1(COOR(RI - 1,:),0,short);
    RI = RI + 1;
end

% TCA cycle is arranged next to the pre-TCA reactions. the 10 reactions are
% arranged circularly
center = COOR(RI-1,:) + [short + medium, 0];
offset = pi;
angleProgression = 2 * pi / 10;
for i = 0:9
    angle = offset + (i * angleProgression);
    COOR(RI,:) = X1(center,angle,medium);
    RI = RI + 1;
end

% Glucose can also be diverted and turned into ribose, etc. we have four
% reactions that branch from the glucose intake and progress horizontally
% as well, from a 45 deg branch
COOR(RI,:) = X1(COOR(1,:),pi/4,medium);
RI = RI + 1;
for i = 1:3
    COOR(RI,:) = X1(COOR(RI-1,:),0,short);
    RI = RI + 1;
end

% Add the reactions in the electron transport chain
COOR(RI,:) = X1(COOR(1,:),-pi/4,long); % add them to the bottom of graph
RI = RI + 1;
for i = 1:4
    COOR(RI,:) = X1(COOR(RI-1,:),0,short);
    RI = RI + 1;
end

% Add in the alternative pathway (pyr->oaa)
COOR(RI,:) =  ( COOR(8,:) + COOR(19,:) ) / 2 ;
RI = RI + 1;

%Add in another alternative pathway (pyr->mal)
COOR(RI,:) = (COOR(18,:) + COOR(19,:)) / 2;
COOR(RI,:) = X1(COOR(RI,:),-pi/4,short);


for i = 1:30
    makeSquare(COOR(i,:),1,'red');
    text(COOR(i,1),COOR(i,2),int2str(i));
end

end
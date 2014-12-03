% compute the locations of the reactions
% from these, compute the locations of the metabolites
% from these, compute the locations of the lines
% from all locations, plot the things in order:
% lines, reactions, metabolites.
function [RX,MT,LIN] = febsfigure1()
% start out with the relative locations of the reactions.
% these are locations as measured from the reaction immediately preceding
% it in the sequence
long = 12;
medium = 6;
short = 3;
down = -pi/4;
up = pi/4;
sup = pi/2;
sdown = -pi/2;
G1  = [0,0];
G2  = [down,medium];
G3  = [0,short];
G4  = [0,short];
G5  = [up,short];
G6  = [down,short];
G7  = [0,short];
G8  = [0,short];
G9  = [0,short];
G10 = [0,short];
AP1 = [down,short];
PP  = [sup,short]; % preceded by AP1
RX = zeros(37,2);
directions = [
    G1;G2;G3;G4;G5;G6;G7;G8;G9;G10;AP1;PP
    ];
for i=2:12
    RX(i,:) = X1(RX(i - 1,:),directions(i,1),directions(i,2));
end
RX(13:22,:) = round(X1(RX(12,:),0,short + medium) ,10,medium);

PPS1 = [up,medium];
PPS2 = [0,short];
PPS3 = [0,short];
PPS4 = [up,short];
PPS5 = [sdown,short];
PPS6 = [0,short];
PPS7 = [0,short];
PPS8 = [0,short];
PPS9 = [0,short];
RX(23,:) = X1(RX(1,:),PPS1(1),PPS1(2));
direction = [
    PPS1;PPS2;PPS3;PPS4;PPS5;PPS6;PPS7;PPS8;PPS9
    ];
for i=24:31
    RX(i,:) = X1(RX(i-1,:),direction(i-22,1),direction(i-22,2));
end
MT = 0;
LIN = 1;
ETC1 = [down,long];
ETC2 = [0,short];
ETC3 = [0,short];
ETC4 = [0,short];
ETC5 = [0,short];
RX(32,:) = X1(RX(1,:),ETC1(1),ETC1(2));
direction = [
    ETC2;ETC3;ETC4;ETC5
    ];
for i=33:36
    RX(i,:) = X1(RX(i-1,:),direction(i-32,1),direction(i-32,2));
end
for i=1:37
    makeSquare(RX(i,:),1,'red');
end
end

%returns a circle of n spokes
function CIRC = round(center,n,radius)
CIRC = zeros(n,2);
offset = pi;
angleProgression = 2 * pi / n;
for i = 0:(n-1)
    angle = offset + (i * angleProgression);
    CIRC(i+1,:) = X1(center,angle,radius);
end
end
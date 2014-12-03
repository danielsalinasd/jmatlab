% returns the relative coordinates of each of the 29 reactions currently in
% the network
function [COOR,LIN] = reactionCoordinates()
COOR = zeros(29,2);

short = 4;
medium = 10;
long = 20;

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

% Lin is a set of indices indicating which two coordinates should be
% connected
LIN = zeros(23,2);
LI = 1;
for i = 3:19
    LIN(LI,:) = [i - 1; i];
    LI = LI + 1;
end
LIN(LI,:) = [19,10];
LI = LI + 1;
LIN(LI,:) = [21,20];
LI = LI + 1;
LIN(LI,:) = [22,21];
LI = LI + 1;
LIN(LI,:) = [8,29];
LI = LI + 1;
LIN(LI,:) = [29,10];
LI = LI + 1;
LIN(LI,:) = [30,19];
end

% takes an ordered pair X0 and returns an ordered pair X1 which is at
% 'angle' and 'distance' from X0
% 'angle' is in radians
function x1 = X1(X0,angle,distance)
x1 = zeros(1,2);
x1(1) = X0(1) + cos(angle) * distance;
x1(2) = X0(2) + sin(angle) * distance;
end
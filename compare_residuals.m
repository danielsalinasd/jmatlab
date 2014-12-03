% takes a 2D array R where each column is a residual
% makes a bar graph comparing each residual to the other
% there is a bar for every element of a residual, and a bar for each
% residual. the bars will have a different color, but if the number of
% columns exceeds 64, the bars adjacent to each other might share a color
% also displays their L2 norm
function compare_residuals(R)
[r,c] = size(R);

%display the l2 norm
for i = 1:c
    residual = R(:,i);
    disp(norm(residual));
end


%plot the bar graphs
width = 1 / c; %with is reduced with the number of bars to fit in one slot
location = 1:r ;% location of each bar
color = linspace(1,64,c);
cm = colormap('jet');
hold on
for i = 1:c
    loc = location + ((i - 1) * width);
    col = cm( round(color(i)), : );
    bar(loc',R(:,i),width,'FaceColor',col);
end
set(gca,'Xtick',1:r);
hold off

end
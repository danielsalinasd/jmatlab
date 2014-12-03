% takes a column vector F or length m and returns an m by 3 matrix with rgb
% values corresponding to each of the elements in F
function COLORS = colorSquares(F)
[R,~] = size(F);
COLORS = zeros(R,3);

% normalize the vectors according to the flux of glucose intake
% IMPORTANT: this assumes that glucose intake is the very fist reaction
%if F(1) ~= 0
    %F = F / abs(F(1)) ;
%end
% this left commented out intentionally: glucose concentration info is of
% low quality

disp(F);

% jet color map, blue to red going by way of green and yellow
% cmap is actually just a 64 by 3 matrix
% row 64 is deep red, row 1 is deep blue, so all we have to do is map the
% values in F to a row of cmap
% this is done by progressing evenly from 1 to 63
cmap = colormap('jet');
aMax = max(abs(F));
%normalize, this turns every value in index to something between -1 and 1
INDEX = F / aMax ;
% now transforminto rows. the following transformation yields a min of 1
% and a max of 63, since rows start with 1, we couldn't do the
% multiplication by 32 directly since this yields an index of 0, so in the
% end row 64 is never used even for a value of 1
INDEX = (INDEX * 31) + 32 ;
INDEX = round(INDEX);

for i = 1:R
    COLORS(i,:) = cmap(INDEX(i),:);
end

% make the colorbar. linspace calculates 21 numbers spread evenly between 1
% and 63, this leads to a progression by threes, the important thing is
% that 32 is a member of this linspace (so we'll get a tick for the 0 flux)
yticks = linspace(1,63,21);
% the labels correct for the normalization performed for the conversion to
% indices
% use the following line if you want a colorbar.
%colorbar('YTick',yticks,'YTickLabel',linspace(-aMax,aMax,21));
end
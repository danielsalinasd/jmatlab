% compare vectors F1 and F2. REMEMBER: F1 = PINV, F2 = SLASH
function fluxscatter(F1,F2)
hold on
scatter(F1,F2);
%plot line x = y there
% the sorting is done so the line is neat
[F1s,~] = sort(F1);
plot(F1s,F1s,'red');
xlabel('PINV');
ylabel('SLASH');
hold off
end
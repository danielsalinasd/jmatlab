% do some similarity measures, requires the import of two flux vectors
% called typeII and typeVI, plus running the setup_workspace script

modes = null(SM);

typeIInm = typeII - projection(typeII,modes);
typeVInm = typeVI - projection(typeVI,modes);

% calculate the angle between the empirical and theoretical vectors
tII_fe15 = vector_angles(typeIInm,fe15p);
tII_fe30 = vector_angles(typeIInm,fe30p);
tII_fc15 = vector_angles(typeIInm,fc15p);
tII_fc30 = vector_angles(typeIInm,fc30p);

tVI_fe15 = vector_angles(typeVInm,fe15p);
tVI_fe30 = vector_angles(typeVInm,fe30p);
tVI_fc15 = vector_angles(typeVInm,fc15p);
tVI_fc30 = vector_angles(typeVInm,fc30p);


metabolite_names = {
    '1,3-bisphosphoglycerate';
'3-phosphoglycerate';
'6-p-gluconate';
'a-ketoglutarate';
'acetyl coa';
'adenosine triphosphate';
'adp';
'citrate';
'd-fructose 1,6-bisphosphate';
'fad';
'fadh2';
'fumarate';
'gdp';
'glucose';
'gtp';
'hs-coa';
'isocitric acid';
'l-malate';
'nad +';
'nadh';
'nadp +';
'nadph';
'oxalacetate';
'p-glucanolactone';
'phosphoenolpyruvate';
'pyruvate';
'sedoheptulose-7-phosphate';
'succinate';
'succinyl coa';
};

for i=1:29
    figure()
    hold on
    plot([0 15 30],exavg(i,:),'red')
    plot([0 15 30],cnavg(i,:))
    title(metabolite_names{i});
    legend('experimental','control');
    hold off
end
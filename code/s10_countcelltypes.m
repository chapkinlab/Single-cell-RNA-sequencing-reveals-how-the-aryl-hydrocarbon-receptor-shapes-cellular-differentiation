load cleandata_sce.mat
[c,cL]=grp2idx(sce.c_cell_type_tx);
a1=grpstats((sce.c_batch_id),c,@(x)sum(x==1));
a2=grpstats((sce.c_batch_id),c,@(x)sum(x==2));
figure;
bar([a1,a2])
%set(gca,'XTick',a-b);
set(gca,'XTickLabel',strrep(cL,'_','\_'));
set(gca,'XTickLabelRotation',45);
legend({'WT','KO'})
ylabel('Number of cells')

%%
figure;
bar([a1./sum(a1),a2./sum(a2)])
%set(gca,'XTick',a-b);
set(gca,'XTickLabel',strrep(cL,'_','\_'));
set(gca,'XTickLabelRotation',45);
legend({'WT','KO'})
ylabel('Portion of cells')

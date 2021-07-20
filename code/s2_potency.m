% figure; pkg.i_violinplot_groupordered(sce.list_cell_attributes{2},sce.c_cell_type_tx);
a=ls('data_*');
for k=1:size(a,1)
    load(a(k,:));
    subplot(3,3,k)
    pkg.i_violinplot(sce.list_cell_attributes{2},sce.c_batch_id);
    [~,p]=kstest2(sce.list_cell_attributes{2}(sce.c_batch_id==1),sce.list_cell_attributes{2}(sce.c_batch_id==2));
    ss=deblank(strrep(extractAfter(a(k,:),5),'_','\_'));
    ss=ss(1:end-4);
    title(sprintf('%s\np=%g',ss,p));
end
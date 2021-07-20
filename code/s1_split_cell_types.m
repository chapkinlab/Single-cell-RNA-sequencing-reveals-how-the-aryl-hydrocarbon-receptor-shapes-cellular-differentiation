 load ../data/cleandata_sce.mat
 sceori=sce;
%%
a=unique(sceori.c_cell_type_tx);
b=matlab.lang.makeValidName(a);
for k=1:length(a)
    k
    sce=selectcells(sceori,sceori.c_cell_type_tx==a(k));
    T=run_mast(sce.X(:,sce.c_batch_id==1),sce.X(:,sce.c_batch_id==2),sce.g);
    save(sprintf('data_%s',b(k)),'sce','T');
end
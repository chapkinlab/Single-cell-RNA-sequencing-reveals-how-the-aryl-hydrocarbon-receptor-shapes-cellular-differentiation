load ../data/cleandata_sce.mat
sceori=sce;
a=unique(sceori.c_cell_type_tx);
b=matlab.lang.makeValidName(a);

%%
for kk=1:length(a)
    kk
    load(sprintf('data_%s',b(kk)),'sce','T');
T.genelist=T.gene;
T.drdist=T.avg_logFC+abs(min(T.avg_logFC))+0.01;
Tf=e_fgsearun(T);
save(sprintf('data_%s',b(kk)),'Tf','-append');

    % t=T(T.p_val_adj<0.05 & abs(T.avg_logFC)>=0.5,:);
    t=T(T.p_val_adj<0.01,:);
    if size(t,1)>0
        figure;        
        for k=1:min([36 length(t.gene)])
            subplot(6,6,k)
            i=sce.g==t.gene(k);
            pkg.i_violinplot(log2(1+sce.X(i,:)),...
                      sce.c_batch_id);
            title(t.gene(k))
        end        
    end
    if length(t.gene)>36
    suptitle(sprintf('%s\ncell num=%d (36 out of %d DE genes)',...
        strrep(b(kk),'_','\_'),sce.numcells,length(t.gene)));
    else
    suptitle(sprintf('%s\ncell num=%d (%d DE genes)',...
        strrep(b(kk),'_','\_'),sce.numcells,length(t.gene)));        
    end
end


load ../data/cleandata_sce.mat
sce=sce.rmmtgenes;
sce=sce.rmribosomalgenes;
[X,g]=sc_selectg(sce.X,sce.g,1,0.1);
T=sc_hvg(X,g,true,false);
%%
markerlist=T.genes(4001:6000);
numfig=length(markerlist);

pkg.i_markergeneshtml2(sce,markerlist,numfig);
 
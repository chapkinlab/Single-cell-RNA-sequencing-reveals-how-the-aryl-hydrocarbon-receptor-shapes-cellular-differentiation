load ../data/cleandata_sce.mat
sce=sce.rmmtgenes;
sce=sce.rmribosomalgenes;
%cd mrk

i=sce.c_cell_type_tx=="DCS (type 1)" | sce.c_cell_type_tx=="DCS (type 2)";
sce.c_cell_type_tx(i)="DCS";
i=sce.c_cell_type_tx=="Goblet (type 1)" | sce.c_cell_type_tx=="Goblet (type 2)";
sce.c_cell_type_tx(i)="Goblet";


[c,cL]=grp2idx(sce.c_cell_type_tx);
X=[]; sz=[]; cc=[];
for k=1:length(cL)
    i=c==k;
    X=[X sce.X(:,i)];
    sz=[sz sum(i)];
    cc=[cc; c(i)];
end

%%
subi=1:10:size(X,2);
M=cell(numel(cL),2);
for k=1:numel(cL)
    [markerlist]=sc_pickmarkers(sce.X,sce.g,c,k);
    %htmlfilename=cL{k};
    %pkg.i_markergeneshtml(sce,markerlist,50,[],htmlfilename);

    cLk=matlab.lang.makeValidName(cL{k});
    M{k,1}=cLk;
    M{k,2}=markerlist(1:50);    
end

s7_refinemarkers;

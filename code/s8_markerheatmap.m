load ../data/cleandata_sce.mat
X=sce.X;
%X=sc_transform(sce.X);
X=sc_norm(X);
X=log2(X+1);
g=sce.g;

m_ncsc=["Ung","Acot1","Lgr5","Birc5","Top2a","Gjb3","Ascl2","Ccdc34","Soat1","Ung","Acot1","Lgr5","Birc5","Top2a","Gjb3","Ascl2","Ccdc34","Soat1"];
m_csc=["Kcnq1","Mki67","PCNA","Smoc2","Stmn1","Tifa","Tuba1b","Tubb5","Aqp1","Lgr5","Ascl2","Ube2c"];
m_tac=["Nrarp","Ifngr2","Sfn"];
m_ec=["Maob","Ces2a","Ces2c","Ces2e","Chp2","Coro2a","Cyp2c65","Cyp2c68","Dgkq","Dpep1","Emp1","Krt20","Cdkn1a","Lgals3","Mxd1","Sprr2a3","Fam3b","Clec2h","Fhl1","Gde1","Guca2a","Il18"];
m_eec=["Chgb","Bex2","Pcsk1","Marcksl1"];
m_goblet=["Syt7","Ang","MUC2","Agr2","Ccl9","Anxa3","Bcas1","Fcgbp","Mlph","Rab27b","Rep15","Sytl2","Cbfa2t3","Etv5","Galnt5","Galnt10","Kcnh3","Kcnk6","Mon1a","Mt3","Sec24d","Sidt1","Stk38l","Tpd52l1","Ccl6","Fam103a1","Foxa3","Guca2b","Rassf6","Spink4","Guca2a","Tff3"];
m_dcs=["Clec2h","Fhl1","Spink1","Zg16","Tff3","Copz2","Reg4","Dll4","Dll1"];
m_ecl=["ID1","Id3","Fgfbp1","Gjb3"];
m_tuft=["Cacna1a","Cryba2","Vwa5b2","Insm1","Rimbp2","Neurod1"];
%%

m_ncsc=[];
m_csc=[];
m_tac=[];
m_ec=[];
m_eec=[];
m_goblet1=["Tceal9","Ubb","Reep5","Rnase4","Slc39a7","Sec61g","2010107E04Rik","Txndc5","Gfpt1","Sim14","Muc2","Tspan13","Cgref1","Fxyd3","Sytl2","Slc39a7","Klk1","Agr2"];
m_goblet2=[];
m_dcs1=["Mptx1","Gal3st2c","Tff3","Lrrc26","Ccl6","Best2","St3gal6","Rep15"];
m_dcs2=["Cracr2b"];
% m_tuft=["Cacna1a","Cryba2","Vwa5b2","Insm1","Rimbp2","Neurod1"];



%%
M=[m_ncsc m_csc m_tac m_ec m_eec m_goblet m_dcs m_ecl];
[~,idx_g]=ismember(upper(M),upper(g));
%[c,cL]=grp2idx(sce.c_cell_type_tx);
%[c,idx_c]=sort(c);
X=X(idx_g,:);
%x=X(:,idx_c);

%%
y=[];
c=[];
sz=[length(m_ncsc) length(m_csc) length(m_tac) length(m_ec) length(m_eec) length(m_goblet) length(m_dcs) length(m_ecl)];
i=sce.c_cell_type_tx=="Non cycling SC";
y=[y X(:,i)]; c=[c ones(1,sum(i))];
i=sce.c_cell_type_tx=="Cycling SC";
y=[y X(:,i)]; c=[c 2*ones(1,sum(i))];
i=sce.c_cell_type_tx=="TA";
y=[y X(:,i)]; c=[c 3*ones(1,sum(i))];
i=sce.c_cell_type_tx=="EC";
y=[y X(:,i)]; c=[c 4*ones(1,sum(i))];
i=sce.c_cell_type_tx=="EEC";
y=[y X(:,i)]; c=[c 5*ones(1,sum(i))];
i=sce.c_cell_type_tx=="Goblet (type 1)";
y=[y X(:,i)]; c=[c 6*ones(1,sum(i))];
i=sce.c_cell_type_tx=="DCS (type 1)";
y=[y X(:,i)]; c=[c 7*ones(1,sum(i))];
i=sce.c_cell_type_tx=="DCS (type 2)";
y=[y X(:,i)]; c=[c 8*ones(1,sum(i))];

%%

i=1:5:size(y,2);
cc=c(i);
xx=y(:,i);

figure;
% xx=quantilenorm(xx')';
imagesc(xx);

% figure;
% pkg.heatmap(xx, M,...
%     'ShowAllTicks', true);
% set(gca,'YTick',1:size(xx,1));

% axis xy
szc=cumsum(sz);
for k=1:max(cc)-1
    xline(sum(cc<k+1)+0.5,'w-');
    yline(szc(k)+0.5,'w-');
end
% a=colormap('autumn');
% a(1,:)=[.8 .8 .8];
% colormap(a);
set(gca,'YTick',1:size(xx,1));
set(gca,'YTickLabel',M);







%%
% clf
% pkg.heatmap(xx, [], [], '%0.2f', 'TextColor', 'w', ...
%         'Colormap', 'copper', 'Colorbar', true);
% snapnow





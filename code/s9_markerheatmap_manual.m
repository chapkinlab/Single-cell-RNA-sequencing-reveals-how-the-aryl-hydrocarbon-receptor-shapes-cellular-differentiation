load ../data/cleandata_sce.mat
%sce=sce.rmmtgenes;
%sce=sce.rmribosomalgenes;
%%
Xori=sce.X;
%X=sc_transform(sce.X);
g=sce.g;
load selectedmarkers.mat

m_ncsc=marker_NoncyclingSC(1:9);
m_csc=marker_CyclingSC(1:9);
m_tac=marker_TA(1:9);
m_ec=marker_EC(1:9);
m_eec=marker_EEC(1:9);
m_goblet=marker_Goblet(1:9);
m_dcs=marker_DCS(1:9);
m_tuft=marker_TuftCell(1:9);

%{
m_goblet1=["Tceal9","Ubb","Reep5","Rnase4","Slc39a7","Sec61g","2010107E04Rik","Txndc5","Gfpt1","Sim14","Muc2","Tspan13","Cgref1","Fxyd3","Sytl2","Slc39a7","Klk1","Agr2"];
m_goblet2=[];
m_dcs1=["Mptx1","Gal3st2c","Tff3","Lrrc26","Ccl6","Best2","St3gal6","Rep15"];
m_dcs2=["Cracr2b"];
% m_tuft=["Cacna1a","Cryba2","Vwa5b2","Insm1","Rimbp2","Neurod1"];
%}


%%
M=[m_ncsc; m_csc; m_tac; m_ec; m_eec; m_goblet; m_dcs; m_tuft];
% M=unique(M,'stable');
[~,idx_g]=ismember(upper(M),upper(g));
X=Xori(idx_g,:);

X=sc_norm(X);
X=log2(X+1);


y=[];
c=[];
sz=[length(m_ncsc) length(m_csc) length(m_tac) length(m_ec) length(m_eec) length(m_goblet) length(m_dcs) length(m_tuft)];
i=sce.c_cell_type_tx=="Noncycling SC";
y=[y X(:,i)]; c=[c ones(1,sum(i))];
i=sce.c_cell_type_tx=="Cycling SC";
y=[y X(:,i)]; c=[c 2*ones(1,sum(i))];
i=sce.c_cell_type_tx=="TA";
y=[y X(:,i)]; c=[c 3*ones(1,sum(i))];
i=sce.c_cell_type_tx=="EC";
y=[y X(:,i)]; c=[c 4*ones(1,sum(i))];
i=sce.c_cell_type_tx=="EEC";
y=[y X(:,i)]; c=[c 5*ones(1,sum(i))];
i=sce.c_cell_type_tx=="Goblet (type 1)" | sce.c_cell_type_tx=="Goblet (type 2)";
y=[y X(:,i)]; c=[c 6*ones(1,sum(i))];
i=sce.c_cell_type_tx=="DCS (type 1)" | sce.c_cell_type_tx=="DCS (type 2)";
y=[y X(:,i)]; c=[c 7*ones(1,sum(i))];
i=sce.c_cell_type_tx=="Tuft cell";
y=[y X(:,i)]; c=[c 8*ones(1,sum(i))];



i=1:20:size(y,2);
cc=c(i);
xx=y(:,i);

figure;
% xx=quantilenorm(xx')';
    xx=zscore(xx,0,2);
    qx=quantile(xx(:),0.90);
    xx(xx>qx)=qx;
    qx=quantile(xx(:),0.10);
    xx(xx<qx)=qx;    
    imagesc(xx);

% figure;
% pkg.heatmap(xx, M,...
%     'ShowAllTicks', true);
% set(gca,'YTick',1:size(xx,1));

% axis xy
szc=cumsum(sz);
for k=1:max(cc)-1
    xline(sum(cc<k+1)+0.5,'r-');
    yline(szc(k)+0.5,'r-');
end
% a=colormap('autumn');
% a(1,:)=[.8 .8 .8];
% colormap(a);
set(gca,'YTick',1:size(xx,1));

set(gca,'XTick',[])
% set(gca,'YTick',[])
set(gca,'YTickLabel',M);
set(gca,'TickLength',[0 0])
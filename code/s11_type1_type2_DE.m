load ../data/cleandata_sce.mat
i=sce1.c_cell_type_tx=="Goblet (type 1)";
j=sce1.c_cell_type_tx=="Goblet (type 2)";
goblet_T1_WT_type1_vs_2=run.MAST(sce1.X(:,i),sce1.X(:,j),sce1.g);

%%
i=sce2.c_cell_type_tx=="Goblet (type 1)";
j=sce2.c_cell_type_tx=="Goblet (type 2)";
goblet_T2_KO_type1_vs_2=run.MAST(sce2.X(:,i),sce2.X(:,j),sce2.g);

%%

i=sce1.c_cell_type_tx=="DCS (type 1)";
j=sce1.c_cell_type_tx=="DCS (type 2)";
dcs_T1_WT_type1_vs_2=run.MAST(sce1.X(:,i),sce1.X(:,j),sce1.g);
i=sce2.c_cell_type_tx=="DCS (type 1)";
j=sce2.c_cell_type_tx=="DCS (type 2)";
dcs_T2_KO_type1_vs_2=run.MAST(sce2.X(:,i),sce2.X(:,j),sce2.g);

save s11_type1_type2_DE_res -append dcs*

writetable(dcs_T1_WT_type1_vs_2,'dcs_T1_WT_type1_vs_2.xlsx')
writetable(dcs_T2_KO_type1_vs_2,'dcs_T2_KO_type1_vs_2.xlsx')
writetable(goblet_T1_WT_type1_vs_2,'goblet_T1_WT_type1_vs_2.xlsx');
writetable(goblet_T2_KO_type1_vs_2,'goblet_T2_KO_type1_vs_2.xlsx');

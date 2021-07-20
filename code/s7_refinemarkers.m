
subi=1:10:size(X,2);
for k=1:numel(cL)
    markerlist=M{k,2};
    cLk=M{k,1};
    [~,idx_g]=ismember(upper(markerlist),upper(sce.g));
    xx=X(idx_g,subi);
    ccc=cc(subi);
    FigureHandle=figure;
    hAx = axes('Parent',FigureHandle);
    UitoolbarHandle = uitoolbar( 'Parent', FigureHandle ) ; 
    pt3 = uipushtool(UitoolbarHandle,'Separator','off');
    pt3.Tooltip = 'Select a gene to show expression';
    
    cLk=matlab.lang.makeValidName(cL{k});
    pt3.ClickedCallback = {@callback_PickMarkerGene,...
        markerlist,cLk};
[img,map] = imread(fullfile(matlabroot,...
            'toolbox','matlab','icons','greencircleicon.gif'));
ptImage = ind2rgb(img,map);

pt3.CData = ptImage;
    
    xxx=zscore(xx,0,2);
    qx=quantile(xxx(:),0.90);
    xxx(xxx>qx)=qx;

    %qx=quantile(xx(:),0.95);
    %xx(xx>qx)=qx;
%{    
xxk=xx;
try
for ix=1:size(xx,2)
    thisc=xx(ix,:);    
    [~,thisidx]=sort(thisc);
    thisa=ksdensity(thisc,"NumPoints",size(xx,2));
    thisc(thisidx)=thisa;
    xxk(ix,:)=thisc;
end
catch ME
    disp(ME)
end
%}    
    imagesc(xxx)
    
    for kk=1:max(ccc)-1
        xline(sum(ccc<kk+1)+0.5,'w-');
        % yline(szc(kk)+0.5,'w-');
    end
    set(gca,'YTick',1:size(xx,1));
    set(gca,'YTickLabel',markerlist);
    title(strrep(cLk,'_','\_'));
end

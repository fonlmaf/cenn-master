%main process of detection of masses in mammogram images using CeNN.
%allBinary_edge_detection is the same as allMIAS_segmentation as this stage.



% allBinary_edge_detection( '.\CENNFIG\all-mias\bmp\','.\CENNFIG\all-mias\Binary_edge_detection' );
% 
% %Step1
% allPreprocessing( '.\CENNFIG\all-mias\bmp\', '.\CENNFIG\all-mias\Binary_edge_detection\','.\CENNFIG\all-mias\Preprocessing' );
% allMIAS_segmentation( '.\CENNFIG\all-mias\Preprocessing\','.\CENNFIG\all-mias\Segmentation\');

%Step2
%allPreprocessing( '.\CENNFIG\all-mias\Preprocessing\', '.\CENNFIG\all-mias\Segmentation\','.\CENNFIG\all-mias\Preprocessing' );
%allMIAS_segmentation( '.\CENNFIG\all-mias\Preprocessing\','.\CENNFIG\all-mias\Segmentation\');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%get MIAS database information
% a=textread('.\CENNFIG\all-mias\database.txt','%s');
% k=0;
% database={};
% for i=1:length(a)
%     if strfind(a{i},'mdb')
%         k=k+1;
%         database{k}=a{i};
%     else
%     database{k}=strcat(database{k},'-',a{i});
%     end
% end
%  
% 
% %%%Crop the images to obtain ROI and get Severity of abnormality
% Severity=[];
% ii=1;
% for i=1:length(database)
%     S = regexp(database{i}, '-', 'split');
%     if length(S)==7
%         if S{4}=='B' Severity(ii)= 1; %Benign 1,malignant 0
%         else  Severity(ii)= 0; end
%         iid=strcat('.\CENNFIG\all-mias\bmp\',S(1),'.bmp');
%         inputfile=imread(iid{1});
%         x=str2num(S{5}); y=str2num(S{6}); r=str2num(S{7});
%         outputfile=imcrop(inputfile,[x-r,y-r,2*r,2*r]);
%         oid=strcat('.\CENNFIG\all-mias\ROI\',num2str(ii,'%03d'),'.bmp');
%         imwrite(outputfile,oid,'bmp');
%         ii=ii+1;
%     end
% end
% xlswrite('Severity',Severity',1,'A');
%% Severity
% Severity=xlsread('Severity.xls','sheet1','A1:A119')';
% 
% 
%% Çå¿ÕÎÄ¼þ
% delete('.\CENNFIG\all-mias\Preprocessing\*.bmp');
% delete('.\CENNFIG\all-mias\Segmentation\*.bmp');
% delete('.\CENNFIG\all-mias\post_processing\*.bmp');
% delete('.\CENNFIG\all-mias\post_processingmask\*.bmp');
% 
% 
%% Preprocessing
% allPreprocessing2( '.\CENNFIG\all-mias\ROI\','.\CENNFIG\all-mias\Preprocessing' );
%%%Segmentation based on CeNN
allMIAS_segmentation( '.\CENNFIG\all-mias\Preprocessing\','.\CENNFIG\all-mias\Segmentation\');
%%%%post processing
Post_processing('.\CENNFIG\all-mias\Segmentation\','.\CENNFIG\all-mias\post_processing\','.\CENNFIG\all-mias\post_processingmask\');
%%%%%feature extration
[Features,Names]  = Feature_extraction_selection('.\CENNFIG\all-mias\post_processing\','.\CENNFIG\all-mias\post_processingmask\'); 
%% Classification preparation
Features_cls={};
Severity_cls=[];
Names_cls={};
ii=1;
for i=1:length(Features)
    %if any(isnan( Features{i}))==0
        Features_cls{ii}=Features{i};
        Severity_cls(ii) =Severity(str2num(strrep(Names{i},'.bmp','')));
        Names_cls{ii}=Names{i};
        ii=ii+1;
    %end
end
    

%%%Classification
accuracysum=[];
epochsum=[];
for i_cls=1:24 %%%#test
%MLP read data
%train data
% trains=[];
% trains_res=[];
% 
% %test data
% test=[];
% test_res=[];
% test_name={};
% %random
% p=randperm(length(Features_cls));
% rant=sort(p(1:10));
% %
% ii=1;
% jj=1;
% for i=1:length(Features_cls)
%     if ii<=length(rant) && i==rant(ii)
%         for j=1:19
%             test(ii,j)=Features_cls{i}(j);
%         end
%         test_res(ii,1)=Severity_cls(i);
%         test_name(ii,1)=Names_cls(i);
%         ii=ii+1;
%     else
%         for j=1:19
%             trains(jj,j)=Features_cls{i}(j);
%         end
%         trains_res(jj,1)=Severity_cls(i);
%         jj=jj+1;
%     end
% end





%%Classification
%MLP read data
%train data
trains=[];
trains_res=[];
%test data
test=[];
test_res=[];
for i=1:(length(Features_cls)-10)
%for i=1:length(Features_cls)
        for j=1:19
            trains(i,j)=Features_cls{i}(j);
        end
        trains_res(i,1)=Severity_cls(i);
end


for i=1:10
    for j=1:19
        test(i,j)=Features_cls{length(Features_cls)-10+i}(j);
    end
    test_res(i,1)=Severity_cls(length(Features_cls)-10+i);
% end
end


[accuracy,epoch] = BP_MLP(trains, trains_res,test,test_res);
accuracysum(i_cls)=accuracy;
epochsum(i_cls)=epoch;
end
accuracymean=mean(accuracysum(:));
epochmean=mean(epochsum(:));




    




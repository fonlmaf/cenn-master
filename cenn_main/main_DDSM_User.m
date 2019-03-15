% clear all 
addpath('..\matCNN');%('C:/matCNN');
%% get MIAS database information
%a=textread('E:\CeNNfile\matCNN\CENNFIG\all-mias\database.txt','%s');
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
%%%%%%%%%%%%%%%%%%
% Severity=xlsread('Severity.xls','sheet1','A1:A119')';
% 
% 
% %%%%ï¿½ï¿½ï¿½ï¿½Ä¼ï¿?
% delete('.\CENNFIG\all-mias\Preprocessing\*.bmp');
% delete('.\CENNFIG\all-mias\Segmentation\*.bmp');
% delete('.\CENNFIG\all-mias\post_processing\*.bmp');
% delete('.\CENNFIG\all-mias\post_processingmask\*.bmp');
% 
% DDSM 
%%%Preprocessing
%allPreprocessingDDSM( 'E:\CeNNfile\DDSM\PNGFiles\','E:\CeNNfile\DDSM\Preprocessing\' );
%%Segmentation based on CeNN
allMIAS_segmentation( 'E:\CeNNfile\DDSM\Preprocessing\','E:\CeNNfile\DDSM\Segmentation\');
%%%post processing
%Post_processingDDSM('E:\CeNNfile\DDSM\Segmentation\','E:\CeNNfile\DDSM\post_processing\','E:\CeNNfile\DDSM\post_processingmask\');

%%---------------------------------------------------
%%%%feature extration
%  [Features,Names]  = Feature_extraction_selection_DDSM('..\Imgextraction\' ,'..\testset\'); 

%% Save Feature
% Featuresmat=[];
% for i=1:length(Features)
%     for j=1:length(Features{i})
%         Featuresmat(i,j)=Features{i}(j);
%     end
% end
%save features Features_train Features_test Names_test Names_train
% xlswrite('..\Features_test',Featuresmat,'A');
% xlswrite('..\Names_test',Names,'A');

%%%ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
%% load Features
load features; 

%% Severity
% Features_cls={};
% Severity_cls=[];
% Names_cls={};
% ii=1;
% for i=1:length(Features_test)
%     %if any(isnan( Features{i}))==0
%         Features_cls{ii}=Features_test{i};
%         if (str2num(Names_test{i}(3:6))<21) || ((str2num(Names_test{i}(3:6))>3000) && (str2num(Names_test{i}(3:6))<3087))
%             Severity_cls(ii)=0;
%         else Severity_cls(ii)=1;
%         end
%         Names_cls{ii}=Names_test{i};
%         ii=ii+1;
%     %end
% end
% 
% %trainset_severity
% Features_cls2={};
% Severity_cls2=[];
% Names_cls2={};
% ii=1;
% for i=1:length(Features_train)
%     %if any(isnan( Features{i}))==0
%         Features_cls2{ii}=Features_train{i};
%         if (str2num(Names_train{i}(3:6))<21) || ((str2num(Names_train{i}(3:6))>3000) && (str2num(Names_train{i}(3:6))<3087))
%             Severity_cls2(ii)=0;
%         else Severity_cls2(ii)=1;
%         end
%         Names_cls2{ii}=Names_train{i};
%         ii=ii+1;
%     %end
% end
    
%% Classification1
 accuracysum=[];
 epochsum=[];
% %%MLP read data
% %%train data
trains=[];
trains_res=[];

%test data
test=[];
test_res=[];
%test_name={};
%trains_name={};
p=randperm(length(Features_train));
rant=sort(p(1:27));
ii=1;
%jj=1;

for i=1:length(Features_train)
    if ii<=length(rant) && i==rant(ii)
        for j=1:19
            test(ii,j)=Features_test{i}(j);
        end
        test_res(ii,1)=Labels_test(i);
        %test_name(ii,1)=Names_cls(i);
        for j=1:19
            trains(ii,j)=Features_train{i}(j);
        end
        trains_res(ii,1)=Labels_train(i);
        %trains_name(ii,1)=Names_cls2(i);
        ii=ii+1;
    end
end

%% Random trainset
%%%random
% p=randperm(length(Features_cls));
% rant=sort(p(1:30));
% %
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
%         trains_name(jj,1)=Names_cls(i);
%         jj=jj+1;
%     end
% end

% xlswrite('E:\CeNNfile\DDSM\trains_name1',trains_name,'A');
%% Given trainset
% [trainnumnull,train_name]=xlsread('E:\CeNNfile\DDSM\trains_name1','A');
% for i=1:length(Features_cls)
%     if   jj<=length(train_name) && strcmpi(Names_cls(i),train_name(jj))
%         for j=1:19
%             trains(jj,j)=Features_cls{i}(j);
%         end
%         trains_res(jj,1)=Severity_cls(i);
%         trains_name(jj,1)=Names_cls(i);
%         jj=jj+1;
%     else
%         for j=1:19
%             test(ii,j)=Features_cls{i}(j);
%         end
%         test_res(ii,1)=Severity_cls(i);
%         test_name(ii,1)=Names_cls(i);
%         ii=ii+1;
%     end
% end

%% Test
for i_cls=1:3 
[accuracy,epoch] = BP_MLP(trains, trains_res,test,test_res);
 

accuracysum(i_cls)=accuracy;
epochsum(i_cls)=epoch;
end
accuracymean=mean(accuracysum(:));
accuracymax=max(accuracysum(:));
epochmean=mean(epochsum(:));




    




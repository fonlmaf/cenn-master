%main process of detection of masses in mammogram images using CeNN.
%allBinary_edge_detection is the same as allMIAS_segmentation as this stage.

%% load Features
Featuresmat=xlsread('.\Features','A');
Features={};
[fh,fw]=size(Featuresmat);
 for i=1:fh
     for j=1:fw
         Features{i}(j)=Featuresmat(i,j);
     end
 end
[Namenull,Names]=xlsread('.\Names','A');

%% Severity
Features_cls={};
Severity_cls=[];
Names_cls={};
ii=1;
for i=1:length(Features)
    %if any(isnan( Features{i}))==0
        Features_cls{ii}=Features{i};
        if (str2num(Names{i}(3:6))<21) || ((str2num(Names{i}(3:6))>3000) && (str2num(Names{i}(3:6))<3087))
            Severity_cls(ii)=0;
        else Severity_cls(ii)=1;
        end
        Names_cls{ii}=Names{i};
        ii=ii+1;
    %end
end
    
%% Classification1
%accuracysum=[];
%epochsum=[];
%for i_cls=1:26 %%%#test
%%MLP read data
%%train data
trains=[];
trains_res=[];

%test data
test=[];
test_res=[];
test_name={};
%random
p=randperm(length(Features_cls));
rant=sort(p(1:31));
%
ii=1;
jj=1;
for i=1:length(Features_cls)
    if ii<=length(rant) && i==rant(ii)
        for j=1:19
            test(ii,j)=Features_cls{i}(j);
        end
        test_res(ii,1)=Severity_cls(i);
        test_name(ii,1)=Names_cls(i);
        ii=ii+1;
    else
        for j=1:19
            trains(jj,j)=Features_cls{i}(j);
        end
        trains_res(jj,1)=Severity_cls(i);
        jj=jj+1;
    end
end


%% Test
[accuracy,epoch] = BP_MLP_DDSM(trains, trains_res,test,test_res);

%% if recurrent
% accuracysum(i_cls)=accuracy;
% epochsum(i_cls)=epoch;
% end
% accuracymean=mean(accuracysum(:));
% accuracymax=max(accuracysum(:));
% epochmean=mean(epochsum(:));

%SAVE
xlswrite('testind',rant',1,'A');




    




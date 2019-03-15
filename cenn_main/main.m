%% main function

tic 
clc 
clear 
close all 
addpath('../matCNN');%('C:/matCNN');

LB= -8 * ones(19,1);      %lower bounds of variables 
UB=  8 * ones(19,1);        %upper bounds of variables 
paraNum=11; % bias doexn't need logintize
%paperTemp=[-0.3912  4.6618  4.9898 2.8552 7.1702 2.8552 4.9898 4.6618 -0.3912 2.5636  4.9664 -2.9539 2.5140 3.2211 2.5140 -2.9539 4.9664 2.5636 -6.3426];
%paperTemp=[-0.3912  4.6618  4.9898 2.8552 7.1702  2.5636  4.9664 -2.9539 2.5140 3.2211  -6.3426];
paperTemp=[5.1745    6.8103    5.7743    4.8261   -8.0000   -6.2985    5.2414    4.5789    8.0000    7.9368    0.4404];
% train the dataset with no freeze
[optPara,optObj,optRecord]=train_PSO(paraNum,UB,LB,paperTemp)

%debug1=['[optParameter, optObj',num2str(iter),',optRecord',num2str(iter),']=train_PSO(freeze,test_image,paraNum,UB,LB,paperTemp)'];
%debug2=['save optData',num2str(iter),'.mat ','optObj',num2str(iter), ' optRecord',num2str(iter)];
eval(['[optParameter, optObj',num2str(iter),',optRecord',num2str(iter),']=train_PSO(freeze,test_image,paraNum,UB,LB,paperTemp)']);
%eval(['save optData',num2str(iter),'.mat ','optObj',num2str(iter), ' optRecord',num2str(iter)]);

%% final value  
disp('job done!');


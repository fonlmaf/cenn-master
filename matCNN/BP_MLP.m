%%%%%%%BP������matlabԴ������룩 %******************************%             

%%%ѧϰ����   %******************************% %======ԭʼ��������========  
function[acs,epoch] = BP_MLP(p, t,test,test_res) 
%p=[2845 2833 4488;2833 4488 4554;4488 4554 2928;4554 2928 3497;2928 3497  2261;...  3497 2261 6921;2261 6921 1391;6921 1391 3580;1391 3580 4451;3580 4451  2636;...  4451 2636 3471;2636 3471 3854;3471 3854 3556;3854 3556 2659;3556 2659  4335;...  2659 4335 2882;4335 2882 4084;4335 2882 1999;2882 1999 2889;1999 2889  2175;...  2889 2175 2510;2175 2510 3409;2510 3409 3729;3409 3729 3489;3729 3489  3172;...  3489 3172 4568;3172 4568 4015;]';    
%===========�������=======  

%t=[4554 2928 3497 2261 6921 1391 3580 4451 2636 3471 3854 3556 2659 ... 4335 2882 4084 1999 2889 2175 2510 3409 3729 3489 3172 4568 4015 ... 3666];    ptest=[2845 2833 4488;2833 4488 4554;4488 4554 2928;4554 2928 3497;2928  3497 2261;...  3497 2261 6921;2261 6921 1391;6921 1391 3580;1391 3580 4451;3580 4451  2636;...  4451 2636 3471;2636 3471 3854;3471 3854 3556;3854 3556 2659;3556 2659  4335;...  2659 4335 2882;4335 2882 4084;4335 2882 1999;2882 1999 2889;1999 2889  2175;...  2889 2175 2510;2175 2510 3409;2510 3409 3729;3409 3729 3489;3729 3489  3172;...  3489 3172 4568;3172 4568 4015;4568 4015 3666]';      
[inputn,inputps]=mapminmax(p');
[outputn,outputps]=mapminmax(t');%�����ݹ�һ�� 
outputps.ymin=0;
[outputn,outputps]=mapminmax(t',outputps);
%[pn,minp,maxp,tn,mint,maxt]=premnmx(p,t); %�����ݹ�һ��     
NodeNum1 = 19; % �����һ��ڵ���  
NodeNum2= 19;   % ����ڶ���ڵ���    
TypeNum = 1;   % ���ά��   
TF1 = 'logsig'; 
TF2 = 'logsig';  
TF3 = 'logsig';  
net=newff(minmax(inputn),[NodeNum1,NodeNum2, TypeNum],{TF1 TF2 TF3},'trainlm'); 
%���紴��trainlm 
net.trainParam.show=1;   %��ʾ��� 
net.trainParam.epochs=1000; %ѵ����������  
net.trainParam.goal=1e-11; %ѵ����Ҫ�ﵽ�ľ���                                                                                                                                                              
net.trainParam.lr=0.01;   %ѧϰ���� 
%net.trainParam.lr_inc = 1.05;  
[net,tr]=train(net,inputn,outputn);      
epoch=tr.num_epochs;

%test program
p2n=mapminmax('apply',test',inputps);%�������ݵĹ�һ�� 
an=sim(net,p2n);   %���
[a]=mapminmax('reverse',an,outputps);   %output����һ�� ����������õ���Ԥ���� 
test_res=test_res';
%plot(1:length(test_res),test_res,'o',1:length(test_res),a,'+');  
%title('+��ʾԤ��ֵ--- o��ʾʵ��ֵ') 
%grid on  
m=length(a);     %����a�ĳ��� 
t1=[test_res,a(m)];  
error=test_res-a;     %������� 
%figure  
%plot(1:length(error),error,'-.')  
%title('���仯ͼ')  
%grid on
 acs=0;
 for i=1:length(error)
     if abs(error(i))<0.5
         acs=acs+1;
     end
 end
 acs=acs/length(error);
end
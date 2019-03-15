function [optPara,optObj,optRecord]=train_PSO(paraNum,UB,LB,paperTemp)

rng default   

% pso parameters values 
% paraNum  number of variables 
n=20;% population size 


wmax=0.9;  % inertia weight 
wmin=0.4;  % inertia weight 
c1=1.4;   % acceleration factor 
c2=1.2;   % acceleration factor 

% pso main program----------------------------------------------------start
maxite=50;    % set maximum number of iteration  
maxrun=20;      % set maximum number of runs (templates) need to be 
%maxite=1;maxrun=1;
optRecord=zeros(maxrun,paraNum);
optObj=zeros(maxrun,1);


for step=1:maxrun     
    fprintf('step%d\n',step);     
% pso initialization----------------------------------------------start     
    for i=1:n         
        for j=1:paraNum 
            if(i==1)
                x0(i,j)=paperTemp(j);
            else
                %x0(i,j)=round(LB(j)+rand()*(UB(j)-LB(j)));    
                x0(i,j)=(LB(j)+rand()*(UB(j)-LB(j)));     
            end
%             if(j<paraNum) 
%                 if(freeze(j,1)==1) 
%                     x0(i,j)=freeze(j,2); 
%                 end
%             end
        end
    end
        
    x=x0; % initial population     
    v=0.1*x0; % initial velocity     
    
    for i=1:n   
        TempA = zeros(3); 
        TempA(1,1)=x(i,1);     TempA(1,2)=x(i,2);     TempA(1,3)=x(i,3);    
        TempA(2,1)=x(i,4);     TempA(2,2)=x(i,5);     TempA(2,3)=x(i,4);   
        TempA(3,1)=x(i,3);     TempA(3,2)=x(i,2);     TempA(3,3)=x(i,1);
        TempB = zeros(3); 
        TempB(1,1)=x(i,6);   TempB(1,2)=x(i,7);    TempB(1,3)=x(i,8);    
        TempB(2,1)=x(i,9);   TempB(2,2)=x(i,10);   TempB(2,3)=x(i,9);   
        TempB(3,1)=x(i,8);   TempB(3,2)=x(i,7);    TempB(3,3)=x(i,6);
        bias = x(i,11);
        f0(i,1)=objFunc(TempA,TempB,bias);   
        fprintf('initial%d\n',i);
    end     
    [fmin0,index0]=min(f0);  
    
    pbest=x0;    % initial pbest     
    gbest=x0(index0,:);  % initial gbest     
% pso initialization------------------------------------------------end 

% pso algorithm---------------------------------------------------start     
    ite=1;         
    tolerance=1;     
    while ite<=maxite && tolerance>10^-12                  
        w=wmax-(wmax-wmin)*ite/maxite; % update inertial weight    
        
        % pso velocity updates         
        for i=1:n             
            for j=1:paraNum       
                v(i,j)=w*v(i,j)+c1*rand()*(pbest(i,j)-x(i,j))...
                    +c2*rand()*(gbest(1,j)-x(i,j));             
            end
        end
        % pso position update         
        for i=1:n             
            for j=1:paraNum  
%                 if(j<paraNum) 
%                     if(freeze(j,1)==1) 
%                         x0(i,j)=freeze(j,2); 
%                     end
%                 else
                    x(i,j)=x(i,j)+v(i,j);      
%                end
            end
        end
        
        % handling boundary violations         
        for i=1:n             
            for j=1:paraNum                 
                if x(i,j)<LB(j)                     
                    x(i,j)=LB(j);                
                elseif x(i,j)>UB(j)                     
                    x(i,j)=UB(j);                 
                end
            end
        end
        
        % evaluating fitness         
        for i=1:n  
            TempA = zeros(3); 
            TempA(1,1)=x(i,1);     TempA(1,2)=x(i,2);     TempA(1,3)=x(i,3);    
            TempA(2,1)=x(i,4);     TempA(2,2)=x(i,5);     TempA(2,3)=x(i,4);   
            TempA(3,1)=x(i,3);     TempA(3,2)=x(i,2);     TempA(3,3)=x(i,1);
            TempB = zeros(3); 
            TempB(1,1)=x(i,6);   TempB(1,2)=x(i,7);    TempB(1,3)=x(i,8);    
            TempB(2,1)=x(i,9);   TempB(2,2)=x(i,10);   TempB(2,3)=x(i,9);   
            TempB(3,1)=x(i,8);   TempB(3,2)=x(i,7);    TempB(3,3)=x(i,6);
            bias = x(i,11);
            f(i,1)=objFunc(TempA,TempB,bias);
            %fprintf('evaluating%d\n',i);
        end
        
        % updating pbest and fitness        
        for i=1:n             
            if f(i,1)<f0(i,1)
               pbest(i,:)=x(i,:);                 
               f0(i,1)=f(i,1);             
            end
        end
        
        [fmin,index]=min(f0); % finding out the best particle        
        ffmin(ite,step)=fmin;  % storing best fitness         
        ffite(step)=ite;       % storing iteration count           

        % updating gbest and best fitness         
        if fmin<fmin0             
            gbest=pbest(index,:);             
            fmin0=fmin;         
        end
        
        % calculating tolerance         
        if ite>100;             
            tolerance=abs(ffmin(ite-100,step)-fmin0);         
        end
        
        % displaying iterative results         
        if ite==1             fprintf('Iteration    Best particle    Objective fun\n');         end         
        fprintf('%8g__%8g__%8.4f\n',ite,index,fmin0);             
        ite=ite+1;     
    end     
  
        % pso algorithm-----------------------------------------------------end     
        gbest;
        optObj(step)=fmin0;   
        optRecord(step,:)=gbest;     
        fprintf('--------------------------------------\n'); 
end 
[temp,index]=min(optObj);
optPara = optRecord(index,1:paraNum);

save Para2 optObj optRecord;

fprintf('--------------------------------------\n'); 


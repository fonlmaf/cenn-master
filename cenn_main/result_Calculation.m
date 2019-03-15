%%%%% this is a verifying test for paper <Particle Swarm Optimization for
%%%%% Image Noise Cancellation>
% by xiaowei Xu in 12/28/2016
Atem_stepPaper = [0.86    0.94    3.75; 
                  2.11    -2.81   3.75;
                 -1.33   -2.58   -1.02];
Btem_stepPaper = [0.16    -1.56   1.25;
                 -2.89    1.09    -3.2; 
                  4.06    4.69    3.75];
BIAS_stepPaper = 1.8;

Atem_stepDouble = [0.86    0.94    3.75; 
                  2.11    -2.81   3.75;
                 -1.33   -2.58   -1.02];
Btem_stepDouble = [0.16    -1.56   1.25;
                 -2.89    1.09    -3.2; 
                  4.06    4.69    3.75];
BIAS_stepDouble = 1.8;


% Atem_stepDouble = [-0.365857672092043	3.89445430381114	-1.91739587440502; 
%                   -1.44538162857834	0.631796663884677	1.75442534761415;
%                  3.72247986861105	-0.769768337156100	1.62220898213312];
% Btem_stepDouble = [3.88622534642041	1.67965901696016	1.41728574359915;
%                  2.03227695037377	-0.161094099121114	1.62163454409788; 
%                  -3.29310448866507	-3.95021376510622	-0.257228877172601];
% BIAS_stepDouble = -1.88591030734203;

% Atem_stepFreeze = [-0.0625    1.0000    2.0000;
%                     4.0000   -4.0000    4.0000;
%                    -1.0000   -0.5000    2.0000];
% Btem_stepFreeze = [ 0.2500   -2.0000    2.0000;
%                     4.0000    0.2500    4.0000;
%                    -1.0000   -8.0000    1.0000];
% BIAS_stepFreeze = -1.3061;



% train with median image
% x2= [1.47544052614115,1.30217010374463,3.77895016417064,2.85155248640597,-1.71845056631750,0.758642306266276,1.63566289746029,-3.47914396982286,3.63037714680103,-3.46535602691177,2.57747027077616,-2.21584925328819,-2.17782233586182,-2.20683253518250,1.26691083903706,2.66013389941924,2.40621698408006,-0.804696150559595,0.157669567547001];
% % train with original image
% x3=[1.72334300636051,2.28064964036346,3.97801137179157,3.17705406092102,0.0632513742288285,-0.237242013835578,-1.13348596537947,1.88535638817767,1.27738227958663,3.38258550986472,-1.17015514817093,-1.16697720653232,2.22694465295573,-1.80415180843676,-1.35091022358963,-2.85197891898048,-0.888574204242977,-0.562006478671025,0.210800165552141];
% % train with tiny step
% x4=[3.25710674555519,1.65641346968122,0.0979607579420971,0.630605089510923,1.72174951488238,-1.29154770989029,2.31477801372575,0.742193167769962,2.86412219975368,1.13324456094211,-1.43449505270359,3.46089734966352,0.333990121207386,2.53989487143280,-2.11764872461269,0.0433297743396111,-1.37940611481618,-2.63370338597572,0.595962828025879];
% %train with try
%x=[-1.74464049100509,2.17492632953940,-1.55454314892243,3.87261351718252,2.93020294753586,2.77404055606930,2.38756414803857,-2.77931096970199,0.175201202409008,2.46543721605194,0.744777098955765,-0.412652966209165,2.10914871924313,0.808093820572387,-2.34449541989064,-3.64951020972551,2.71406967305732,3.46694361650124,3.45306549639424];
% %train with try 2
%x=[0.860000000000000,0.940000000000000,3.75000000000000,2.11000000000000,-2.81000000000000,3.75000000000000,-1.33000000000000,-2.58000000000000,-1.02000000000000,0.160000000000000,-1.56000000000000,1.25000000000000,-2.89000000000000,1.09000000000000,-3.20000000000000,4.06000000000000,4.69000000000000,3.75000000000000,1.80000000000000];
% try 0.5
%%x=[4,-2,4,1,-2,2,2,1,2,-0.500000000000000,1,2,1,1,-4,-0.500000000000000,4,-1,2.87874242371185];

% star=1 quan=1;
%x=[4,-2,4,1,-2,2,2,1,2,-0.500000000000000,1,2,1,1,-4,-0.500000000000000,4,-1,2.87874242371185];


%% 16,8,4,2,1
% 8
%x=[-0.125 1.0000 2.0000     4.0000 -4.0000 4.0000   -1.0000 -0.5000 2.0000      0.2500   -2.0000    2.0000  4.0000    0.2500    4.0000  -1.0000   -8.0000    1.0000 -1.3061 ];
% 4
%x=[0 1.0000 2.0000     4.0000 -4.0000 4.0000   -1.0000 -0.5000 2.0000      0.2500   -2.0000    2.0000  4.0000    0.2500    4.0000  -1.0000   -4.0000    1.0000 -1.3061 ];
% 2
%x=[0 1.0000 2.0000     2.0000 -2.0000 2.0000   -1.0000 -0.5000 2.0000      0.500   -2.0000    2.0000  2.0000    0.500    2.0000  -1.0000   -8.0000    1.0000 -1.3061 ];
% 1
%x=[0	1	2	2	-2	2	-1	-0.5	2	0	-2	2	2	0.25	2	-1	-2	1	-1.3061 ];
% 0
%x=[0	1	1	1	-1	1	-1	-1	1	0	-1	1	1	0	1	-1	-1	1	-1.3061];

%% new obj
%x=[-2.86851430468235,2.20690652111572,1.88111548580687,1.06783488356031,-0.130996334042137,2.21528989057169,-2.22111412358477,0.522119657759562,3.78515325151210,0.295797445628179,1.74109722209758,3.98389303947011,-1.38225592171927,3.73192159725991,2.65895565059792,0.301531471838770,0.368680804975672,-3.00613207254423,1.43473232156002];
% stra=2 quan=1
%x=[-2,-1,4,2,-4,4,4,-4,4,4,-1,4,4,4,4,-4,-4,-4,1.33572533756493];
% stra=1 quan=1
%x=[2,4,2,-2,1,-4,4,0.500000000000000,4,0.250000000000000,-2,4,4,4,2,-2,-2,-4,0.861694705114094];
% stra=1 quan=2
%x=[-2,2,2,1,-0.250000000000000,2,-2,-0.500000000000000,4,0.250000000000000,1,4,-1,4,2,2,0.250000000000000,-4,1.02441200662190];
% stra=2 quan=2
%x=[-2,2,4,4,-4,2,-2,-1,4,-4,-4,4,4,4,2,-2,2,-4,-0.132340915511005];
% stra=3,quan=1
%x=[4,0.500000000000000,0.500000000000000,1,-0.250000000000000,-0.250000000000000,2,0.500000000000000,-1,0.250000000000000,2,4,-4,-2,-4,0.250000000000000,1,-1,-0.297821907318098];
% stra=3 quan=2
%x=[1,2,2,1,-0.250000000000000,4,1,0.500000000000000,4,0.250000000000000,0.500000000000000,4,4,0,4,0.250000000000000,0.250000000000000,-4,0.740873633161556];

%% new 2
%x=[-0.365857672092043,3.89445430381114,-1.91739587440502,-1.44538162857834,0.631796663884677,1.75442534761415,3.72247986861105,-0.769768337156100,1.62220898213312,3.88622534642041,1.67965901696016,1.41728574359915,2.03227695037377,-0.161094099121114,1.62163454409788,-3.29310448866507,-3.95021376510622,-0.257228877172601,-1.88591030734203];
% stra=1,quan=2
%x=[-0.250000000000000,0.500000000000000,0.250000000000000,-1,0.500000000000000,2,2,-1,2,4,2,1,2,-0.250000000000000,2,-4,-4,-2,0.535557407260134];
% stra=2 quan=1
%x=[4,4,-4,2,-4,2,2,4,4,4,-1,-2,4,-4,4,4,-4,-2,-0.733089656661063];
% stra=1 quan=1
% x=[2,4,-2,-0.500000000000000,-0.500000000000000,2,4,-2,2,1,2,1,-2,-0.250000000000000,1,-4,-1,-1,-0.670198985917535];
% stra=2 quan=2
x=[-1,4,-2,2,-2,2,4,-4,4,4,2,-4,2,1,0.500000000000000,-4,-4,2,0.412899705342778];
% stra=3 quan=1
%x=[-2,4,-2,-0.250000000000000,-1,2,0.500000000000000,0.500000000000000,4,-2,2,2,2,-0.250000000000000,-4,-4,-4,-0.250000000000000,1.47114729104232];
% stra=3 quan=2
%x=[-0.250000000000000,4,-2,-0.250000000000000,0.500000000000000,2,-0.500000000000000,0.500000000000000,4,4,2,2,2,-0.250000000000000,-1,-0.500000000000000,-4,-0.250000000000000,-1.25545659101862];

%% quan 2-2
% 0
%x=[1,1,-1,-1,-1,1,1,1,1,1,1,0,1,1,1,-1,-1,-1,0.286909680756218];
% 1
%x=[1,2,-2,2,-2,2,2,-1,2,2,2,2,2,-0.500000000000000,1,-2,-2,2,1.21831643504169];
% 2
%x=[-1,4,-2,2,-2,2,4,-4,4,4,2,-4,2,1,0.500000000000000,-4,-4,2,0.412899705342778];
% 3
%x=[2,4,-2,1,-4,2,4,-1,4,4,2,2,2,-1,8,-4,-4,-8,1.07204809618458];
% 4
%x=[8,4,-2,16,-8,2,4,4,4,4,2,8,2,16,8,-4,-4,-16,2.37838822705261];

%% more
% 2-1
%x=[4,4,-4,2,-4,2,2,4,4,4,-1,-2,4,-4,4,4,-4,-2,-0.733089656661063];
% 2-2
%x=[-1,4,-2,2,-2,2,4,-4,4,4,2,-4,2,1,0.500000000000000,-4,-4,2,0.412899705342778];
% 3-1
%x=[-2,4,-2,-0.250000000000000,-1,2,0.500000000000000,0.500000000000000,4,-2,2,2,2,-0.250000000000000,-4,-4,-4,-0.250000000000000,1.47114729104232];
% 3-2
%x=[-0.250000000000000,4,-2,-0.250000000000000,0.500000000000000,2,-0.500000000000000,0.500000000000000,4,4,2,2,2,-0.250000000000000,-1,-0.500000000000000,-4,-0.250000000000000,-1.25545659101862];

test_image1 = lbmp2cnn('TX_RACC_median_1.bmp');
test_image2 = lbmp2cnn('TX_RACC_median_2.bmp');
test_image3 = lbmp2cnn('TX_RACC_median_3.bmp');
test_image4 = lbmp2cnn('TX_RACC_median_4.bmp');
[m,n] = size(test_image1);
test_image =zeros(4,m,n);
test_image(1,:,:)=test_image1; test_image(2,:,:)=test_image2; test_image(3,:,:)=test_image3; test_image(4,:,:)=test_image4; 

addpath('C:/matCNN');
%addpath('D:/Dropbox/HardwareDesignND_Cellular/Target Tracking/matCNN');

boundryType = 2;
tempID=2;
iterNum=1;
stepTime=4;
useTrainImage=0;
useOriginImage=1;

Gerror=zeros(tempID*stepTime,iterNum);
result=zeros(tempID*stepTime,iterNum);

total=zeros(tempID*stepTime,3);

for iter_tempID=1:tempID
    for iter_stepTime=1:stepTime
        for iter_iterNum=1:iterNum
%             if(iter_tempID==2) 
%                 x=x4;
%             elseif(iter_tempID==3)
%                 x=x3;
%             end
            TempA = zeros(3); 
            TempA(1,1)=x(1);     TempA(1,2)=x(2);     TempA(1,3)=x(3);    
            TempA(2,1)=x(4);     TempA(2,2)=x(5);     TempA(2,3)=x(6);   
            TempA(3,1)=x(7);     TempA(3,2)=x(8);     TempA(3,3)=x(9);
            TempB = zeros(3); 
            TempB(1,1)=x(10);   TempB(1,2)=x(11);   TempB(1,3)=x(12);    
            TempB(2,1)=x(13);   TempB(2,2)=x(14);   TempB(2,3)=x(15);   
            TempB(3,1)=x(16);   TempB(3,2)=x(17);   TempB(3,3)=x(18);
            bias = x(19);

            if(useOriginImage==1)
                input = lbmp2cnn('TX_RACC.bmp');
                %input = lbmp2cnn('TX_RACC_small.bmp');
                cnn_setenv;
                mCNN.TemGroup = 'temlib';
                mCNN.STATE =  zeros(size(input));
                mCNN.INPUT1 = input;
                mCNN.INPUT2 = input;
                mCNN.Boundary = boundryType;
                mCNN.TimeStep = 1/(2^(iter_stepTime+2));
                mCNN.IterNum = 50*iter_iterNum;
                %loadtem('MEDIAN'); 
                %loadtem('MTYPE1');
                loadtem('EDGE');
                if(iter_tempID == 1)
                    mCNN.Atem = Atem_stepDouble;
                    mCNN.Btem = Btem_stepDouble;
                    mCNN.I = BIAS_stepDouble;
                else
                    mCNN.Atem = TempA;
                    mCNN.Btem = TempB;
                    mCNN.I = bias;
                end
                runtem;

                image=cnn2gray(mCNN.OUTPUT,0);
                %image=mCNN.OUTPUT;
                %imwrite(image,'inputOpt.bmp','bmp');
                imwrite(image,['output_',num2str(iter_tempID),'_',num2str(iter_stepTime),'_',num2str(iter_iterNum),'.bmp'],'bmp');
                % calculate the sum
                [m,n] = size(image);
%                 greyLevel=zeros(4,1);
%                 for i = 1:m/2
%                     for j = 1:n/2
%                         greyLevel(1)=greyLevel(1)+image(i,j);
%                         greyLevel(2)=greyLevel(2)+image(m/2+i,j);
%                         greyLevel(3)=greyLevel(3)+image(i,n/2+j);
%                         greyLevel(4)=greyLevel(4)+image(m/2+i,n/2+j);
%                     end
%                 end
           image=cnn2gray(mCNN.OUTPUT,1);
            windowSize=35;

            %calculate the grey level
            %[m,n] = size(test_image);
            greyLevel=zeros(4,2);
            % for i = 1+floor(windowSize/2):m/2-floor(windowSize/2)
            %     for j = 1+floor(windowSize/2):n/2-floor(windowSize/2)
            %         greyLevel(1,2)=greyLevel(1,2)+image(i,j);
            %         greyLevel(2,2)=greyLevel(2,2)+image(m/2+i,j);
            %         greyLevel(3,2)=greyLevel(3,2)+image(i,n/2+j);
            %         greyLevel(4,2)=greyLevel(4,2)+image(m/2+i,n/2+j);
            %     end
            % end

            greyLevel(1,2)=sum(sum(image(1:m/2,1:n/2)));
            greyLevel(2,2)=sum(sum(image(m/2+1:m,1:n/2)));
            greyLevel(3,2)=sum(sum(image(1:m/2,n/2+1:n)));
            greyLevel(4,2)=sum(sum(image(m/2+1:m,n/2+1:n)));
            %tttt=((m/2-windowSize+1)*(n/2-windowSize+1));
            greyLevel=greyLevel./((m/2)*(n/2));
            greyLevel(1,1)=1;greyLevel(2,1)=2;greyLevel(3,1)=3;greyLevel(4,1)=4;

            GreyNewSort=sortrows(greyLevel,2);
            thresholdAll=zeros(4,2);
            thresholdAll(GreyNewSort(1,1),1)=-1;
            thresholdAll(GreyNewSort(1,1),2)=(GreyNewSort(1,2)+GreyNewSort(2,2))/2;
            thresholdAll(GreyNewSort(2,1),1)=(GreyNewSort(1,2)+GreyNewSort(2,2))/2;
            thresholdAll(GreyNewSort(2,1),2)=(GreyNewSort(2,2)+GreyNewSort(3,2))/2;
            thresholdAll(GreyNewSort(3,1),1)=(GreyNewSort(2,2)+GreyNewSort(3,2))/2;
            thresholdAll(GreyNewSort(3,1),2)=(GreyNewSort(3,2)+GreyNewSort(4,2))/2;
            thresholdAll(GreyNewSort(4,1),1)=(GreyNewSort(3,2)+GreyNewSort(4,2))/2;
            thresholdAll(GreyNewSort(4,1),2)=2;

            error=zeros(1,4);
            for i = 1:m/2
                for j = 1:n/2
                    m_lower = i-floor(windowSize/2);
                    if(m_lower < 1)  m_lower = 1; end
                    m_upper = i+floor(windowSize/2);
                    if(m_upper > m)  m_upper = m; end
                    n_lower = j-floor(windowSize/2);
                    if(n_lower < 1)  n_lower = 1; end
                    n_upper = j+floor(windowSize/2);
                    if(n_upper > n)  n_upper = n; end        
                    averGrey=sum(sum(image(m_lower:m_upper,n_lower:n_upper)));
                    averGrey=averGrey/((m_upper-m_lower+1)*(n_upper-n_lower+1));
                    if(averGrey < thresholdAll(1,1) || averGrey > thresholdAll(1,2) )
                        error(1) = error(1)+1;
                    end

                    m_lower = m/2+i-floor(windowSize/2);
                    if(m_lower < 1)  m_lower = 1; end
                    m_upper = m/2+i+floor(windowSize/2);
                    if(m_upper > m)  m_upper = m; end
                    n_lower = j-floor(windowSize/2);
                    if(n_lower < 1)  n_lower = 1; end
                    n_upper = j+floor(windowSize/2);
                    if(n_upper > n)  n_upper = n; end        
                    averGrey=sum(sum(image(m_lower:m_upper,n_lower:n_upper)));
                    averGrey=averGrey/((m_upper-m_lower+1)*(n_upper-n_lower+1));
                    if(averGrey < thresholdAll(2,1) || averGrey > thresholdAll(2,2) )
                        error(2) = error(2)+1;
                    end

                    m_lower = i-floor(windowSize/2);
                    if(m_lower < 1)  m_lower = 1; end
                    m_upper = i+floor(windowSize/2);
                    if(m_upper > m)  m_upper = m; end
                    n_lower = n/2+j-floor(windowSize/2);
                    if(n_lower < 1)  n_lower = 1; end
                    n_upper = n/2+j+floor(windowSize/2);
                    if(n_upper > n)  n_upper = n; end        
                    averGrey=sum(sum(image(m_lower:m_upper,n_lower:n_upper)));
                    averGrey=averGrey/((m_upper-m_lower+1)*(n_upper-n_lower+1));
                    if(averGrey < thresholdAll(3,1) || averGrey > thresholdAll(3,2) )
                        error(3) = error(3)+1;
                    end

                    m_lower = m/2+i-floor(windowSize/2);
                    if(m_lower < 1)  m_lower = 1; end
                    m_upper = m/2+i+floor(windowSize/2);
                    if(m_upper > m)  m_upper = m; end
                    n_lower = n/2+j-floor(windowSize/2);
                    if(n_lower < 1)  n_lower = 1; end
                    n_upper = n/2+j+floor(windowSize/2);
                    if(n_upper > n)  n_upper = n; end        
                    averGrey=sum(sum(image(m_lower:m_upper,n_lower:n_upper)));
                    averGrey=averGrey/((m_upper-m_lower+1)*(n_upper-n_lower+1));
                    if(averGrey < thresholdAll(4,1) || averGrey > thresholdAll(4,2) )
                        error(4) = error(4)+1;
                    end
                end
            end

            error = error/((m/2)*(n/2));

            [maxError,index]=max(error);
           
                
                %greyLevel=greyLevel./(m*n/4);
            sortValue=sort(greyLevel);
            distance=zeros(3,1);
            inCaseOfZero=0.000000000001;
            distance(1)=abs(sortValue(1,2)-sortValue(2,2))+inCaseOfZero;
            distance(2)=abs(sortValue(2,2)-sortValue(3,2))+inCaseOfZero;
            distance(3)=abs(sortValue(3,2)-sortValue(4,2))+inCaseOfZero;
            [minimal,index]=min(distance);
            %f=minimal;
            elseif(useTrainImage==1)
                [num,m,n] = size(test_image);
                %outImg=zeros(num,m,n);
                greyLevel = zeros(num,1);
                temp = zeros(m,n);

                for iter=1:num
                    cnn_setenv;
                    mCNN.TemGroup = 'temlib';
                    mCNN.STATE =  zeros(m,n);
                    %mCNN.Boundary = 2;
                    mCNN.Boundary = boundryType;
                    mCNN.TimeStep = 1/(2^(iter_stepTime+2));
                    mCNN.IterNum = 50*iter_iterNum;
                    loadtem('EDGE');
                    if(iter_tempID == 1)
                        mCNN.Atem = Atem_stepDouble;
                        mCNN.Btem = Btem_stepDouble;
                        mCNN.I = BIAS_stepDouble;
                    else
                        mCNN.Atem = TempA;
                        mCNN.Btem = TempB;
                        mCNN.I = bias;
                    end
                    temp(:,:) = test_image(iter,:,:);
                    mCNN.INPUT1 = temp;
                    runtem;
                    %cnnshow(mCNN.OUTPUT);
                    imwrite(cnn2gray(mCNN.OUTPUT,1),['output_',num2str(iter_tempID),'_',num2str(iter_stepTime),'_',num2str(iter_iterNum),'_',num2str(iter),'.bmp'],'bmp');
                    greyLevel(iter) = sum(sum(cnn2gray(mCNN.OUTPUT,1)));
                end
                greyLevel=greyLevel./(m*n);

                %calculate the object function
                sortValue=sort(greyLevel);
                distance=zeros(3,1);
                inCaseOfZero=0.000000000001;
                distance(1)=abs(sortValue(1)-sortValue(2))+inCaseOfZero;
                distance(2)=abs(sortValue(2)-sortValue(3))+inCaseOfZero;
                distance(3)=abs(sortValue(3)-sortValue(4))+inCaseOfZero;
                [minimal,index]=min(distance);


            end
            result((iter_tempID-1)*stepTime+iter_stepTime,iter_iterNum)=minimal;
            Gerror((iter_tempID-1)*stepTime+iter_stepTime,iter_iterNum)=1-maxError;
            total((iter_tempID-1)*stepTime+iter_stepTime,1)=minimal;
            total((iter_tempID-1)*stepTime+iter_stepTime,2)=1-maxError;
            total((iter_tempID-1)*stepTime+iter_stepTime,3)=minimal*(1-maxError);
        end
    end
end
disp('done!');





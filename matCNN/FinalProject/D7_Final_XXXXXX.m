%%%%%%%%%%%%%%%% MAIN PROGRAM BEGIN %%%%%%%%%%%%%%%%%%%
function D7_Final_XXXXXX(PIC_NUM)
	global mCNN;
    initCNN(PIC_NUM);	
    
	for i=1:PIC_NUM
        % load images, initialize layers
        fname=sprintf('%sinput_%02d.bmp',mCNN.picdir,i); %point to the ith input picture        
        mCNN.LAM_1 = lbmp2cnn(fname);
        
        % vizualize input
        subplot(PIC_NUM,5,5*i-4);
        cnnshow(mCNN.LAM_1);    
        title(['input ',num2str(i)]);        
        
        %% input: LAM_1
        %% output: LAM_2
        %% owerwrite: -
        preproc; %do the preprocessing
        
        % vizualize preproc subtask
        subplot(PIC_NUM,5,5*i-3);
        cnnshow(mCNN.LAM_2);    
        title('after prepoc');                

        %% input: LAM_2
        %% output: LAM_2 LAM_3
        %% owerwrite: LAM_2
        segment; %do the segmentation
        
        % vizualize segment subtask
        subplot(PIC_NUM,5,5*i-2);
        cnnshow(mCNN.LAM_2);    
        title('after prepoc L');                
        subplot(PIC_NUM,5,5*i-1);
        cnnshow(mCNN.LAM_3);    
        title('after prepoc H');                
        
        %% input: LAM_2 LAM_3
        %% output: LAM_1
        %% owerwrite: LAM_1
        cresult=classify; %classify the result
        
        % vizualize output
        subplot(PIC_NUM,5,5*i); 
        cnnshow(mCNN.LAM_1);
        title(['output ',num2str(i),' class: ',num2str(cresult)]);
        
        scnn2bmp(sprintf('output%02d_%d.bmp',i,cresult), mCNN.LAM_1); % write the file to disk (propre filename is important) 
	end

%%%%%%%%%%%%%%%%% MAIN PROGRAM END %%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% INITIALIZATION BEGIN %%%%%%%%%%%%%%%%%%
function initCNN(PIC_NUM)
	global mCNN;
	% set CNN environment
	cnn_setenv; % default environment
	initTemplates;
	% define constants
	mCNN.BLACK=1;
	mCNN.WHITE=-1;
	mCNN.LAMsize=[144,176];
	mCNN.PIC_NUM=PIC_NUM;
	
	% analog memories
	mCNN.LAM_1=zeros(mCNN.LAMsize);
	mCNN.LAM_2=zeros(mCNN.LAMsize);
	mCNN.LAM_3=zeros(mCNN.LAMsize);
	mCNN.LAM_4=zeros(mCNN.LAMsize);
    mCNN.LAM_5=zeros(mCNN.LAMsize);
	mCNN.LAM_6=zeros(mCNN.LAMsize);
 	
	% extra memories
	%mCNN.LAM_7=zeros(mCNN.LAMsize);
	
	%DO NOT TOUCH
	mCNN.picdir='';

%%%%%%%%%%%%%%%% INITIALIZATION  END %%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% EXTRA TEMPLATES BEGIN %%%%%%%%%%%%%%%%%%
function initTemplates
	global mCNN;

    % MYTHRESH    
    mCNN.MYTHRESH_A = [0 0 0;
                       0 2 0;
                       0 0 0];
    mCNN.MYTHRESH_I = -0.6;                      
 
	% LOGAND    
    mCNN.LOGAND_A = [0 0 0;
                      0 2 0;
                      0 0 0];
    mCNN.LOGAND_B = [0 0 0;
                      0 1 0;
                      0 0 0];       
    mCNN.LOGAND_I = -1;
    
    % DIFFUS
    mCNN.DIFFUS_A = [0.10 0.15 0.10;
            0.15 0.00 0.15;
            0.10 0.15 0.10]; 
    mCNN.DIFFUS_I = 0;
    
    % THRES
    mCNN.THRES_A = [0 0 0;
           0 2 0;
           0 0 0];
    mCNN.THRES_I = 0.0;     
%%%%%%%%%%%%%%%%% EXTRA TEMPLATES END %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%% PREPROCESS BEGIN %%%%%%%%%%%%%%%%%%%
%% input: LAM_1
%% output: LAM_2
%% owerwrite: -

function preproc
	global mCNN;
   
    mCNN.INPUT1 = mCNN.LAM_1;
    mCNN.STATE = mCNN.LAM_1;
    
    loadtem('mCNN.DIFFUS'); % loads the DIFFUS template (linear)
    % set boundary condition
    mCNN.Boundary = 2; % zero flux boundary condition    
    mCNN.TimeStep = 0.2;
    mCNN.IterNum = 50;
    mCNN.UseBiasMap=0;
    
    % run linear template        
    runtem; % runs the CNN simulation    
    mCNN.LAM_2=mCNN.OUTPUT;    
    
%%%%%%%%%%%%%%%%% PREPROCESS END %%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%% SEGMENTATION BEGIN %%%%%%%%%%%%%%%%%%%
%% input: LAM_2
%% output: LAM_2 LAM_3
%% owerwrite: LAM_2

function segment
	global mCNN;
    %use LAMO=1*LAMI statement to pass the values whenevwr You use it twice or more for the same LAMO inside the function!!!
    
    mCNN.INPUT1 = 1*mCNN.LAM_2; %use 1* !!!
    mCNN.STATE = 1*mCNN.LAM_2; %use 1* !!!
    
    loadtem('mCNN.MYTHRESH'); % loads the THRES template (linear)        
    % set boundary condition
    mCNN.Boundary = 0; % fixed boundary condition
    mCNN.TimeStep = 0.2;
    mCNN.IterNum = 50;
    mCNN.UseBiasMap=0;

    % run linear template        
    runtem; % runs the CNN simulation    
    mCNN.LAM_3=mCNN.OUTPUT;
    
    mCNN.INPUT1 = 1*mCNN.LAM_2; %use 1* !!!
    mCNN.STATE = 1*mCNN.LAM_2; %use 1* !!!
    
    loadtem('mCNN.THRES'); % loads the THRES template (linear)        
    % set boundary condition
    mCNN.Boundary = 0; % fixed boundary condition
    mCNN.TimeStep = 0.2;
    mCNN.IterNum = 50;
    mCNN.UseBiasMap=0;

    % run linear template        
    runtem; % runs the CNN simulation    
    mCNN.LAM_2=mCNN.OUTPUT;    

%%%%%%%%%%%%%%%%% SEGMENTATION END %%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%% CLASSIFICATION BEGIN %%%%%%%%%%%%%%%%%%%
%% input: LAM_2 LAM_3
%% output: LAM_1
%% owerwrite: LAM_1

function cresult=classify
	global mCNN;
    
    %do XOR operation on  LAM_2 and LAM_3 to  LAM_1 ...
    % mCNN.LAM_1=2*xor((mCNN.LAM_2+1),(mCNN.LAM_3+1))-1; % ... by binary operation
    
    % ... by analogic operation
    mCNN.INPUT1 = -1*mCNN.LAM_3; %load and ivert image
    mCNN.STATE = mCNN.LAM_2;    
     
    loadtem('mCNN.LOGAND'); % loads the defined LOGAND template
    % set boundary condition
    mCNN.Boundary = 0; % fixed boundary condition
    mCNN.TimeStep = 0.2;
    mCNN.IterNum = 50;
    mCNN.UseBiasMap=0;
 
    % run linear template        
    runtem; % runs the CNN simulation    
    mCNN.LAM_1=1*mCNN.OUTPUT;
    
    [x y]=find(mCNN.LAM_1==mCNN.BLACK); %get black pixel coordinates
    cresult=mod(length(x),3)+1; %generate (random) classification number based on the sum of black pixels  

%%%%%%%%%%%%%%%%% CLASSIFICATION END %%%%%%%%%%%%%%%%%%%%%


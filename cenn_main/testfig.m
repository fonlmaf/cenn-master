addpath('E;/code_dataset/matCNN');%('C:/matCNN');
x=[ 5.1745    6.8103    5.7743    4.8261   -8.0000   -6.2985    5.2414    4.5789    8.0000    7.9368    0.4404];
 TempA = zeros(3); 
        TempA(1,1)=x(1);     TempA(1,2)=x(2);     TempA(1,3)=x(3);    
        TempA(2,1)=x(4);     TempA(2,2)=x(5);     TempA(2,3)=x(4);   
        TempA(3,1)=x(3);     TempA(3,2)=x(2);     TempA(3,3)=x(1);
        TempB = zeros(3); 
        TempB(1,1)=x(6);   TempB(1,2)=x(7);    TempB(1,3)=x(8);    
        TempB(2,1)=x(9);   TempB(2,2)=x(10);   TempB(2,3)=x(9);   
        TempB(3,1)=x(8);   TempB(3,2)=x(7);    TempB(3,3)=x(6);
        bias = x(11);


bmps = dir(strcat('..\trainset2\','*(2).bmp'));
num = length( bmps ); 
%num = 2;
diffSum1=zeros(num,1);

for iter=1:num
    png_file=fullfile( '..\trainset2\' , bmps(iter).name );
%     [ path , name , ext ] = fileparts( png_file ) ;  

  % 第二步，生成新的文件名   
    %real=im2double(imread(png_file)); 
    test = lbmp2cnn(fullfile('..\trainset2\' , bmps(iter).name));
    
    [m,n] = size(test);
    cnn_setenv;
    mCNN.TemGroup = 'temlib';
    mCNN.STATE =  zeros(m,n);
    mCNN.Boundary = 2;
    mCNN.TimeStep = 0.125;
    mCNN.IterNum = 50;
    loadtem('EDGE');
    mCNN.Atem = TempA;
    mCNN.Btem = TempB;
    mCNN.I = bias;
    mCNN.INPUT1 = test;
    runtem;
    %cnnshow(mCNN.OUTPUT);
    output = cnn2gray(mCNN.OUTPUT,1);
    
  %% select the core region     
   [L,num]=bwlabel(output,8);
    x=zeros(1,num);
    for ii=1:num
        x(ii)=sum(sum(L==ii));
    end
    [mm,ind]=max(x); %选最大的区域
    out=(L==ind);
    output=out;
    
    imshow(output);
    diff1 = abs(im2bw(output) - im2bw(real));
    diffSum1(iter) = sum(diff1(:))/(m*n);
    
    bedfile=strcat('..\testset\',bmps(iter).name);
    imwrite(output,bedfile,'bmp');
end
avd=mean2(diffSum1(:));

% delete( '..\trainset2\*.bmp');
% delete( '..\trainset2\*(2).bmp');  
function f=objFunc(TempA,TempB,bias)
% objective function (minimization) 


%��ȡѵ���� bmp ��ʽͼƬ  
bmps = dir(strcat('../trainset2/','*(2).bmp'));
num = length( bmps ); 
%num = 2;
f=0;

for iter=1:num
    test = lbmp2cnn((fullfile( '../trainset2/' , bmps(iter).name )));
    real = im2double(imread(fullfile('../trainset2/' , strrep(bmps(iter).name,' (2)','') )));
    %real=imresize(real,0.75);
    %test=imresize(test,0.75);
    
%     if(iter==1)
%         test = lbmp2cnn('132.bmp');
%         real = double(imread('132real.bmp'))/255;
%     elseif(iter==2)
%         test = lbmp2cnn('314.bmp');
%         real = double(imread('314real.bmp'))/255;
%     end
    [m,n] = size(test);
    cnn_setenv;
    mCNN.TemGroup = 'temlib';
    mCNN.STATE =  zeros(m,n);
    mCNN.Boundary = 2;
    mCNN.TimeStep = 0.025;
    mCNN.IterNum = 50;
    loadtem('EDGE');
    mCNN.Atem = TempA;
    mCNN.Btem = TempB;
    mCNN.I = bias;
    mCNN.INPUT1 = test;
    runtem;
    %cnnshow(mCNN.OUTPUT);
    output = cnn2gray(mCNN.OUTPUT,1);
    
    
    [L,num]=bwlabel(output,8);
    if num<300 && num>1
    x=zeros(1,num);
    for ii=1:num
        x(ii)=sum(sum(L==ii));
    end
    [mm,ind]=max(x); %ѡ��������
    out=(L==ind);
    output(out~=1)=0;
    end
    
    %calculate the object function
    diff1 = abs(output - real);
    diffSum1 = sum(sum(diff1));
    diff2 = abs(abs(output - ones(m,n)) - real);
    diffSum2 = sum(sum(diff2));
    
    minimal=min(diffSum1,diffSum2);
    f=f+minimal;
end
 

 

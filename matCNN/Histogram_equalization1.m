
function[ outputfile ] =Histogram_equalization1( inputfile,mask )

%直方图均衡化  
I = imread(inputfile);
mask=imread(mask);
%I= rgb2gray(I);s
mask=im2double(mask);
[height,width] = size(I);  
%figure  
%subplot(221)  
%imshow(I)%显示原始图像  
%subplot(222)  
%imhist(I)%显示原始图像直方图  


%进行像素灰度统计;  
NumPixel = zeros(1,256);%统计各灰度数目，共256个灰度级
SumPixel = 0;
for i = 1:height  
    for j = 1: width  
        if mask(i,j)== 0
            NumPixel(I(i,j)+1) = NumPixel(I(i,j)+1) + 1;%对应灰度值像素点数量增加一
            SumPixel = SumPixel+1;
        end
    end  
end  
%计算灰度分布密度  
ProbPixel = zeros(1,256);  
for i = 1:256  
    ProbPixel(i) = NumPixel(i) / SumPixel;%(height * width * 1.0);  
end  
%计算累计直方图分布  
CumuPixel = zeros(1,256);  
for i = 1:256  
    if i == 1  
        CumuPixel(i) = ProbPixel(i);  
    else  
        CumuPixel(i) = CumuPixel(i - 1) + ProbPixel(i);  
    end  
end  
%累计分布取整  
CumuPixel = uint8(255 .* CumuPixel + 0.5);  
%对灰度值进行映射（均衡化）  
for i = 1:height  
    for j = 1: width  
        I(i,j) = CumuPixel(I(i,j)+1);  
    end  
end  
outputfile = I;
%subplot(223)  
%imshow(I)%显示原始图像  
%subplot(224)  
%imhist(I)%显示原始图像直方图
end
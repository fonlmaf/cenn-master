
function[ outputfile ] =Histogram_equalization1( inputfile,mask )

%ֱ��ͼ���⻯  
I = imread(inputfile);
mask=imread(mask);
%I= rgb2gray(I);s
mask=im2double(mask);
[height,width] = size(I);  
%figure  
%subplot(221)  
%imshow(I)%��ʾԭʼͼ��  
%subplot(222)  
%imhist(I)%��ʾԭʼͼ��ֱ��ͼ  


%�������ػҶ�ͳ��;  
NumPixel = zeros(1,256);%ͳ�Ƹ��Ҷ���Ŀ����256���Ҷȼ�
SumPixel = 0;
for i = 1:height  
    for j = 1: width  
        if mask(i,j)== 0
            NumPixel(I(i,j)+1) = NumPixel(I(i,j)+1) + 1;%��Ӧ�Ҷ�ֵ���ص���������һ
            SumPixel = SumPixel+1;
        end
    end  
end  
%����Ҷȷֲ��ܶ�  
ProbPixel = zeros(1,256);  
for i = 1:256  
    ProbPixel(i) = NumPixel(i) / SumPixel;%(height * width * 1.0);  
end  
%�����ۼ�ֱ��ͼ�ֲ�  
CumuPixel = zeros(1,256);  
for i = 1:256  
    if i == 1  
        CumuPixel(i) = ProbPixel(i);  
    else  
        CumuPixel(i) = CumuPixel(i - 1) + ProbPixel(i);  
    end  
end  
%�ۼƷֲ�ȡ��  
CumuPixel = uint8(255 .* CumuPixel + 0.5);  
%�ԻҶ�ֵ����ӳ�䣨���⻯��  
for i = 1:height  
    for j = 1: width  
        I(i,j) = CumuPixel(I(i,j)+1);  
    end  
end  
outputfile = I;
%subplot(223)  
%imshow(I)%��ʾԭʼͼ��  
%subplot(224)  
%imhist(I)%��ʾԭʼͼ��ֱ��ͼ
end
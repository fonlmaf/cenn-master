clear;clc;
close all;
g0 = imread('C:\Users\zhang\Desktop\1.jpg'); %����ͼ��
g = rgb2gray(g0);%��ʽ�Ҷ�ת��
% g=im2double(g);
% h=fspecial('gaussian',10,5);
% g=imfilter(g,h,'replicate');
figure,imshow(g); %��ʾԭͼ 1
[height,width] = size(g);
for i=1:height      %��ֵ�ָ�
    for j=1:width
        if g(i,j)<50
            g(i,j)=0;
        else 
            g(i,j)=255;
        end
    end
end
figure,imshow(g);   %��ʾ��ֵ�ָ���ͼ�� ͼ2
pp=g;
pp=im2bw(pp,1.5*graythresh(pp));
figure,imshow(pp); %ͼ5
clear;clc;
close all;
g0 = imread('C:\Users\zhang\Desktop\1.jpg'); %读入图像
g = rgb2gray(g0);%格式灰度转换
% g=im2double(g);
% h=fspecial('gaussian',10,5);
% g=imfilter(g,h,'replicate');
figure,imshow(g); %显示原图 1
[height,width] = size(g);
for i=1:height      %阀值分割
    for j=1:width
        if g(i,j)<50
            g(i,j)=0;
        else 
            g(i,j)=255;
        end
    end
end
figure,imshow(g);   %显示阀值分割后的图像 图2
pp=g;
pp=im2bw(pp,1.5*graythresh(pp));
figure,imshow(pp); %图5
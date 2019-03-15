clear;clc;
close all;
g0 = imread('C:\Users\zhang\Pictures\激光图片4.24晚\1.bmp'); %读入图像
% g=g0;
g = rgb2gray(g0);%格式灰度转换
figure,imshow(g); %显示原图 1
[height,width] = size(g);

%% 阀值分割 提取激光线条

for i=1:height      %阀值分割
    for j=1:width
        if g(i,j)<160
            g(i,j)=0;
        else 
            g(i,j)=255;
        end
    end
end
figure,imshow(g);   %显示阀值分割后的图像 图2

%% 对分割后的图像进行开闭环的处理

% se = strel('disk',5);   
% fo=imopen(g,se);   %对图像进行开环操作，消除细小区域
% figure, imshow(fo);
se = strel('disk',2);
foc=imclose(g,se); %对图像进行闭环环操作，使狭小的小区域连接成一个大区域
figure,imshow(foc); %图3

pp=foc;
se = strel('disk',2);
pp=imdilate(pp,se);
figure,imshow(pp);

se = strel('disk',1);   
foc=imerode(foc,se);   %对图像进行腐蚀 为接下来的模板相乘提供依据
TT=foc;                %TT 后面用来作为实物来匹配
figure,imshow(foc); %图4

%% 对上面的图像进行骨架提取，希望能得到一个中心轴的细线

pp=im2bw(pp,1.5*graythresh(pp));
figure,imshow(pp); %图5
ss=bwmorph(foc,'skel',inf);
figure,imshow(ss); %图6
% ss1=bwmorph(ss,'spur',15);
% figure,imshow(ss1); %图7

%% 已知角度预定义，加快响应速度

q=ss;
a=5; %角度的值为0到180度
d=round(sqrt(height^2+width^2)); %图像对角线长度为p的最大值
s=zeros(a,2*d); %存储每个(a,p)个数
z=cell(a,2*d);  %用元胞存储每个被检测的点的坐标
for i=1:height 
    for j=1:width %遍历图像每个点
        if(q(i,j)==1) %只检测图像边缘的白点，其余点不检测
            for k=1:a
                p = round(i*cos(pi*(167+k)/180)+j*sin(pi*(167+k)/180)); %对每个点从1到180度遍历一遍，取得经过该点的所有直线的p值（取整）
                if(p > 0) %若p大于0，则将点存储在（d，2d）空间
                    s(k,p)=s(k,p)+1; %（a，p）相应的累加器单元加一
                    z{k,p}=[z{k,p},[i,j]']; %存储点坐标
                else
                    ap=abs(p)+1; %若p小于0，则将点存储在（0，d）空间
                    s(k,ap)=s(k,ap)+1;  %(a，p)相应的累加器单元加一
                    z{k,ap}=[z{k,ap},[i,j]'];  %存储点坐标
                end
            end
        else
        end
    end
end
l=s(1,1);
for i=1:a 
    for j=1:2*d   %检查每个累加器单元中存储数量      
        if l<s(i,j) 
            l=s(i,j);
            tt=i;
            xx=j;
        else
        end 
    end
end
lp=z{tt,xx};  %提取对应点坐标
o=zeros(height,width);
for k=1:l  %找最大的累加器单元中(a，p)对应的所有点进行操作    
       o(lp(1,k),lp(2,k))=255; 
             end
figure,imshow(o); %图8
title('hough变换提取直线');


%% 粗化模板。并与原来的图片进行匹配

se = strel('disk',5);   %
focmodel=imdilate(o,se);
focmodel= uint16(focmodel);
source=TT;
source=uint16(source);
T=immultiply(focmodel,source);
% se = strel('disk',5);
% T=imopen(T,se);
figure,imshow(T); %图9 匹配结果


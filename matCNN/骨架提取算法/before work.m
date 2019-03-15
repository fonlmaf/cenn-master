clear;clc;
close all;
g0 = imread('D:\design\图像处理\激光照片4.2晚\20.bmp'); %读入图像
g=g0;
% g = rgb2gray(g0);%格式灰度转换
figure,imshow(g); %显示原图1
[height,width] = size(g);
% g = im2double(g); %转为双精度
% g=adpmedian(g,7); %自适应空间滤波
% figure,imshow(g);%图5
% w = fspecial('average', [10 10]); %矩形均值滤波  
% g3 = imfilter(g, w); %滤波
% w = fspecial('disk', 5); %圆形均值滤波
% g4 = imfilter(g, w); %滤波
% figure,imshow(g3);
% figure,imshow(g4);

%% 阀值分割，对感兴趣区域进行提取

for i=1:height      %阀值分割
    for j=1:width
        if g(i,j)<220
            g(i,j)=0;
        else 
            g(i,j)=255;
        end
    end
end
figure,imshow(g);

%%  开环操作，消除细小区域

se = strel('disk',3);   
fo=imopen(g,se);     % 对图像进行开环操作，消除细小区域
figure, imshow(fo);
se = strel('disk',10);
foc=imclose(fo,se);  %对图像进行开环操作，使狭小的小区域连接成一个大区域,
                     % 得到的是一个连接性比较好的光区域
figure, imshow(foc);
pp=foc;

 % % hough变换
pp=im2bw(pp,1.5*graythresh(pp));
figure,imshow(pp); %图5
ss=bwmorph(foc,'skel',inf);
figure,imshow(ss); %图6

q=ss;
a=180; %角度的值为0到180度
d=round(sqrt(height^2+width^2)); %图像对角线长度为p的最大值
s=zeros(2*a,2*d); %存储每个(a,p)个数
z=cell(2*a,2*d);  %用元胞存储每个被检测的点的坐标
for i=1:height 
    for j=1:width %遍历图像每个点
        if(q(i,j)==255) %只检测图像边缘的白点，其余点不检测
            for k=1:2*a
                p = round(i*cos(pi*k/360)+j*sin(pi*k/360)); %对每个点从1到180度遍历一遍，取得经过该点的所有直线的p值（取整）
                if(p > 0) %若p大于0，则将点存储在（2a，2d）空间
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

   
L=0
o=zeros(height,width);
for i=1:2*a 
    for j=1:2*d   %检查每个累加器单元中存储数量      
        if L<s(i,j) 
            L=s(i,j);
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

% se = strel('disk',15); 
% focmodel=imdilate(o,se); % 对找到的曲线进行腐蚀操作，得到匹配模板
% figure,imshow(focmodel);
% focmodel= uint16(focmodel);
% se = strel('disk',4); 
% source=imerode(fo,se);
% figure,imshow(focmodel);
% figure,imshow(source);
% source=uint16(source);
% T=immultiply(focmodel,source);
% % se = strel('disk',5);
% % T=imopen(T,se);
% figure,imshow(T);
% se = strel('disk',15);
% T=imclose(T,se);
% figure,imshow(T);







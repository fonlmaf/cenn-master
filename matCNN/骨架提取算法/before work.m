clear;clc;
close all;
g0 = imread('D:\design\ͼ����\������Ƭ4.2��\20.bmp'); %����ͼ��
g=g0;
% g = rgb2gray(g0);%��ʽ�Ҷ�ת��
figure,imshow(g); %��ʾԭͼ1
[height,width] = size(g);
% g = im2double(g); %תΪ˫����
% g=adpmedian(g,7); %����Ӧ�ռ��˲�
% figure,imshow(g);%ͼ5
% w = fspecial('average', [10 10]); %���ξ�ֵ�˲�  
% g3 = imfilter(g, w); %�˲�
% w = fspecial('disk', 5); %Բ�ξ�ֵ�˲�
% g4 = imfilter(g, w); %�˲�
% figure,imshow(g3);
% figure,imshow(g4);

%% ��ֵ�ָ�Ը���Ȥ���������ȡ

for i=1:height      %��ֵ�ָ�
    for j=1:width
        if g(i,j)<220
            g(i,j)=0;
        else 
            g(i,j)=255;
        end
    end
end
figure,imshow(g);

%%  ��������������ϸС����

se = strel('disk',3);   
fo=imopen(g,se);     % ��ͼ����п�������������ϸС����
figure, imshow(fo);
se = strel('disk',10);
foc=imclose(fo,se);  %��ͼ����п���������ʹ��С��С�������ӳ�һ��������,
                     % �õ�����һ�������ԱȽϺõĹ�����
figure, imshow(foc);
pp=foc;

 % % hough�任
pp=im2bw(pp,1.5*graythresh(pp));
figure,imshow(pp); %ͼ5
ss=bwmorph(foc,'skel',inf);
figure,imshow(ss); %ͼ6

q=ss;
a=180; %�Ƕȵ�ֵΪ0��180��
d=round(sqrt(height^2+width^2)); %ͼ��Խ��߳���Ϊp�����ֵ
s=zeros(2*a,2*d); %�洢ÿ��(a,p)����
z=cell(2*a,2*d);  %��Ԫ���洢ÿ�������ĵ������
for i=1:height 
    for j=1:width %����ͼ��ÿ����
        if(q(i,j)==255) %ֻ���ͼ���Ե�İ׵㣬����㲻���
            for k=1:2*a
                p = round(i*cos(pi*k/360)+j*sin(pi*k/360)); %��ÿ�����1��180�ȱ���һ�飬ȡ�þ����õ������ֱ�ߵ�pֵ��ȡ����
                if(p > 0) %��p����0���򽫵�洢�ڣ�2a��2d���ռ�
                    s(k,p)=s(k,p)+1; %��a��p����Ӧ���ۼ�����Ԫ��һ
                    z{k,p}=[z{k,p},[i,j]']; %�洢������
                else
                    ap=abs(p)+1; %��pС��0���򽫵�洢�ڣ�0��d���ռ�
                    s(k,ap)=s(k,ap)+1;  %(a��p)��Ӧ���ۼ�����Ԫ��һ
                    z{k,ap}=[z{k,ap},[i,j]'];  %�洢������
                end
            end
        else
        end
    end
end

   
L=0
o=zeros(height,width);
for i=1:2*a 
    for j=1:2*d   %���ÿ���ۼ�����Ԫ�д洢����      
        if L<s(i,j) 
            L=s(i,j);
            tt=i;
            xx=j;
        else
        end 
    end
end
lp=z{tt,xx};  %��ȡ��Ӧ������
o=zeros(height,width);
for k=1:l  %�������ۼ�����Ԫ��(a��p)��Ӧ�����е���в���    
       o(lp(1,k),lp(2,k))=255; 
             end
figure,imshow(o); %ͼ8
title('hough�任��ȡֱ��');

% se = strel('disk',15); 
% focmodel=imdilate(o,se); % ���ҵ������߽��и�ʴ�������õ�ƥ��ģ��
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







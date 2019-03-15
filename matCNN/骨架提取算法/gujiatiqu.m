clear;clc;
close all;
g0 = imread('C:\Users\zhang\Pictures\����ͼƬ4.24��\1.bmp'); %����ͼ��
% g=g0;
g = rgb2gray(g0);%��ʽ�Ҷ�ת��
figure,imshow(g); %��ʾԭͼ 1
[height,width] = size(g);

%% ��ֵ�ָ� ��ȡ��������

for i=1:height      %��ֵ�ָ�
    for j=1:width
        if g(i,j)<160
            g(i,j)=0;
        else 
            g(i,j)=255;
        end
    end
end
figure,imshow(g);   %��ʾ��ֵ�ָ���ͼ�� ͼ2

%% �Էָ���ͼ����п��ջ��Ĵ���

% se = strel('disk',5);   
% fo=imopen(g,se);   %��ͼ����п�������������ϸС����
% figure, imshow(fo);
se = strel('disk',2);
foc=imclose(g,se); %��ͼ����бջ���������ʹ��С��С�������ӳ�һ��������
figure,imshow(foc); %ͼ3

pp=foc;
se = strel('disk',2);
pp=imdilate(pp,se);
figure,imshow(pp);

se = strel('disk',1);   
foc=imerode(foc,se);   %��ͼ����и�ʴ Ϊ��������ģ������ṩ����
TT=foc;                %TT ����������Ϊʵ����ƥ��
figure,imshow(foc); %ͼ4

%% �������ͼ����йǼ���ȡ��ϣ���ܵõ�һ���������ϸ��

pp=im2bw(pp,1.5*graythresh(pp));
figure,imshow(pp); %ͼ5
ss=bwmorph(foc,'skel',inf);
figure,imshow(ss); %ͼ6
% ss1=bwmorph(ss,'spur',15);
% figure,imshow(ss1); %ͼ7

%% ��֪�Ƕ�Ԥ���壬�ӿ���Ӧ�ٶ�

q=ss;
a=5; %�Ƕȵ�ֵΪ0��180��
d=round(sqrt(height^2+width^2)); %ͼ��Խ��߳���Ϊp�����ֵ
s=zeros(a,2*d); %�洢ÿ��(a,p)����
z=cell(a,2*d);  %��Ԫ���洢ÿ�������ĵ������
for i=1:height 
    for j=1:width %����ͼ��ÿ����
        if(q(i,j)==1) %ֻ���ͼ���Ե�İ׵㣬����㲻���
            for k=1:a
                p = round(i*cos(pi*(167+k)/180)+j*sin(pi*(167+k)/180)); %��ÿ�����1��180�ȱ���һ�飬ȡ�þ����õ������ֱ�ߵ�pֵ��ȡ����
                if(p > 0) %��p����0���򽫵�洢�ڣ�d��2d���ռ�
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
l=s(1,1);
for i=1:a 
    for j=1:2*d   %���ÿ���ۼ�����Ԫ�д洢����      
        if l<s(i,j) 
            l=s(i,j);
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


%% �ֻ�ģ�塣����ԭ����ͼƬ����ƥ��

se = strel('disk',5);   %
focmodel=imdilate(o,se);
focmodel= uint16(focmodel);
source=TT;
source=uint16(source);
T=immultiply(focmodel,source);
% se = strel('disk',5);
% T=imopen(T,se);
figure,imshow(T); %ͼ9 ƥ����


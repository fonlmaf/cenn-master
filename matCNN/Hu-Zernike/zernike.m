function        [A_nm,zmlist,cidx,V_nm]        = zernike(img,n,m)
% ���ܣ���������ͼ���Zernike��
% ���룺img-�Ҷ�ͼ��
%       n-����
% �����V_nm-n�׵�Zernike����ʽ������Ϊ�ڼ�����ϵ��p��theta�ĺ���
%       cidx-��ʾ�鲿ֵ
%       A_nm-Zernike��



clear all;
close all;
clc;
img = imread('d:\wenzhang\image\818.jpg');

d=size(img);                        
img=double(img);
% ȡ����
xstep=2/(d(1)-1); 
ystep=2/(d(2)-1);
% ������
[x,y]=meshgrid(-1:xstep:1,-1:ystep:1); 
circle1= x.^2 + y.^2; 
% ��ȡ����circle1<=1����
inside=find(circle1<=1); 
% ����size��d��*size(d)�ľ���
mask=zeros(d);
% ����size(inside)*size(inside)��ȫΪ1�ľ���ֵ��mask��inside��
mask(inside)=ones(size(inside)); 
% ����ͼ��ĸ�����ʾ
[cimg,cidx]=clipimg(img,mask); 
% ����Z��ʵ�����鲿
z=clipimg(x+i*y,mask); 
% ���㸴����ģ��sqrt(x,y),z=x+iy
p=0.9*abs(z);   ;
% ���㸴��z�ķ���ֵ��tanz��
theta=angle(z); 
c=1;
for order=1:length(n)
        n1=n(order);
           if nargin<3
                m=zpossible(n1);                
        end
        for r=1:length(m)
  V_nmt=zpoly(n1,m(r),p,theta); 
 % conj�������Ĺ���
zprod=cimg.*conj(V_nmt); 
 % (n1+1)/��*�ơ�(zprod); ����ͼ�������ʹ����������
A_nm(c)=(n1+1)*sum(sum(zprod))/pi; 
                zmlist(c,1:2)=[n1 m(r)]; 
                if nargout==4
                        V_nm(:,c)=V_nmt;
                end
                c=c+1;
        end
end

end

%%%%%�Ӻ���%%%%%
function [cimg,cindex,dim]=clipimg(img,mask)
%���ܣ����㸴����ʵ�����鲿
dim=size(img);  
cindex=find(mask~=0);
cimg=img(cindex); 
return;

%%%%%�Ӻ���%%%%%
function  [m]=zpossible(n)
% ���ܣ��ж�n��ż��������������ż��ʱ��mȡ0,2,4,6��,����ȡ������ֵm
if iseven(n)
        m=0:2:n;
else
        m=1:2:n;
end
return;

%%%%%�Ӻ���%%%%%
function        [V_nm,mag,phase]=zpoly(n,m,p,theta)
%���ܣ�����Zernike�ض���ʽ
R_nm=zeros(size(p)); % ����size(p)*size(p)������󸳸�R_nm
a=(n+abs(m))/2;
b=(n-abs(m))/2;
total=b;
for s=0:total
        num=((-1)^s)*fac(n-s)*(p.^(n-2*s)); % (-1).-1*(n-s)!r.^(n-2*s)
        den=fac(s)*fac(a-s)*fac(b-s); % s!*(a-s)!*(b-s)!
        R_nm=R_nm + num/den; % R_nm��һ��ʵ��ֵ�ľ������ʽ
end
mag=R_nm; % ��ֵ
phase=m*theta; 
V_nm=mag.*exp(i*phase); % V_nmΪn�׵�Zernike����ʽ������Ϊ�ڼ�����ϵ��p��theta�ĺ���
return;

%%%%%�Ӻ���%%%%%
function [factorial]=fac(n)
%���ܣ���n�Ľ׳�
maxno=max(max(n));
zerosi=find(n<=0); %ȡnС�ڵ���0����
n(zerosi)=ones(size(zerosi));
factorial=n;
findex=n;
for i=maxno:-1:2
        cand=find(findex>2);
        candidates=findex(cand);
        findex(cand)=candidates-1;
        factorial(cand)=factorial(cand).*findex(cand);
end
return;

function [verdict]=iseven(candy)
verdict=zeros(size(candy));
isint=find(isint(candy)==1);
divided2=candy(isint)/2;
evens=(divided2==floor(divided2));
verdict(isint)=evens;
return;

function [verdict]=isint(candy)
verdict        = double(round(candy))==candy;
return;

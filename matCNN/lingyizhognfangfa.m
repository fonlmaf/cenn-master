f=imread('mdb001.bmp'); 
figure, 
imshow(f) 
%ԭͼ�� 
figure, 
%f=rgb2gray(f); 
f=1.124*f; 
imshow(f) 
%�ҶȻ�ԭͼ 
[m,n]=size(f); 
for i=1:m; 
    for j=1:97; 
    if f(i,j)~=244 
        f(i,j)=244; 
    end 
    end 
end 
for i=1:m; 
    for j=459:n; 
    if f(i,j)~=244 
        f(i,j)=244; 
    end 
    end 
end 
for i=1:104; 
    for j=1:n; 
    if f(i,j)~=244 
        f(i,j)=244; 
    end 
    end 
end 
for i=1079:m 
    for j=1:n; 
    if f(i,j)~=244 
        f(i,j)=244; 
    end 
    end 
end 
figure, 
imshow(f) 
%��ԭͼ�ı߿�ȥ���Ա���� 
for i=105:1079; 
    for j=98:460; 
        Z(i-104,j-97)=f(i,j); 
    end 
end 
figure, 
imshow(Z) 
%��ȥ���߿��ԭͼ���һ��û�������������ŵ�ͼ 
[M,N]=size(Z); 
for i=2:M-1; 
    for j=2:N-1; 
                       F8(i,j,1)=Z(i-1,j); 
                       F8(i,j,2)=Z(i-1,j+1); 
                       F8(i,j,3)=Z(i-1,j-1); 
                       F8(i,j,4)=Z(i,j-1); 
                       F8(i,j,5)=Z(i,j+1); 
                       F8(i,j,6)=Z(i+1,j); 
                       F8(i,j,7)=Z(i+1,j-1); 
                       F8(i,j,8)=Z(i+1,j+1); 
    end 
end  
%������˱�Ե��ĸ������ص�8���򼯺� 
P=0.61; 
k=1:8; 
%���ò��� 
for i=2:M-1; 
    for j=2:N-1; 
         if (k==1:8) 
            gmax(i,j)=max(F8(i,j,k)); 
            gmin(i,j)=min(F8(i,j,k)); 
            u(i,j)=(gmax(i,j)+gmin(i,j))/2; 
            Td(i,j)=(gmax(i,j)-gmin(i,j))/(2*P); 
            if (((Z(i,j)>gmin(i,j))&(Z(i,j)<(u(i,j)-Td(i,j))))|((Z(i,j)<gmax(i,j))&(Z(i,j)>(u(i,j)+Td(i,j))))) 
                C(i,j)=1; 
            else  
                C(i,j)=0; 
        end 
    end 
end 
end 
figure, 
imshow(C) 
%�����任���ͼ�� 
%C=imcomplement(C); 
C=medfilt2(C); 
figure, 
imshow(C) 
C=imcomplement(C); 
C=imfill(C,'holes'); 
%���ͼ��ʹ���ڷ���Ŀձ���� 
figure, 
imshow(C) 
se=strel('disk',2); 
foc=imopen(C,se); 
%����ͼ���е�С�ӵ� 
figure, 
imshow(foc)
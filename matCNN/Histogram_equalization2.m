
function[ h1 ] =Histogram_equalization2( )

A=imread('mdb002.bmp');
%A=rgb2gray(A);
%imshow(A);
k=graythresh(A);
[m,n]=size(A);
A=double(A);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if A(i,j)<=m
            B(i,j)=0;
        else
            B(i,j)=A(i,j);
        end
    end
end
imshow(B);
subplot(2,2,1)
imshow(mat2gray(B));
title('分割后的图像')
h=histeq(mat2gray(B));
subplot(2,2,2)
imshow(h)
title('对分割后的图像直方图均衡化')
C=zeros(m,n);
for i=1:m
    for j=1:n
        if A(i,j)>m
           C(i,j)=0;
        else
            C(i,j)=A(i,j);
        end
    end
end
subplot(2,2,3)
imshow(mat2gray(C));
title('分割后的图像')
 h1=histeq(mat2gray(C));
 subplot(2,2,4)
 imshow(h1)
title('对分割后的图像直方图均衡化')
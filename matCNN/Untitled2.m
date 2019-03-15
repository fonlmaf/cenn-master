clc; 
clear; 
close all;
I=imread('E:\CeNNfile\DDSM\B_3001_1.LEFT_MLO.png');%读取图像
I = double(I);

% newimg = I;
II = imread('E:\CeNNfile\DDSM\B_3001_1.LEFT_MLO.png');
%III = imresize(II,0.5);
III=II;
%figure(3),imshow(III)

mask = im2bw(III, 0.5);
%figure(4),imshow(mask)

finalimage = double(I).*mask;
%figure(5),imshow(finalimage,[])
%colorbar
%figure(6),imshow(finalimage,colormap)

[L,num]=bwlabel(finalimage,8);
    x=zeros(1,num);
    for ii=1:5000
        x(ii)=sum(sum(L==ii));
    end
    [m,ind]=min(x); %选第二大的区域
    out=(L==ind);
    f_mask=out;
  fin = I;
  [height,width] = size(fin);
  fout=uint8(zeros(height,width));
  for i = 1:height  
    for j = 1: width  
        if f_mask(i,j)~=0
            fout(i,j)=fin(i,j);
    end  
    end
  end
figure(6),imshow(fout);
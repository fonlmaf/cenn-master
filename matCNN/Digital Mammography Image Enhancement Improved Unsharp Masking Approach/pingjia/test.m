% % (c) Akshay Gore %
% % Department of Electronics and Communication Engineering
% % Chandigarh University, India
% % akshaygore@live.com %
% % %
% % To report your comment or any bug please send e-mail to: %
% % akshaygore@live.com
% 
% 
% Please download Database
% 
% MIAS ( Mammographic Image Analysis Society ), MiniMammographic 
% Database, 
% 
% http://peipa.essex.ac.uk/ipa/pix/mias/.
clc;clear;close all;
%I=imread('D:\gao\images\038.jpg');

I=imread('mdb001.bmp');
%I=rgb2gray(I);

figure
imshow(I,[])
title('original image')

[Irect,rect]=imcrop(I);
I1=histeq(I);

I=im2double(I);
I1=im2double(I1);

dsmoriginal=DSM(I,I,rect);

dsmhisteq=DSM(I,I1,rect);

Coriginal=contrast(I,rect);
Chisteq=contrast(I1,rect);




figure
imshow(I1,[])
title('histeq')


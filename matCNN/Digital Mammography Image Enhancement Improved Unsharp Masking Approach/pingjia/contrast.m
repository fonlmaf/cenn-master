% (c) Akshay Gore %
% Department of Electronics and Communication Engineering
% Chandigarh University, India
% akshaygore@live.com %
% %
% To report your comment or any bug please send e-mail to: %
% akshaygore@live.com
function C=contrast(I,rect)
I=double(I);
[s,t]=size(I);
Ifore=imcrop(I, rect);
[sr,tr]=size(Ifore);
Ifore_sum=sum(Ifore(:));
Iback_sum=sum(I(:))-Ifore_sum;
Ifore_mean=Ifore_sum/(sr*tr);
Iback_mean=Iback_sum/(s*t-sr*tr);
C=(Ifore_mean-Iback_mean)/(Ifore_mean+Iback_mean);
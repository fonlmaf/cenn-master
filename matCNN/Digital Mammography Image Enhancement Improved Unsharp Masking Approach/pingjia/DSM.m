% (c) Akshay Gore %
% Department of Electronics and Communication Engineering
% Chandigarh University, India
% akshaygore@live.com %
% %
% To report your comment or any bug please send e-mail to: %
% akshaygore@live.com
function dsm=DSM(I,Ieh,rect)
I=double(I);
Ieh=double(Ieh);
[s,t]=size(I);
Ifore=imcrop(I, rect);
Iehfore=imcrop(I,rect);
i1=[1:fix(rect(1)) ceil(rect(1)+rect(3)):t];
j1=[1:s];
Iback1=I(j1,i1);
Iehback1=Ieh(j1,i1);
i2=[ceil(rect(1)):fix(rect(1)+rect(3))];
j2=[1:fix(rect(2)) ceil(rect(2)+rect(4)):s];
Iback2=I(j2,i2);
Iehback2=Ieh(j2,i2);
Iback=[Iback1(:);Iback2(:)];
Iehback=[Iehback1(:);Iehback2(:)];
uBo=mean(Iback(:));
dBo=std(Iback(:));
uTo=mean(Ifore(:));
dTo=std(Ifore(:));
uBe=mean(Iehback(:));
dBe=std(Iehback(:));
uTe=mean(Iehfore(:));
dTe=std(Iehfore(:));
D1=(uBo*dTo+uTo*dBo)/(dBo+dTo);
D2=(uBe*dTe+uTe*dBe)/(dBe+dTe);
dsm=(abs(D2-uBe)+abs(D2-uTe))-(abs(D1-uBo)+abs(D1-uTo));


function[ ] =Histogram_equaliztion1( )

H=imread('.\mdb090.bmp');figure;subplot(121);imshow(H);%图像应该是灰度图，若图像为彩色图，需要对每个通道进行计算

H=im2double(H);%这个是需要注意的地方，一定要变换成double类型

[M,N]=size(H);

[counts,x]=imhist(H);%H是读取的图像，imhist是对图像直方图进行统计，其中count，是每个灰度值得个数，x代表灰度值。一般的，x=1:256

location=find(counts~=0);%找到所有像素个数不为0的灰度级

MinCDF=min(counts(location));%找到包含个数最少的灰度级

for j=1:length(location)

   CDF=sum(counts(location(1:j)));%计算各个灰度级像素个数累计分布

   P=find(H==x(location(j)));%找到图像中等于某个灰度级所有像素点所在位置

   H(P)=(CDF-MinCDF)/(M*N-MinCDF);%%利用灰度换算公式，修改所有位置上的像素值

end

subplot(122);imshow(H);
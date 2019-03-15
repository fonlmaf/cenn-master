function H = varhist(img,a,b,c,d)
% 函数功能：提取图像指定矩形区域的局部方差直方图
% img 要处理的图像用字符串格式输入如: 'test.png'
% a：b，c：d为矩形区域范围
% H 为返回值
I = imread(img);
if length(size(I))==3
    I = rgb2gray(I);
end
var=blkproc(I,[1 1],[2 2],@std2);
[m, n] = size(var);
mx=max(max(var));    %求出局部方差最大值
mx=round(mx);
H = zeros(1,mx+1);
for i = a:b
    for j = c:d
        H(round(var(i,j))+1) = H(round(var(i,j))+1) + 1;
    end
end
%figure, contour(var);
figure, bar(H,'b');
set(gca,'Xtick',[0:20:mx]);
end

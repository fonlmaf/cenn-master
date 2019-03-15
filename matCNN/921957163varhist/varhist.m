function H = varhist(img,a,b,c,d)
% �������ܣ���ȡͼ��ָ����������ľֲ�����ֱ��ͼ
% img Ҫ�����ͼ�����ַ�����ʽ������: 'test.png'
% a��b��c��dΪ��������Χ
% H Ϊ����ֵ
I = imread(img);
if length(size(I))==3
    I = rgb2gray(I);
end
var=blkproc(I,[1 1],[2 2],@std2);
[m, n] = size(var);
mx=max(max(var));    %����ֲ��������ֵ
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

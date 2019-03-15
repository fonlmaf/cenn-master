bmps = dir(strcat('..\Imgextraction\','*.png'));
num = length( bmps ); 
%num = 2;
f=0;

for iter=1:num
    png_file=fullfile('..\Imgextraction\' , bmps(iter).name );
    [ path , name , ext ] = fileparts( png_file ) ;  

  % 第二步，生成新的文件名  
    filename = strcat( name , ' (2).bmp' );  
    img=imread(png_file);
    bed_file = fullfile('..\Imgextraction\', filename );  
    Y=im2uint8(img);
    H=histeq(Y,256);
    M=medfilt2(H);
%     img=im2uint8(im2bw(img));
    
    imwrite(M,bed_file,'bmp');
end

delete( '..\Imgextraction\*.png');
% delete( '..\trainset2\*.bmp');
% delete( '..\trainset2\*(2).bmp');  
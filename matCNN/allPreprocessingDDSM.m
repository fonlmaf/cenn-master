%--------------------------2017-4-19----------------------%
% .bmp 图片进行 histogram equalization without mask 和 median filtering  

function[ ] = allPreprocessingDDSM(dir_in,dir_out )  

 %读取指定目录下面所有的 png 格式图片  
 bmps = dir(strcat(dir_in,'*.png'));  
 num_bmps = length( bmps );  

 for i = 1 : num_bmps  
   png_file = fullfile( dir_in , bmps(i).name );
   %mask_file = fullfile( dir_mask , bmps(i).name );
   %bmp = imread(bmp_file);  

  % 第一步，解析文件名 pgm_file,pgm_file包括路径+文件名+后缀,
  % 如 pgm_file = '.\ORL人脸数据库\s1\1.pgm'  

  % path = '.\ORL人脸数据库\s1'  name = '1' ext = '.bmp'  
   [ path , name , ext ] = fileparts( png_file ) ;  

  % 第二步，生成新的文件名  
   filename = strcat( name , '.bmp' );  

  % 第三步，生成文件全称  
  bed_file = fullfile( dir_out, filename );  
  % prprocessing: Histogramequalization
  img=imread(png_file);
  Y=im2uint8(img);
  H=histeq(Y,256);
  M=imadjust(H,[0.832,1],[]);
  M=medfilt2(M);
  M = imclearborder(M,8);%%%%%%%clear the chest board
  [m,n]=size(M);
%figure,imshow(M);
  imwrite(M,bed_file,'bmp');  

 end  

end 
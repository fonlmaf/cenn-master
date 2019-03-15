%--------------------------2017-4-19----------------------%
% .bmp 图片进行 histogram equalization without mask 和 median filtering  

function[out ] = Pixelsum( )  

 %读取指定目录下面所有的 bmp 格式图片  
 bmps = dir(strcat( '.\CENNFIG\all-mias\ROI\','*.bmp'));  
 num_bmps = length( bmps );  
 pixels=[];
 for i = 1 : num_bmps  
   bmp_file = fullfile(  '.\CENNFIG\all-mias\ROI\' , bmps(i).name );
   %mask_file = fullfile( dir_mask , bmps(i).name );
   bmp = imread(bmp_file);  

  % 第一步，解析文件名 pgm_file,pgm_file包括路径+文件名+后缀,
  % 如 pgm_file = '.\ORL人脸数据库\s1\1.pgm'  

  % path = '.\ORL人脸数据库\s1'  name = '1' ext = '.bmp'  
  % [ path , name , ext ] = fileparts( bmp_file ) ;  

  % 第二步，生成新的文件名  
  % filename = strcat( name , '.bmp' );  

  % 第三步，生成文件全称  
  %bed_file = fullfile( dir_out, filename );  

  % prprocessing: Histogramequalization
  
  %outfile = Udefined_Edge_detection(bmp_file);  
  %scnn2bmp(bed_file,outfile);
  [height, width]=size(bmp);
  pixels(i)=height*width;

 end
 out=mean(pixels(:));

end 
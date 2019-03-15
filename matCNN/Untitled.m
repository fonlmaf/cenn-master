 %function[ ] = allMIAS_segmentation(dir1)  

 %读取指定目录下面所有的 bmp 格式图片  
 bmps = dir(strcat('E:\CeNNfile\DDSM\post_processing\','*.bmp')); 
 %bmps = dir('.\CENNFIG\all-mias\Histogram_equaliztion\*.bmp');  
 num_bmps = length( bmps );                                           
 Names={};
 for i = 1 : num_bmps  
   bmp_file = fullfile( 'E:\CeNNfile\DDSM\post_processing\' , bmps(i).name ); 
   %bmp_file = ( '.\CENNFIG\all-mias\Histogram_equaliztion\' , bmps(i).name );  
   %bmp = imread(bmp_file);  

  % 第一步，解析文件名 pgm_file,pgm_file包括路径+文件名+后缀,
  % 如 pgm_file = '.\ORL人脸数据库\s1\1.pgm'  

  % path = '.\ORL人脸数据库\s1'  name = '1' ext = '.bmp'  
   [ path , name , ext ] = fileparts( bmp_file ) ;  

  % 第二步，生成新的文件名  
   filename = strcat( name , '.bmp' );  

  % 第三步，生成文件全称  
  Names{i}=filename;  

  % 第四步，Edge detection，保存为 bmp 格式 
  %outfile = MIAS_segmentation(bmp_file);
  %outfile=~outfile;
  %scnn2bmp(bed_file,outfile);
  %imwrite( outfile, bed_file , 'bmp' );  

 end   
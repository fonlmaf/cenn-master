%function[ features,names ] = Feature_extraction_selection(dir_gray,dir_binary)  


 %读取指定目录下面所有的 bmp 格式图片  
 %读取指定目录下面所有的 bmp 格式图片
 dir1='E:\CeNNfile\DDSM\post_processingmask\';
 dir2='E:\CeNNfile\DDSM\ROI\';
 dir3='E:\CeNNfile\DDSM\ROI_BIN\';
 bmps1=dir(strcat(dir1,'*.bmp'));
 bmps2 = dir(strcat(dir2,'*.bmp'));  
 bmps3 = dir(strcat(dir3,'*.bmp'));  
 num_bmps1 = length( bmps1 );  
 bmp_file = {};
 for i = 1 : num_bmps1  
   bmp_file{i} = bmps1(i).name;
 end
 num_bmp2=length(bmps2);
 for  i=1:num_bmp2
     if ismember(bmps2(i).name,bmp_file)==0
         delete(strcat(dir2,bmps2(i).name));
         delete(strcat(dir3,bmps3(i).name));
     end
 end
   %mask_file = fullfile( dir_mask , bmps(i).name );
   %bmp = imread(bmp_file);  

  % 第一步，解析文件名 pgm_file,pgm_file包括路径+文件名+后缀,
  % 如 pgm_file = '.\ORL人脸数据库\s1\1.pgm'  

  
  
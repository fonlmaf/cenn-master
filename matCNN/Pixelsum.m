%--------------------------2017-4-19----------------------%
% .bmp ͼƬ���� histogram equalization without mask �� median filtering  

function[out ] = Pixelsum( )  

 %��ȡָ��Ŀ¼�������е� bmp ��ʽͼƬ  
 bmps = dir(strcat( '.\CENNFIG\all-mias\ROI\','*.bmp'));  
 num_bmps = length( bmps );  
 pixels=[];
 for i = 1 : num_bmps  
   bmp_file = fullfile(  '.\CENNFIG\all-mias\ROI\' , bmps(i).name );
   %mask_file = fullfile( dir_mask , bmps(i).name );
   bmp = imread(bmp_file);  

  % ��һ���������ļ��� pgm_file,pgm_file����·��+�ļ���+��׺,
  % �� pgm_file = '.\ORL�������ݿ�\s1\1.pgm'  

  % path = '.\ORL�������ݿ�\s1'  name = '1' ext = '.bmp'  
  % [ path , name , ext ] = fileparts( bmp_file ) ;  

  % �ڶ����������µ��ļ���  
  % filename = strcat( name , '.bmp' );  

  % �������������ļ�ȫ��  
  %bed_file = fullfile( dir_out, filename );  

  % prprocessing: Histogramequalization
  
  %outfile = Udefined_Edge_detection(bmp_file);  
  %scnn2bmp(bed_file,outfile);
  [height, width]=size(bmp);
  pixels(i)=height*width;

 end
 out=mean(pixels(:));

end 
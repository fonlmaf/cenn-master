 %function[ ] = allMIAS_segmentation(dir1)  

 %��ȡָ��Ŀ¼�������е� bmp ��ʽͼƬ  
 bmps = dir(strcat('E:\CeNNfile\DDSM\post_processing\','*.bmp')); 
 %bmps = dir('.\CENNFIG\all-mias\Histogram_equaliztion\*.bmp');  
 num_bmps = length( bmps );                                           
 Names={};
 for i = 1 : num_bmps  
   bmp_file = fullfile( 'E:\CeNNfile\DDSM\post_processing\' , bmps(i).name ); 
   %bmp_file = ( '.\CENNFIG\all-mias\Histogram_equaliztion\' , bmps(i).name );  
   %bmp = imread(bmp_file);  

  % ��һ���������ļ��� pgm_file,pgm_file����·��+�ļ���+��׺,
  % �� pgm_file = '.\ORL�������ݿ�\s1\1.pgm'  

  % path = '.\ORL�������ݿ�\s1'  name = '1' ext = '.bmp'  
   [ path , name , ext ] = fileparts( bmp_file ) ;  

  % �ڶ����������µ��ļ���  
   filename = strcat( name , '.bmp' );  

  % �������������ļ�ȫ��  
  Names{i}=filename;  

  % ���Ĳ���Edge detection������Ϊ bmp ��ʽ 
  %outfile = MIAS_segmentation(bmp_file);
  %outfile=~outfile;
  %scnn2bmp(bed_file,outfile);
  %imwrite( outfile, bed_file , 'bmp' );  

 end   
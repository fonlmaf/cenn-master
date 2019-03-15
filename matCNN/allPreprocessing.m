%--------------------------2017-4-19----------------------%
% �ڵ�ǰ���������£���ʾ������ .\ORL�������ݿ�\s1 Ŀ¼�������е�
% .bmp ͼƬ���� histogram equalization with mask

function[ ] = allPreprocessing(dir_in,dir_mask,dir_out )  

 %��ȡָ��Ŀ¼�������е� bmp ��ʽͼƬ  
 bmps = dir('.\CENNFIG\all-mias\bmp\*.bmp');  
 num_bmps = length( bmps );  

 for i = 1 : num_bmps  
   bmp_file = fullfile( dir_in , bmps(i).name );
   mask_file = fullfile( dir_mask , bmps(i).name );
   %bmp = imread(bmp_file);  

  % ��һ���������ļ��� pgm_file,pgm_file����·��+�ļ���+��׺,
  % �� pgm_file = '.\ORL�������ݿ�\s1\1.pgm'  

  % path = '.\ORL�������ݿ�\s1'  name = '1' ext = '.bmp'  
   [ path , name , ext ] = fileparts( bmp_file ) ;  

  % �ڶ����������µ��ļ���  
  filename = strcat( name , '.bmp' );  

  % �������������ļ�ȫ��  
  bed_file = fullfile( dir_out, filename );  

  % prprocessing: Histogramequalization
  outfile = Histogram_equalization1(bmp_file,mask_file );%Histogram_equalization2(bmp_file);
  % median filtering
  %outfile=medfilt2(outfile,[6,6]);
  %outfile = Udefined_Edge_detection(bmp_file);  
  %scnn2bmp(bed_file,outfile);
  imwrite( outfile, bed_file , 'bmp' );  

 end  

end 
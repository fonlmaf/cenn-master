%--------------------------2017-4-19----------------------%
% .bmp ͼƬ���� histogram equalization without mask �� median filtering  

function[ ] = allPreprocessing2(dir_in,dir_out )  

 %��ȡָ��Ŀ¼�������е� bmp ��ʽͼƬ  
 bmps = dir(strcat(dir_in,'*.bmp'));  
 num_bmps = length( bmps );  

 for i = 1 : num_bmps  
   bmp_file = fullfile( dir_in , bmps(i).name );
   %mask_file = fullfile( dir_mask , bmps(i).name );
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
  outfile = histeq(imread(bmp_file));%Histogram_equalization2(bmp_file);
  outfile=imadjust(outfile,[0.5,0.75],[0,1]);
  % median filtering
  outfile=medfilt2(outfile);
  %outfile = Udefined_Edge_detection(bmp_file);  
  %scnn2bmp(bed_file,outfile);
  imwrite( outfile, bed_file , 'bmp' );  

 end  

end 
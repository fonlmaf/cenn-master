%--------------------------2017-4-19----------------------%
% .bmp ͼƬ���� histogram equalization without mask �� median filtering  

function[ ] = allPreprocessingDDSM(dir_in,dir_out )  

 %��ȡָ��Ŀ¼�������е� png ��ʽͼƬ  
 bmps = dir(strcat(dir_in,'*.png'));  
 num_bmps = length( bmps );  

 for i = 1 : num_bmps  
   png_file = fullfile( dir_in , bmps(i).name );
   %mask_file = fullfile( dir_mask , bmps(i).name );
   %bmp = imread(bmp_file);  

  % ��һ���������ļ��� pgm_file,pgm_file����·��+�ļ���+��׺,
  % �� pgm_file = '.\ORL�������ݿ�\s1\1.pgm'  

  % path = '.\ORL�������ݿ�\s1'  name = '1' ext = '.bmp'  
   [ path , name , ext ] = fileparts( png_file ) ;  

  % �ڶ����������µ��ļ���  
   filename = strcat( name , '.bmp' );  

  % �������������ļ�ȫ��  
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
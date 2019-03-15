%%(dilation and erosion)
function[ ] = Post_processing(dir_in,dir_out,dir_mask )  

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
   [ path , name , ext ] = fileparts( bmp_file );  

  % �ڶ����������µ��ļ���  
   filename = strcat( name , '.bmp' );  

  % �������������ļ�ȫ��  
  bed_file = fullfile( dir_out, filename );  
  mask_file = fullfile( dir_mask, filename ); 

  % post processing
  
  f = imread(bmp_file);%Histogram_equalization2(bmp_file);
  %erosion
  %se=strel('disk',1);
  %inputfile=imerode(inputfile,se);
  
  % dilation 
%    B=[1 1 1
%       1 1 1
%       1 1 1];
%   for i=1:3
%       inputfile=imdilate(inputfile,B);%ͼ�񱻽ṹԪ��B����
%   end
  
  %��ʴ����
  %se=strel('disk',5');
  %fse=imerode(f,se);
  %fes=imdilate(fse,se);
  
  se=strel('square',3);
  fc=imclose(f,se);
  %fco=imopen(fc,se);
  
  
    [L,num]=bwlabel(fc,8);
    x=zeros(1,num);
    for ii=1:num
        x(ii)=sum(sum(L==ii));
    end
    [m,ind]=max(x);
    out=(L==ind);
    f_mask=out;
  fin = imread(fullfile( '.\CENNFIG\all-mias\Preprocessing', bmps(i).name ));
  [height,width] = size(fin);
  fout=uint8(zeros(height,width));
  for i = 1:height  
    for j = 1: width  
        if f_mask(i,j)~=0
            fout(i,j)=fin(i,j);
    end  
    end
  end
  %fout=im2uint8(fout);
    
  imwrite( fout, bed_file , 'bmp' );  
  imwrite( f_mask, mask_file , 'bmp' );

 end  

end 
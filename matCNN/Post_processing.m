%%(dilation and erosion)
function[ ] = Post_processing(dir_in,dir_out,dir_mask )  

 %读取指定目录下面所有的 bmp 格式图片  
 bmps = dir(strcat(dir_in,'*.bmp'));  
 num_bmps = length( bmps );  

 for i = 1 : num_bmps  
   bmp_file = fullfile( dir_in , bmps(i).name );
   %mask_file = fullfile( dir_mask , bmps(i).name );
   %bmp = imread(bmp_file);  

  % 第一步，解析文件名 pgm_file,pgm_file包括路径+文件名+后缀,
  % 如 pgm_file = '.\ORL人脸数据库\s1\1.pgm'  

  % path = '.\ORL人脸数据库\s1'  name = '1' ext = '.bmp'  
   [ path , name , ext ] = fileparts( bmp_file );  

  % 第二步，生成新的文件名  
   filename = strcat( name , '.bmp' );  

  % 第三步，生成文件全称  
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
%       inputfile=imdilate(inputfile,B);%图像被结构元素B膨胀
%   end
  
  %腐蚀膨胀
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
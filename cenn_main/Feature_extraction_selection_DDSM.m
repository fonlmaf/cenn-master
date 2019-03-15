function[ features,names ] = Feature_extraction_selection(dir_gray,dir_binary)  


 %读取指定目录下面所有的 bmp 格式图片  
 bmps = dir(strcat(dir_gray,'*.bmp')); 
 %bmps = dir('.\CENNFIG\all-mias\Histogram_equaliztion\*.bmp');  
 num_bmps = length( bmps );  
 features={};
 names={};
 for i = 1 : num_bmps  
   bmp_file = fullfile( dir_gray , bmps(i).name ); 
   bin_file = fullfile( dir_binary , bmps(i).name ); 
   %bmp_file = ( '.\CENNFIG\all-mias\Histogram_equaliztion\' , bmps(i).name );  
   img_gray = imread(bmp_file); 
   img_bin = imread(bin_file);
   [height,width]=size(img_gray);
   
   
   %先膨胀再腐蚀
   fse=im2double(img_bin);
 se=strel('disk',10);%圆盘型结构元素
 sqe=strel('square',10);%方型结构元素
 for j=1:7 
 fse=imerode(fse,sqe);
 end
 for j=1:7
 fse=imdilate(fse,sqe);%膨胀
 end
  %% select the core region     
   [L,num]=bwlabel(fse,8);
    x=zeros(1,num);
    for ii=1:num
        x(ii)=sum(sum(L==ii));
    end
    [mm,ind]=max(x); %选最大的区域
    fse=(L==ind);
 
 img_bin=fse;


 
    
    %%%%%%%% 
    feature=(zeros(1,19));
    %intensity histogram features (variance)
    %h=imhist(img_gray);
    %h(1)=0;
    feature(1)=std2(img_gray);
    %GLCM_Contrast
    glcm = graycomatrix(img_gray);
    stats = graycoprops(glcm);
    feature(2)=stats.Contrast;
    %%%regionprops
    region = (regionprops(img_bin,'ConvexArea','Solidity'));
    %convex area
    feature(3)=region(1).ConvexArea/(height*width);
    
    %spiculated
    feature(4) = curvature_angle(img_bin);
    
    %solidity
    feature(5) = region(1).Solidity;
    

    %Zernike moments angle
    feature(6)=zernike_hu(img_bin,0,0)/(height*width);
    feature(7)=angle(zernike_hu(img_bin,1,-1));
    feature(8)=angle(zernike_hu(img_bin,1,1));
    feature(9)=angle(zernike_hu(img_bin,2,-2));
    %feature(10)=angle(zernike_hu(img_bin,2,0));
    feature(10)=angle(zernike_hu(img_bin,2,2));
    feature(11)=angle(zernike_hu(img_bin,3,-3));
    feature(12)=angle(zernike_hu(img_bin,3,-1));
    feature(13)=angle(zernike_hu(img_bin,3,1));
    feature(14)=angle(zernike_hu(img_bin,3,3));
    feature(15)=angle(zernike_hu(img_bin,4,-4));
    feature(16)=angle(zernike_hu(img_bin,4,-2));
    feature(17)=angle(zernike_hu(img_bin,4,0));
    feature(18)=angle(zernike_hu(img_bin,4,2));
    feature(19)=angle(zernike_hu(img_bin,4,4));
    
    %skeleton
    
    names{i}=bmps(i).name;
    features{i}=feature;
 end  

end 


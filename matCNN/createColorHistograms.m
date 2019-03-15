function createColorHistograms(im_str)  
  
if ~isstr(im_str)  
    if ndims(im_str)==3  
        try  
            col_array_vals=double(im_str);  
        catch  
            disp('Input is not a valid three-dimensional array');  
            return;  
        end  
    end  
else  
    try  
        col_array_vals=double(imread(im_str));  
        if ndims(col_array_vals)~=3  
            disp('Input is not a valid three-dimensional array');  
            return;  
        end  
  
    catch  
        disp('Input string does not point to a valid image file');  
        return;  
    end  
end  
  
res_val=90;  
  
t_count=res_val*floor(col_array_vals(:,:,1)/res_val)+256*(res_val*floor(col_array_vals(:,:,2)/res_val))+256*256*(res_val*floor(col_array_vals(:,:,3)/res_val));  
t_count=sort(t_count(:));  
  
[col_val,ind_first]=unique(t_count,'first');  
[col_val,ind_last]=unique(t_count,'last');  
disp('Drawing color bars')  
  
disp('Drawing image')  
subplot(121);  
set(gcf,'position',[5   61   274   236]);  
imshow(col_array_vals/255)  
colorbars(col_val,ind_last-ind_first,1/3,1/4)  
  
  
function colorbars(triplet_color,triplet_freq,varargin)  
  
if nargin==2  
    color_pow=1/3;  
    freq_pow=1/4;  
else  
    color_pow=varargin{1};  
    freq_pow=varargin{2};  
end  
  
N_rand=randperm(length(triplet_freq));  
triplet_freq=sqrt(triplet_freq(N_rand));  
triplet_color=triplet_color(N_rand);  
  
triplet_color=([rem(triplet_color,256) floor(rem(triplet_color,256*256)/255) floor(triplet_color/(256*256))]/255);  
triplet_color_norm=triplet_color./repmat(((sum(triplet_color.^(1),2))+.005),1,3);  
max(triplet_color_norm)  
triplet_diff=sum(abs(triplet_color_norm-repmat(triplet_color_norm(end,:),size(triplet_color_norm,1),1)),2);  
  
triplet_diff=sum(abs(triplet_color_norm-repmat([.9 0 0],size(triplet_color_norm,1),1)),2);  
  
max(triplet_diff)  
  
triplet_diff=(triplet_diff/max(triplet_diff).^(color_pow))+(triplet_freq*0).^(freq_pow);  
  
  
  
[d,inds_sort]=sort(triplet_diff);  
triplet_freq=(triplet_freq(inds_sort));  
triplet_color=(triplet_color(inds_sort,:));  
  
num_bars=length(triplet_color);  
max_val=max(triplet_freq);  
% close all;  
subplot(122);  
axis([0 num_bars 0 1]);  
%%   
    [~,ind] = max(triplet_freq);  
    triplet_color(ind,:)=[];  
    triplet_freq(ind,:)=[];  
    num_bars = num_bars-1;  
%%     
for i=1:num_bars  
    tempColor=min(triplet_color(i,:),.9);  
    %===  
    % Use patch to draw individual bars  
    %===  
    patch([i-1 i-1 i i],...  
        [0 triplet_freq(i)/max_val triplet_freq(i)/max_val 0],...  
        tempColor,...  
        'edgecolor',...  
        tempColor);  
      
end  
% colorbar('LineWidth',1);  
  
set(gca,'xtick',[0:10:255])  
set(gca,'ytick',[0:0.05:1])  
set(gcf,'position',[5 378 560 420]);  
set(gca,'visible','on')  
  
function y_val=sigmoidVal(x_val,varargin)  
  
if nargin==1  
    multip_val=15;  
else  
    multip_val=varargin{1};  
end  
  
y_val=1./(1+exp(-(x_val-.5)*multip_val));
 
function  [imf_de,res_de]=decompsition(input_img,T)
 input_img = input_img(:,:,1);
[width, height]=size(input_img);
x=1:width;
y=1:height;
input_img_temple=input_img;
 
while(1)
    [zmax, imax, zmin, imin]=extrema2(input_img_temple,1);  %%%%图像表面极值点
    [xmax, ymax]=ind2sub(size(input_img_temple),imax);
    [xmin, ymin]=ind2sub(size(input_img_temple),imin);
 
    [zmaxgrid,~,~]=gridfit(ymax,xmax,zmax,y,x);  %%%%曲面拟合，寻找包络面的的极值点
    [zmingrid,~,~]=gridfit(ymin,xmin,zmin,y,x);
 
 
    zavggrid=(zmaxgrid+zmingrid)/2;   %%%%包络均值
 
    %%%%%%IMF分量判断%%%%%
    imf_de=input_img_temple-zavggrid;
%     subplot(2,2,k)
%     imshow(imf_de)
    SD=sum(sum(imf_de-input_img_temple).^2)/sum(sum(imf_de).^2);
    if SD<T
        break
    else 
        input_img_temple=imf_de;
    end
end
res_de=input_img-imf_de;
end
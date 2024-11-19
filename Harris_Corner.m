function Harris_Corner()

%% Harris Corner Detector

% Importing the image

Image=double(imread('i235.png'));
figure,imagesc(Image),colormap gray

%compute x and y derivative of the image

dx=[1 0 -1; 2 0 -2; 1 0 -1];
dy=[1 2 1; 0  0  0; -1 -2 -1];
Ix=conv2(Image,dx,'same');
Iy=conv2(Image,dy,'same');
figure,imagesc(Ix),colormap gray,title('Ix')
figure,imagesc(Iy),colormap gray,title('Iy')

%compute products of derivatives at every pixel
Ix2=Ix.*Ix; Iy2=Iy.*Iy; Ixy=Ix.*Iy;

%compute the sum of products of  derivatives at each pixel
g = fspecial('gaussian', 9, 1.2);
figure,imagesc(g),colormap gray,title('Gaussian')
Sx2=conv2(Ix2,g,'same'); Sy2=conv2(Iy2,g,'same'); Sxy=conv2(Ixy,g,'same');


%features detection
[rr,cc]=size(Sx2);
Corner_reg=zeros(rr,cc); Other_reg=zeros(rr,cc); 
R_map=zeros(rr,cc);
k=0.05; % Constant between 0.04 and 0.06

for ii=1:rr
    for jj=1:cc
        
        %define at each pixel x,y the matrix
        M=[Sx2(ii,jj),Sxy(ii,jj);Sxy(ii,jj),Sy2(ii,jj)];
        
        %compute the response of the detector at each pixel
        R=det(M) - k*(trace(M).^2);
        R_map(ii,jj)=R;
        
        
    end
end

M_bar = max(R_map,[],'all');
Thres = 0.3 * M_bar; % Threshold definition

for i = 1:rr

    for j = 1:cc

        %threshod on value of R
        if R_map(i,j) > Thres

            Corner_reg(i,j)=1;
        else
            Other_reg(i,j)=1;  % Flat or edge areas
        end

    end

end



figure,imagesc(Corner_reg.*Image),colormap gray,title('corner regions')
figure,imagesc(Other_reg.*Image),colormap gray,title('Other regions')
figure,imagesc(R_map),colormap jet,title('R map')

labeledImage = bwlabel(Corner_reg);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');

figure,imagesc(Image),colormap gray,title('detected Corners')
hold on

for i = 1:size(prop,1)

    xc=floor(prop(i).Centroid(1));
    yc=floor(prop(i).Centroid(2));
    ul_corner_width=prop(i).BoundingBox;
    plot(xc,yc,'*r')
   
    

end

end
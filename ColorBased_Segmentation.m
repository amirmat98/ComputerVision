function ColorBased_Segmentation()

I1 = imread('ur_c_s_03a_01_L_0376.png');
I2 = imread('ur_c_s_03a_01_L_0377.png');
I3 = imread('ur_c_s_03a_01_L_0378.png');
I4 = imread('ur_c_s_03a_01_L_0379.png');
I5 = imread('ur_c_s_03a_01_L_0380.png');
I6 = imread('ur_c_s_03a_01_L_0381.png');

figure
% Gray images
I1_Gray = rgb2gray(I1) ; 
I2_Gray = rgb2gray(I2) ; 
I3_Gray = rgb2gray(I3) ; 
I4_Gray = rgb2gray(I4) ; 
I5_Gray = rgb2gray(I5) ; 
I6_Gray = rgb2gray(I6) ; 

% HSV Images
I1_HSV=rgb2hsv(I1);
I2_HSV=rgb2hsv(I2);
I3_HSV=rgb2hsv(I3);
I4_HSV=rgb2hsv(I4);
I5_HSV=rgb2hsv(I5);
I6_HSV=rgb2hsv(I6);

% H, S and V components of the image 
I1_H = I1_HSV(:,:,1) ;   I1_S = I1_HSV(:,:,2) ; I1_V = I1_HSV(:,:,3) ; 
I2_H = I2_HSV(:,:,1) ;   I2_S = I2_HSV(:,:,2) ; I2_V = I2_HSV(:,:,3) ; 
I3_H = I3_HSV(:,:,1) ;   I3_S = I3_HSV(:,:,2) ; I3_V = I3_HSV(:,:,3) ; 
I4_H = I4_HSV(:,:,1) ;   I4_S = I4_HSV(:,:,2) ; I4_V = I4_HSV(:,:,3) ; 
I5_H = I5_HSV(:,:,1) ;   I5_S = I5_HSV(:,:,2) ; I5_V = I5_HSV(:,:,3) ; 
I6_H = I6_HSV(:,:,1) ;   I6_S = I6_HSV(:,:,2) ; I6_V = I6_HSV(:,:,3) ; 

%% Black Car

% finding the range in the H segment of the first image

figure ; imagesc(I1_HSV(:,:,1));colormap gray 
I1_Car_HSV = I1_HSV(390:400,575:595,:);
figure ; imagesc(I1_Car_HSV(:,:,1));

% Mean and standard deviation chosing 
Mean = mean(I1_Car_HSV(:,:,1),'all');
STD = std2(I1_Car_HSV(:,:,1));
%% applying to the picture 1

[rr,cc,pp]=size(I1_HSV);
mask=I1_HSV(:,:,1) > Mean-STD & I1_HSV(:,:,1) < Mean+STD; % defining the range to be considered for the mask
seg1=zeros(rr,cc);
seg1=seg1+mask;

labeledImage = bwlabel(seg1);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc1=floor(LargestSeg(1).Centroid(1));
yc1=floor(LargestSeg(1).Centroid(2));
ul_corner_width1=LargestSeg(1).BoundingBox;

%% applying to the picture 2

[rr,cc,pp]=size(I2_HSV);
mask=I2_HSV(:,:,1) > Mean-STD & I2_HSV(:,:,1) < Mean+STD; % defining the range to be considered for the mask
seg2=zeros(rr,cc);
seg2=seg2+mask;

labeledImage = bwlabel(seg2);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc2=floor(LargestSeg(1).Centroid(1));
yc2=floor(LargestSeg(1).Centroid(2));
ul_corner_width2=LargestSeg(1).BoundingBox;

%% applying to the picture 3

[rr,cc,pp]=size(I3_HSV);
mask=I3_HSV(:,:,1) > Mean-STD & I3_HSV(:,:,1) < Mean+STD; % defining the range to be considered for the mask
seg3=zeros(rr,cc);
seg3=seg3+mask;

labeledImage = bwlabel(seg3);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc3=floor(LargestSeg(1).Centroid(1));
yc3=floor(LargestSeg(1).Centroid(2));
ul_corner_width3=LargestSeg(1).BoundingBox;


%% applying to the picture 4

[rr,cc,pp]=size(I4_HSV);
mask=I4_HSV(:,:,1) > Mean-STD & I4_HSV(:,:,1) < Mean+STD; % defining the range to be considered for the mask
seg4=zeros(rr,cc);
seg4=seg4+mask;

labeledImage = bwlabel(seg4);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc4=floor(LargestSeg(1).Centroid(1));
yc4=floor(LargestSeg(1).Centroid(2));
ul_corner_width4=LargestSeg(1).BoundingBox;

%% applying to the picture 5

[rr,cc,pp]=size(I5_HSV);
mask=I5_HSV(:,:,1) > Mean-STD & I5_HSV(:,:,1) < Mean+STD; % defining the range to be considered for the mask
seg5=zeros(rr,cc);
seg5=seg5+mask;

labeledImage = bwlabel(seg5);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc5=floor(LargestSeg(1).Centroid(1));
yc5=floor(LargestSeg(1).Centroid(2));
ul_corner_width5=LargestSeg(1).BoundingBox;

%% applying to the picture 6

[rr,cc,pp]=size(I6_HSV);
mask=I6_HSV(:,:,1) > Mean-STD & I6_HSV(:,:,1) < Mean+STD; % defining the range to be considered for the mask
seg6=zeros(rr,cc);
seg6=seg6+mask;

labeledImage = bwlabel(seg6);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc6=floor(LargestSeg(1).Centroid(1));
yc6=floor(LargestSeg(1).Centroid(2));
ul_corner_width6=LargestSeg(1).BoundingBox;

% Plotting Images

figure
subplot(2,3,1),imagesc(seg1),colormap gray,title('detected object 1')
hold on
plot(xc1,yc1,'*r')
rectangle('Position',ul_corner_width1,'EdgeColor',[1,0,0])

subplot(2,3,2),imagesc(seg2),colormap gray,title('detected object 2')
hold on
plot(xc2,yc2,'*r')
rectangle('Position',ul_corner_width2,'EdgeColor',[1,0,0])

subplot(2,3,3),imagesc(seg3),colormap gray,title('detected object 3')
hold on
plot(xc3,yc3,'*r')
rectangle('Position',ul_corner_width3,'EdgeColor',[1,0,0])

subplot(2,3,4),imagesc(seg4),colormap gray,title('detected object 4')
hold on
plot(xc4,yc4,'*r')
rectangle('Position',ul_corner_width4,'EdgeColor',[1,0,0])

subplot(2,3,5),imagesc(seg5),colormap gray,title('detected object 5')
hold on
plot(xc5,yc5,'*r')
rectangle('Position',ul_corner_width5,'EdgeColor',[1,0,0])

subplot(2,3,6),imagesc(seg6),colormap gray,title('detected object 6')
hold on
plot(xc6,yc6,'*r')
rectangle('Position',ul_corner_width6,'EdgeColor',[1,0,0])



figure
subplot(2,3,1),imagesc(I1_Gray),colormap gray,title('detected object 1')
hold on
plot(xc1,yc1,'*r')
rectangle('Position',ul_corner_width1,'EdgeColor',[1,0,0])

subplot(2,3,2),imagesc(I2_Gray),colormap gray,title('detected object 2')
hold on
plot(xc2,yc2,'*r')
rectangle('Position',ul_corner_width2,'EdgeColor',[1,0,0])

subplot(2,3,3),imagesc(I3_Gray),colormap gray,title('detected object 3')
hold on
plot(xc3,yc3,'*r')
rectangle('Position',ul_corner_width3,'EdgeColor',[1,0,0])

subplot(2,3,4),imagesc(I4_Gray),colormap gray,title('detected object 4')
hold on
plot(xc4,yc4,'*r')
rectangle('Position',ul_corner_width4,'EdgeColor',[1,0,0])

subplot(2,3,5),imagesc(I5_Gray),colormap gray,title('detected object 5')
hold on
plot(xc5,yc5,'*r')
rectangle('Position',ul_corner_width5,'EdgeColor',[1,0,0])

subplot(2,3,6),imagesc(I6_Gray),colormap gray,title('detected object 6')
hold on
plot(xc6,yc6,'*r')
rectangle('Position',ul_corner_width6,'EdgeColor',[1,0,0])

%% Red car

%% finding the range

figure ; imagesc(I1_HSV(:,:,1));colormap gray 
I1_Car_HSV = I1_HSV(390:400,575:595,:);
figure ; imagesc(I1_Car_HSV(:,:,1));

Mean = mean(I1_Car_HSV(:,:,1),'all');
STD = std2(I1_Car_HSV(:,:,1));
%% applying to the picture 1

[rr,cc,pp]=size(I1_HSV);
mask=I1_HSV(:,:,1) > 0.97 & I1_HSV(:,:,1) < 1; % defining the range to be considered for the mask
seg1=zeros(rr,cc);
seg1=seg1+mask;

labeledImage = bwlabel(seg1);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox'); 
[~,Index] = max([prop.Area]); 
LargestSeg = prop(Index);

xc1=floor(LargestSeg(1).Centroid(1));
yc1=floor(LargestSeg(1).Centroid(2));
ul_corner_width1=LargestSeg(1).BoundingBox;

%% applying to the picture 2

[rr,cc,pp]=size(I2_HSV);
mask=I2_HSV(:,:,1) > 0.97 & I2_HSV(:,:,1) < 1; % defining the range to be considered for the mask
seg2=zeros(rr,cc);
seg2=seg2+mask;

labeledImage = bwlabel(seg2);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc2=floor(LargestSeg(1).Centroid(1));
yc2=floor(LargestSeg(1).Centroid(2));
ul_corner_width2=LargestSeg(1).BoundingBox;

%% applying to the picture 3

[rr,cc,pp]=size(I3_HSV);
mask=I3_HSV(:,:,1) > 0.97 & I3_HSV(:,:,1) < 1; % defining the range to be considered for the mask
seg3=zeros(rr,cc);
seg3=seg3+mask;

labeledImage = bwlabel(seg3);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc3=floor(LargestSeg(1).Centroid(1));
yc3=floor(LargestSeg(1).Centroid(2));
ul_corner_width3=LargestSeg(1).BoundingBox;

%% applying to the picture 4

[rr,cc,pp]=size(I4_HSV);
mask=I4_HSV(:,:,1) > 0.97 & I4_HSV(:,:,1) <1; % defining the range to be considered for the mask
seg4=zeros(rr,cc);
seg4=seg4+mask;

labeledImage = bwlabel(seg4);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc4=floor(LargestSeg(1).Centroid(1));
yc4=floor(LargestSeg(1).Centroid(2));
ul_corner_width4=LargestSeg(1).BoundingBox;

%% applying to the picture 5

[rr,cc,pp]=size(I5_HSV);
mask=I5_HSV(:,:,1) >0.97 & I5_HSV(:,:,1) < 1; % defining the range to be considered for the mask
seg5=zeros(rr,cc); 
seg5=seg5+mask;

labeledImage = bwlabel(seg5);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc5=floor(LargestSeg(1).Centroid(1));
yc5=floor(LargestSeg(1).Centroid(2));
ul_corner_width5=LargestSeg(1).BoundingBox;

%% applying to the picture 6

[rr,cc,pp]=size(I6_HSV);
mask=I6_HSV(:,:,1) > 0.97 & I6_HSV(:,:,1) < 1; % defining the range to be considered for the mask
seg6=zeros(rr,cc);
seg6=seg6+mask;

labeledImage = bwlabel(seg6);
prop=regionprops(labeledImage, 'Area','Centroid','BoundingBox');
[~,Index] = max([prop.Area]);
LargestSeg = prop(Index);

xc6=floor(LargestSeg(1).Centroid(1));
yc6=floor(LargestSeg(1).Centroid(2));
ul_corner_width6=LargestSeg(1).BoundingBox;

% Plotting Images

figure
subplot(2,3,1),imagesc(seg1),colormap gray,title('detected object 1')
hold on
plot(xc1,yc1,'*r')
rectangle('Position',ul_corner_width1,'EdgeColor',[1,0,0])

subplot(2,3,2),imagesc(seg2),colormap gray,title('detected object 2')
hold on
plot(xc2,yc2,'*r')
rectangle('Position',ul_corner_width2,'EdgeColor',[1,0,0])

subplot(2,3,3),imagesc(seg3),colormap gray,title('detected object 3')
hold on
plot(xc3,yc3,'*r')
rectangle('Position',ul_corner_width3,'EdgeColor',[1,0,0])

subplot(2,3,4),imagesc(seg4),colormap gray,title('detected object 4')
hold on
plot(xc4,yc4,'*r')
rectangle('Position',ul_corner_width4,'EdgeColor',[1,0,0])

subplot(2,3,5),imagesc(seg5),colormap gray,title('detected object 5')
hold on
plot(xc5,yc5,'*r')
rectangle('Position',ul_corner_width5,'EdgeColor',[1,0,0])

subplot(2,3,6),imagesc(seg6),colormap gray,title('detected object 6')
hold on
plot(xc6,yc6,'*r')
rectangle('Position',ul_corner_width6,'EdgeColor',[1,0,0])



figure
subplot(2,3,1),imagesc(I1_Gray),colormap gray,title('detected object 1')
hold on
plot(xc1,yc1,'*r')
rectangle('Position',ul_corner_width1,'EdgeColor',[1,0,0])

subplot(2,3,2),imagesc(I2_Gray),colormap gray,title('detected object 2')
hold on
plot(xc2,yc2,'*r')
rectangle('Position',ul_corner_width2,'EdgeColor',[1,0,0])

subplot(2,3,3),imagesc(I3_Gray),colormap gray,title('detected object 3')
hold on
plot(xc3,yc3,'*r')
rectangle('Position',ul_corner_width3,'EdgeColor',[1,0,0])

subplot(2,3,4),imagesc(I4_Gray),colormap gray,title('detected object 4')
hold on
plot(xc4,yc4,'*r')
rectangle('Position',ul_corner_width4,'EdgeColor',[1,0,0])

subplot(2,3,5),imagesc(I5_Gray),colormap gray,title('detected object 5')
hold on
plot(xc5,yc5,'*r')
rectangle('Position',ul_corner_width5,'EdgeColor',[1,0,0])

subplot(2,3,6),imagesc(I6_Gray),colormap gray,title('detected object 6')
hold on
plot(xc6,yc6,'*r')
rectangle('Position',ul_corner_width6,'EdgeColor',[1,0,0])


end 
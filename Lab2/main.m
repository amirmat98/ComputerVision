% Computer Vision Lab 2

%%-----------------------------------------------------------------------%%
% Author: Amirmahdi Matin - s5884715                                                 
%%-----------------------------------------------------------------------%%

% This is the main script for the Lab2.
% Ensure the code and images are in the same directory.
% Local functions are defined at external files that is must be in this
% directory
% Each section of the code is separated with comments.
% Multiple figures are generated, each labeled with titles for clarity.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear; close all;

%% Read Image

Image1 = double(imread('tree.png'));
Image2 = double(imread('i235.png'));

%% Add noises

% Add Guassian noise 

Image1_GNoise = Guassian_Noise(Image1 , 20);
Image2_GNoise = Guassian_Noise(Image2 , 20);

% Add Salt and Pepper noise 

Image1_SaltPNoise = Salt_Pepper(Image1 , 0.2);
Image2_SaltPNoise = Salt_Pepper(Image2 , 0.2);

%% Show the Original images, noisy images and the histograms

figure
subplot(3,2,1) , imagesc(uint8(Image1)), colormap gray(256)
title('Original Image 1')
subplot(3,2,2) , imhist(uint8(Image1),256)
title('Original Image 1 histogram')
subplot(3,2,3) , imagesc(uint8(Image1_GNoise)), colormap gray(256)
title(' Image 1 (with Guassian Noise)')
subplot(3,2,4) , imhist(uint8(Image1_GNoise),256)
title('Image 1 (with Guassian Noise)')
subplot(3,2,5) , imagesc(uint8(Image1_SaltPNoise)), colormap gray(256)
title(' Image 1 (with Salt & Pepper Noise)')
subplot(3,2,6) , imhist(uint8(Image1_SaltPNoise),256)
title('Image 1 (with Salt & Pepper Noise)')

figure
subplot(3,2,1), imagesc(uint8(Image2)), colormap gray(256)
title('Original Image 2')
subplot(3,2,2), imhist(uint8(Image2) , 256)
title('Original Image 2 histogram')
subplot(3,2,3), imagesc(uint8(Image2_GNoise)), colormap gray(256)
title('Image 2 (with Guassian Noise)')
subplot(3,2,4), imhist(uint8(Image2_GNoise) , 256)
title('Image 2 (with Guassian Noise)')
subplot(3,2,5), imagesc(uint8(Image2_SaltPNoise)), colormap gray(256)
title('Image 2 (with Salt & Pepper Noise)')
subplot(3,2,6), imhist(uint8(Image2_SaltPNoise) , 256)
title('Image 2 (with Salt & Pepper Noise)')

%% Define Moving Average Filters and apply them 

AFilter3 = 1/9*ones(3) ;
AFilter7 = 1/49*ones(7) ;


figure 
subplot(1,2,1), imagesc(uint8(AFilter3)), colormap gray(256)
title("3*3 Moving average Filter")
subplot(1,2,2) , surf(AFilter3)
title("3*3 Moving average Filter")

figure 
subplot(1,2,1), imagesc(uint8(AFilter7)), colormap gray(256)
title("7*7 Moving average Filter")
subplot(1,2,2) , surf(AFilter7)
title("7*7 Moving average Filter")

% moving average filter on Image1 Guassian Noise

Image1_GNoise_AF3 = conv2(Image1_GNoise , AFilter3 , "same") ; 
Image1_GNoise_AF7 = conv2(Image1_GNoise , AFilter7 , "same") ; 

Drawing(Image1_GNoise_AF3 , "Gaussian" , "Moving Average" , 3)
Drawing(Image1_GNoise_AF7 , "Gaussian" , "Moving Average" , 7)


% moving average filter on Image1 Salt & Pepper Noise

Image1_SaltPNoise_AF3 = conv2(Image1_SaltPNoise , AFilter3 , "same") ; 
Image1_SaltPNoise_AF7 = conv2(Image1_SaltPNoise , AFilter7 , "same") ; 

Drawing(Image1_SaltPNoise_AF3 , "Salt Pepper" , "Moving Average" , 3)
Drawing(Image1_SaltPNoise_AF7 , "Salt Pepper" , "Moving Average" , 7)

% Movine average on Image 2 Guassian Noise

Image2_GNoise_AF3 = conv2(Image2_GNoise , AFilter3 , "same") ; 
Image2_GNoise_AF7 = conv2(Image2_GNoise , AFilter7 , "same") ; 

Drawing(Image2_GNoise_AF3 , "Gaussian" , "Moving Average" , 3)
Drawing(Image2_GNoise_AF7 , "Gaussian" , "Moving Average" , 7)

% moving average filter on Image 2 Salt & Pepper Noise

Image2_SaltPNoise_AF3 = conv2(Image2_SaltPNoise , AFilter3 , "same") ; 
Image2_SaltPNoise_AF7 = conv2(Image2_SaltPNoise , AFilter7 , "same") ; 

Drawing(Image2_SaltPNoise_AF3 , "Salt Pepper" , "Moving Average" , 3)
Drawing(Image2_SaltPNoise_AF7 , "Salt Pepper" , "Moving Average" , 7)


%% Define Low Pass Guassian Filters and apply them 

% 3*3 Low Pass Guassian filter

h1 = fspecial('gaussian' , 3 , 0.5);
figure
subplot(1,2,1) , imagesc(h1);colormap gray
title("Low pass 3*3 Guassian Filter and deviation 0.5")
subplot(1,2,2) , surf(h1)
title("Low pass 3*3 Guassian Filter and deviation 0.5")


h2 = fspecial('gaussian' , 7 , 7/6);
figure
subplot(1,2,1) , imagesc(h2);colormap gray
title("Low pass 7*7 Guassian Filter and deviation 7/6")
subplot(1,2,2) , surf(h1)
title("Low pass 7*7 Guassian Filter and deviation 7/6")

% Low Pass Guassian filter on Image1 Guassian Noise

Image1_GNoise_GF3 = imfilter(Image1_GNoise, h1); 
Image1_GNoise_GF7 = imfilter(Image1_GNoise, h2);

Drawing(Image1_GNoise_GF3 , "Gaussian" , "Low pass Gaussian" , 3)
Drawing(Image1_GNoise_GF7 , "Gaussian" , "Low pass Gaussian" , 7)

% Low Pass Guassian filter on Image2 Guassian Noise

Image2_GNoise_GF3 = imfilter(Image2_GNoise, h1); 
Image2_GNoise_GF7 = imfilter(Image2_GNoise, h2); 

Drawing(Image2_GNoise_GF3 , "Gaussian" , "Low pass Gaussian" , 3)
Drawing(Image2_GNoise_GF7 , "Gaussian" , "Low pass Gaussian" , 7)

% Low Pass Guassian filter on Image1 Salt&Pepper Noise

Image1_SaltPNoise_GF3 = imfilter(Image1_SaltPNoise, h1); 
Image1_SaltPNoise_GF7 = imfilter(Image1_SaltPNoise, h2); 

Drawing(Image1_SaltPNoise_GF3 , "Salt Pepper" , "Low pass Gaussian" , 3)
Drawing(Image1_SaltPNoise_GF7 , "Salt Pepper" , "Low pass Gaussian" , 7)

% Low Pass Guassian filter on Image2 Salt Pepper Noise

Image2_SaltPNoise_GF3 = imfilter(Image2_SaltPNoise, h1); 
Image2_SaltPNoise_GF7 = imfilter(Image2_SaltPNoise, h2); 

Drawing(Image2_SaltPNoise_GF3 , "Salt Pepper" , "Low pass Gaussian" , 3)
Drawing(Image2_SaltPNoise_GF7 , "Salt Pepper" , "Low pass Gaussian" , 7)

%% Define Median Filters and apply them 

Image1_GNoise_MF3 = medfilt2(Image1_GNoise , [3 3]) ;
Image1_GNoise_MF7 = medfilt2(Image1_GNoise , [7 7]) ;
Drawing(Image1_GNoise_MF3 , "Gaussian" , "Median Filter" , 3)
Drawing(Image1_GNoise_MF7 , "Gaussian" , "Median Filter" , 7)

Image1_SaltPNoise_MF3 = medfilt2(Image1_SaltPNoise , [3 3]) ;
Image1_SaltPNoise_MF7 = medfilt2(Image1_SaltPNoise , [7 7]) ;
Drawing(Image1_SaltPNoise_MF3 , "Salt Pepper" , "Median Filter" , 3)
Drawing(Image1_SaltPNoise_MF7 , "Salt Pepper" , "Median Filter" , 7)

Image2_GNoise_MF3 = medfilt2(Image2_GNoise , [3 3]) ;
Image2_GNoise_MF7 = medfilt2(Image2_GNoise , [7 7]) ;
Drawing(Image2_GNoise_MF3 , "Gaussian" , "Median Filter" , 3)
Drawing(Image2_GNoise_MF7 , "Gaussian" , "Median Filter" , 7)

Image2_SaltPNoise_MF3 = medfilt2(Image2_SaltPNoise , [3 3]) ;
Image2_SaltPNoise_MF7 = medfilt2(Image2_SaltPNoise , [7 7]) ;
Drawing(Image2_SaltPNoise_MF3 , "Salt Pepper" , "Median Filter" , 3)
Drawing(Image2_SaltPNoise_MF7 , "Salt Pepper" , "Median Filter" , 7)


%% Linear Filters

F1 = zeros(7);
F1(4,4) = 1;
figure
subplot(2,1,1), imagesc(F1) ,colormap gray(256)
subplot(2,1,2), surf(F1)

% This filter moves the image horizontaly or vertically 
F2 = zeros(7);
F2(4,7) = 1;
figure 
subplot(2,1,1), imagesc(F2) ,colormap gray(256)
subplot(2,1,2), surf(F2)

% This filter is the sharpening filter
F3 = zeros(7);
F3(4,4) = 2;
F3 = F3 - 1/49*ones(7);
figure
subplot(2,1,1), imagesc(F3) ,colormap gray(256)
subplot(2,1,2), surf(F3)

% This filter is the sharpening filter
F4 = zeros(7);
F4(4,4) = 3;
F4 = F4 - 1/49*ones(7);
figure
subplot(2,1,1), imagesc(F4) ,colormap gray(256)
subplot(2,1,2), surf(F4)

Image1F1 = conv2(Image1 , F1,'same');
figure 
subplot(2,2,1), imagesc(uint8(Image1F1)) , colormap gray(256)
title("Filter 1 on Image1")

Image1F2 = conv2(Image1 , F2,'same');
subplot(2,2,2), imagesc(uint8(Image1F2)) , colormap gray(256)
title("Filter 2 on Image 1")

Image1F3 = conv2(Image1 , F3,'same');
subplot(2,2,3) , imagesc(uint8(Image1F3)) , colormap gray(256)
title("Filter 3 on Image 1")

Image1F4 = conv2(Image1 , F4,'same');
subplot(2,2,4) , imagesc(uint8(Image1F4)) , colormap gray(256)
title("Filter 4 on Image 1")

%
Image2F1 = conv2(Image2 , F1,'same');
figure 
subplot(2,2,1), imagesc(uint8(Image2F1)) , colormap gray(256)
title("Filter 1 on Image2")

Image2F2 = conv2(Image2 , F2,'same');
subplot(2,2,2), imagesc(uint8(Image2F2)) , colormap gray(256)
title("Filter 2 on Image 2")

Image2F3 = conv2(Image2 , F3,'same');
subplot(2,2,3) , imagesc(uint8(Image2F3)) , colormap gray(256)
title("Filter 3 on Image 2")

Image2F4 = conv2(Image2 , F4,'same');
subplot(2,2,4) , imagesc(uint8(Image2F4)) , colormap gray(256)
title("Filter 4 on Image 2")

%% Apply Fourier Transforms 

%Image 1

Image1_fft=fft2(Image1);
Mag1=abs(fft2(Image1));
Phi1=angle(fft2(Image1));


figure,imagesc(Image1), colormap gray, axis ('square')
figure,imagesc(log(fftshift(Mag1))), colormap gray,xlabel('wx'),ylabel('wy'),axis ('square')


%Image 2

Image2_fft=fft2(Image2);
Mag2=abs(Image2_fft);
Phi2=angle(Image2_fft);


figure,imagesc(Image2), colormap gray, axis ('square')
figure,imagesc(log(fftshift(Mag2))), colormap gray,xlabel('wx'),ylabel('wy'),axis ('square'),title("Magnitude log of the transformed Image")


% Low pass Guassian Filter

LGFilter = fspecial('gaussian' , 101 , 5);
Mag3=abs(fft2(LGFilter));
Phi3=angle(fft2(LGFilter));


figure,imagesc(LGFilter), colormap gray, axis ('square')
figure,imagesc(log(fftshift(Mag3))), colormap gray,xlabel('wx'),ylabel('wy'),axis ('square') ,title("Magnitude log of the Gaussian filter")


% Sharpening Filter

OO = zeros(7);
OO(4,4) = 2;
SharpFilter1 = OO-1/49*ones(7);
SharpFilter = zeros(101);
SharpFilter(48:54 , 48:54) = SharpFilter1; 

Mag4=abs(fft2(SharpFilter));
Phi4=angle(fft2(SharpFilter));


figure,imagesc(SharpFilter), colormap gray, axis ('square')
figure,imagesc(log(fftshift(Mag4))), colormap gray,xlabel('wx'),ylabel('wy'),axis ('square'), title("Magnitude log of the Sharpening filter")


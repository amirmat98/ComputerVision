function Template_Matching()

%% Input Images

% In this part the six images captured at different parts of a video are
% imported and changed to grey scale images

Image1=rgb2gray(imread('ur_c_s_03a_01_L_0376.png'));


Image2=rgb2gray(imread('ur_c_s_03a_01_L_0377.png'));


Image3=rgb2gray(imread('ur_c_s_03a_01_L_0378.png'));


Image4=rgb2gray(imread('ur_c_s_03a_01_L_0379.png'));


Image5=rgb2gray(imread('ur_c_s_03a_01_L_0380.png'));


Image6=rgb2gray(imread('ur_c_s_03a_01_L_0381.png'));


%% Patch Definition 

% Red Car

% A part of the picture which contains the Red car in the first images is
% chosen as the patch and displayed 
 
P1 = Image1(350:430 , 680:780) ; 
[Row1,Col1] = size(P1);
figure,imagesc(P1),colormap gray
title('patch for the Red Car')


% Black Car

% A part of the picture which contains the Black car in the first images is
% chosen as the patch and displayed 

% P2 = Image1(350:440 , 540:650) ; 
P2 = Image1(365:415 , 555:645) ; 
[Row2,Col2] = size(P2);
figure,imagesc(P2),colormap gray
title('patch for the Black car')
%% Applying Normal Cross Correlation for Red Car 


% applying the first patch to all 6 images for template matching 

NCC1 = normxcorr2(P1 , Image1) ; 
Max1 = max(NCC1 , [] , 'all') ; 
[Center1_row,Center1_col] = find(NCC1 == Max1) ;  % Finding center and column for the maximum value of the score map 
figure
subplot(2,3,1) , imagesc(Image1),colormap gray
rectangle('Position',[Center1_col-Col1 , Center1_row-Row1 , Col1 ,Row1],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center1_col-Col1/2,Center1_row-Row1/2, 'ro', 'MarkerSize', 4); % Showing the point with the maximum score on the image 

NCC2 = normxcorr2(P1 , Image2) ; 
Max2 = max(NCC2 , [] , 'all') ; 
[Center2_row,Center2_col] = find(NCC2 == Max2) ;  % Finding center and column for the maximum value of the score map 
subplot(2,3,2),imagesc(Image2),colormap gray
rectangle('Position',[Center2_col-Col1 , Center2_row-Row1, Col1 ,Row1],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center1_col-Col1/2,Center1_row-Row1/2, 'ro', 'MarkerSize', 4); % Showing the point with the maximum score on the image 

NCC3 = normxcorr2(P1 , Image3) ; 
Max3 = max(NCC3 , [] , 'all') ; 
[Center3_row,Center3_col] = find(NCC3 == Max3) ; % Finding center and column for the maximum value of the score map 
subplot(2,3,3),imagesc(Image3),colormap gray
rectangle('Position',[Center3_col-Col1 , Center3_row-Row1 , Col1 ,Row1],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center3_col-Col1/2,Center3_row-Row1/2, 'ro', 'MarkerSize', 4); % Showing the point with the maximum score on the image 

NCC4 = normxcorr2(P1 , Image4) ; 
Max4 = max(NCC4 , [] , 'all') ; 
[Center4_row,Center4_col] = find(NCC4 == Max4) ; % Finding center and column for the maximum value of the score map 
subplot(2,3,4),imagesc(Image4),colormap gray
rectangle('Position',[Center4_col-Col1 , Center4_row-Row1 , Col1 ,Row1],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center4_col-Col1/2,Center4_row-Row1/2, 'ro', 'MarkerSize', 4); % Showing the point with the maximum score on the image 
 
NCC5 = normxcorr2(P1 , Image5) ; 
Max5 = max(NCC5 , [] , 'all') ; 
[Center5_row,Center5_col] = find(NCC5 == Max5) ;  % Finding center and column for the maximum value of the score map 
subplot(2,3,5),imagesc(Image5),colormap gray
rectangle('Position',[Center5_col-Col1 , Center5_row-Row1 , Col1 ,Row1],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center5_col-Col1/2,Center5_row-Row1/2, 'ro', 'MarkerSize', 4); % Showing the point with the maximum score on the image 

NCC6 = normxcorr2(P1 , Image6) ; 
Max6 = max(NCC6 , [] , 'all') ; 
[Center6_row,Center6_col] = find(NCC6 == Max6) ;  % Finding center and column for the maximum value of the score map 
subplot(2,3,6),imagesc(Image6),colormap gray
rectangle('Position',[Center6_col-Col1 , Center6_row-Row1 , Col1 ,Row1],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center6_col-Col1/2,Center6_row-Row1/2, 'ro', 'MarkerSize', 4); % Showing the point with the maximum score on the image 

 
% Drawing Score map

figure
subplot(2,3,1),imagesc(NCC1),colormap gray
subplot(2,3,2),imagesc(NCC2),colormap gray
subplot(2,3,3),imagesc(NCC3),colormap gray
subplot(2,3,4),imagesc(NCC4),colormap gray
subplot(2,3,5),imagesc(NCC5),colormap gray
subplot(2,3,6),imagesc(NCC6),colormap gray

 
%% Applying Normal Cross Correlation for Black Car 


tic
NCC1 = normxcorr2(P2 , Image1) ; 
Max1 = max(NCC1 , [] , 'all') ; 
[Center1_row,Center1_col] = find(NCC1 == Max1) ;  % Finding center and column for the maximum value of the score map 
figure
subplot(2,3,1),imagesc(Image1),colormap gray
rectangle('Position',[Center1_col-Col2 , Center1_row-Row2 , Col2 ,Row2],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center1_col-Col2/2,Center1_row-Row2/2, 'ro', 'MarkerSize', 4); % Showing the point with the maximum score on the image 
toc

NCC2 = normxcorr2(P2 , Image2) ; 
Max2 = max(NCC2 , [] , 'all') ; 
[Center2_row,Center2_col] = find(NCC2 == Max2) ; % Finding center and column for the maximum value of the score map 
subplot(2,3,2),imagesc(Image2),colormap gray
rectangle('Position',[Center2_col-Col2 , Center2_row-Row2 , Col2 ,Row2],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center1_col-Col2/2,Center1_row-Row2/2, 'ro', 'MarkerSize', 4); % Showing the point with the maximum score on the image 

NCC3 = normxcorr2(P2 , Image3) ; 
Max3 = max(NCC3 , [] , 'all') ; 
[Center3_row,Center3_col] = find(NCC3 == Max3) ;   % Finding center and column for the maximum value of the score map
subplot(2,3,3),imagesc(Image3),colormap gray
rectangle('Position',[Center3_col-Col2 , Center3_row-Row2 , Col2 ,Row2],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center3_col-Col2/2,Center3_row-Row2/2, 'ro', 'MarkerSize', 4); % Showing the point with the maximum score on the image 

NCC4 = normxcorr2(P2 , Image4) ; 
Max4 = max(NCC4 , [] , 'all') ; 
[Center4_row,Center4_col] = find(NCC4 == Max4) ;   % Finding center and column for the maximum value of the score map
subplot(2,3,4),imagesc(Image4),colormap gray
rectangle('Position',[Center4_col-Col2 , Center4_row-Row2 , Col2 ,Row2],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center4_col-Col2/2,Center4_row-Row2/2, 'ro', 'MarkerSize', 4);  % Showing the point with the maximum score on the image 

NCC5 = normxcorr2(P2 , Image5) ; 
Max5 = max(NCC5 , [] , 'all') ; 
[Center5_row,Center5_col] = find(NCC5 == Max5) ;  % Finding center and column for the maximum value of the score map
subplot(2,3,5),imagesc(Image5),colormap gray
rectangle('Position',[Center5_col-Col2 , Center5_row-Row2 , Col2 ,Row2],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center5_col-Col2/2,Center5_row-Row2/2, 'ro', 'MarkerSize', 4);  % Showing the point with the maximum score on the image 

NCC6 = normxcorr2(P2 , Image6) ; 
Max6 = max(NCC6 , [] , 'all') ; 
[Center6_row,Center6_col] = find(NCC6 == Max6) ;  % Finding center and column for the maximum value of the score map
subplot(2,3,6),imagesc(Image6),colormap gray
rectangle('Position',[Center6_col-Col2 , Center6_row-Row2 , Col2 ,Row2],'EdgeColor', 'r') % Showing the rectangle around the area with the size of the tamplate
hold on, plot(Center6_col-Col2/2,Center6_row-Row2/2, 'ro', 'MarkerSize', 4);  % Showing the point with the maximum score on the image 

 
% Drawing Score map

figure
subplot(2,3,1),imagesc(NCC1),colormap gray
subplot(2,3,2),imagesc(NCC2),colormap gray
subplot(2,3,3),imagesc(NCC3),colormap gray
subplot(2,3,4),imagesc(NCC4),colormap gray
subplot(2,3,5),imagesc(NCC5),colormap gray
subplot(2,3,6),imagesc(NCC6),colormap gray

 
end



clc; clear; close all;

%% Imports

% [img1, img2, Points1, Points2] = import_files("Mire");
[img1, img2, Points1, Points2] = import_files("Rubik");

%% changin the size
% if the images are too large you might want to resize them to a smaller size
img1 = imresize(img1, 0.8);
img2 = imresize(img2, 0.8);

%% Run the image matching algorithm

list_ncc = findMatches(img1, img2, 'NCC');
list_sift = findMatches(img1, img2, 'SIFT');

show_matches(img1, img2, list_ncc, 0, 1);
show_matches(img1, img2, list_sift, 1, 2);

%% Changing the correspondences into homogeneous form 

list_sift_img1_Hom = [list_sift(:,1:2) , ones(size(list_sift,1) , 1)].' ; 
list_sift_img2_Hom = [list_sift(:,3:4) , ones(size(list_sift,1) , 1)].' ; 

list_ncc_img1_Hom = [list_ncc(:,1:2) , ones(size(list_ncc,1) , 1)].' ; 
list_ncc_img2_Hom = [list_ncc(:,3:4) , ones(size(list_ncc,1) , 1)].' ; 


%% performing ransac on F for matches found by NCC

% th = 0.04;
% [bestF, consensus, outliers] = ransacF(list_ncc_img1_Hom, list_ncc_img2_Hom, th) ; 

%% performing ransac on F for matches found by SIFT

th = 0.1;
[bestF, consensus, outliers] = ransacF(list_sift_img1_Hom, list_sift_img2_Hom, th) ; 

%% Visualization and validation 

visualizeEpipolarLines(img1, img2, bestF, consensus(1:2 , :).', consensus(4:5 , :).') ; 
Residuals = testF(bestF, consensus(1:3 , :), consensus(4:6 , :)) ; 

%% Computing right and left null spaces

[U , W, V] = svd(bestF) ;
Left_Null_1 = U(:,end) ;
Right_Null_1 = V(:,end) ;

%
Val1_1 = Right_Null_1.'*bestF ; 
Val1_2 = bestF*Left_Null_1 ;

Res1 = Left_Null_1.'*bestF*Right_Null_1 ; 

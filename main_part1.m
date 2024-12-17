clc
clear all
close all

% Importing both images and correspondences

[img, img1, Points1, Points2] = import_files("Mire");
%[img, img1, Points1, Points2] = import_files("Rubik");


P1 = [Points1.' ; ones(1 , size(Points1 , 1))]; 
P2 = [Points2.' ; ones(1 , size(Points2 , 1))]; 



% Showing the images and points on them 

% imshow(img)
% hold on
% plot(P1(1,:),P1(2,:),'*r')
% 
% figure
% imshow(img1)
% hold on
% plot(P2(1,:),P2(2,:),'*r')


% Getting the fundamental matrices using the 8 point algorithm  version 1
F1 = EightPointsAlgorithm(P1, P2) ; 

% Getting the fundamental matrices using the 8 point algorithm  version 2
F2 = EightPointsAlgorithmN(P1, P2) ; 
 

%% Evaluation of results checking the epipolar constraint 

Residuals_F1 = testF(F1, P1(1:3 , :), P2(1:3 , :)) ;
Residuals_F2 = testF(F2, P1(1:3 , :), P2(1:3 , :)) ;

% Visualizing Epopolar lines for both 2 versions of 8 points algorithm 

visualizeEpipolarLines(img, img1, F2, P1(1:2 , :).', P2(1:2 , :).') ; 

% figure(10) ,visualizeEpipolarLines(img, img1, F2, P1(1:2 , :).', P2(1:2 , :).') ; 

% visualizeEpipolarLines(img, img1, F2, [], [])
% figure(11), show_matches(img, img1, [P1(1:2 , :).' , P2(1:2 , :).'], 1, 11);

%% Computing right and left null spaces

[U1 , W1 , V1] = svd(F1) ;
Left_Null_1 = U1(:,end) ;
Right_Null_1 = V1(:,end) ;

%
Val1_1 = Right_Null_1.'*F1 ; 
Val1_2 = F1*Left_Null_1 ;

Res1 = Left_Null_1.'*F1*Right_Null_1 ; 

[U2 , W2 , V2] = svd(F2) ;
Left_Null_2 = U2(:,end) ;
Right_Null_2 = V2(:,end) ;

%
Val2_1 = Right_Null_2.'*F2 ; 
Val2_2 = F2*Left_Null_2 ; 

Res2 = Left_Null_2.'*F2*Right_Null_2 ;
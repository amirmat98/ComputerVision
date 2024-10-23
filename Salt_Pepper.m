%========== Salt and Pepper noise ============%
 

% This function gets the image and the Density deviation as input and
% returns the image with Salt & Pepper noise as output

function Y = Salt_Pepper(X , Density)

[rr , cc] = size(X) ;
Max = max(X,[],'all') ; 
indices1 = full(sprand(rr , cc , Density)) ; 
mask1= indices1>0 & indices1<0.5 ; mask2 = indices1>=0.5 ; 
Y = X .* (~mask1) ;
Y = Y .* (~mask1) + Max * mask2 ; 

end
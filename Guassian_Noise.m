%========== Guassian Noise function ===========%

% This function gets the image and the standard deviation as input and
% returns the image with Gaussian noise as output

function Y = Guassian_Noise(X , STD)

Y = X + STD*randn(size(X)) ; 

end
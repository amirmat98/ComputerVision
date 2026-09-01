function [u, v] = opticalFlowLK(I1, I2, W)
% Estimate optical flow using Lucas-Kanade method
% I1 and I2 are consecutive frames
% W is the size of the window

    % Compute image gradients
    Ix = conv2(I1, [-1 1; -1 1], 'same');
    Iy = conv2(I1, [-1 -1; 1 1], 'same');
    It = I2 - I1;

    % Initialize flow fields
    u = zeros(size(I1));
    v = zeros(size(I1));

    % Loop through each pixel
    halfW = floor(W / 2);
    for i = 1 + halfW:size(I1, 1) - halfW
        for j = 1 + halfW:size(I1, 2) - halfW
            % Extract window
            IxWin = Ix(i - halfW:i + halfW, j - halfW:j + halfW);
            IyWin = Iy(i - halfW:i + halfW, j - halfW:j + halfW);
            ItWin = It(i - halfW:i + halfW, j - halfW:j + halfW);

            % Construct matrices for Lucas-Kanade
            A = [IxWin(:) IyWin(:)];
            b = -ItWin(:);

            % Solve using least squares
            nu = pinv(A' * A) * A' * b;
            u(i, j) = nu(1);
            v(i, j) = nu(2);
        end
    end
end

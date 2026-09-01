function [] = compareCDOF(videoFile, tau1, alpha, tau2, W)
% This function compares the output of the change detection algorithm based
% on a running average, and of the optical flow estimated with the
% Lucas-Kanade algorithm.
% You must visualize the original video, the background and binary map
% obtained with the change detection, the magnitude and direction of the
% optical flow.
% tau1 is the threshold for the change detection
% alpha is the parameter to weight the contribution of current image and
% previous background in the running average
% tau2 is the threshold for the image differencing in the running average
% W is the side of the square patch to compute the optical flow

% Create a VideoReader object
videoReader = VideoReader(videoFile);

% Initialize variables
firstFrame = true;
runningBackground = [];
previousFrame = [];

% Loop through each frame of the video
while hasFrame(videoReader)
    % Read the next frame
    frame = readFrame(videoReader);
    grayFrame = rgb2gray(frame); % Convert to grayscale

    if firstFrame
        % Initialize the running background and previous frame
        runningBackground = double(grayFrame);
        previousFrame = double(grayFrame);
        firstFrame = false;
        continue;
    end

    % Compute binary map for running background
    diffRunning = abs(double(grayFrame) - runningBackground);
    binaryMapRunning = diffRunning > tau2;

    % Update running average background
    runningBackground = alpha * double(grayFrame) + (1 - alpha) * runningBackground;

    % Compute optical flow using Lucas-Kanade method
    [u, v] = opticalFlowLK(previousFrame, double(grayFrame), W);
    rgbFlow = convertToMagDir(u, v);

    % Display results
    figure(1);
    subplot(2, 2, 1), imshow(frame, 'Border', 'tight');
    title(sprintf('Frame %d', round(videoReader.CurrentTime * videoReader.FrameRate)));

    subplot(2, 2, 2), imshow(rgbFlow, 'Border', 'tight');
    title('Optical Flow');

    subplot(2, 2, 3), imshow(binaryMapRunning, 'Border', 'tight');
    title('Binary Map (Running Average)');

    subplot(2, 2, 4), imshow(uint8(runningBackground), 'Border', 'tight');
    title('Running Average Background');

    pause(0.01); % Pause to display the frames

    % Update the previous frame
    previousFrame = double(grayFrame);
end

% Close all figures
close all;

fprintf('Finished processing video: %s\n', videoFile);
end
function [] = compareCDAlgo(videoFile, tau1, alpha, tau2)
% This function compares the output of the change detection algorithm when
% using two possible background models:
% 1. A static model, e.g. a single frame or the average of N frames.
% In this case, the background is computed once and for all
% 2. A running average to update the model. In this case the background is
% updated, if needed, at each time instant
% You must visualize the original video, the background and binary map
% obtained with 1., the background and binary map
% obtained with 2.
% tau1 is the threshold for the change detection
% alpha is the parameter to weight the contribution of current image and
% previous background in the running average
% tau2 is the threshold for the image differencing in the running average

% Create a VideoReader object
videoReader = VideoReader(videoFile);

% Initialize variables
firstFrame = true;
staticBackground = [];
runningBackground = [];

% Loop through each frame of the video
while hasFrame(videoReader)
    % Read the next frame
    frame = readFrame(videoReader);
    grayFrame = rgb2gray(frame); % Convert to grayscale

    if firstFrame
        % Set up the static background (average of first N frames or first frame)
        staticBackground = double(grayFrame);
        runningBackground = double(grayFrame);
        firstFrame = false;
        continue;
    end

    % Compute binary map for static background
    diffStatic = abs(double(grayFrame) - staticBackground);
    binaryMapStatic = diffStatic > tau1;

    % Update running average background
    runningBackground = alpha * double(grayFrame) + (1 - alpha) * runningBackground;

    % Compute binary map for running background
    diffRunning = abs(double(grayFrame) - runningBackground);
    binaryMapRunning = diffRunning > tau2;

    % Display results
    figure(1);
    subplot(2, 3, 1), imshow(frame, 'Border', 'tight');
    title(sprintf('Frame %d', round(videoReader.CurrentTime * videoReader.FrameRate)));

    subplot(2, 3, 2), imshow(uint8(staticBackground), 'Border', 'tight');
    title('Static Background');

    subplot(2, 3, 3), imshow(binaryMapStatic, 'Border', 'tight');
    title('Binary Map 1');

    subplot(2, 3, 5), imshow(uint8(runningBackground), 'Border', 'tight');
    title('Running Average Background');

    subplot(2, 3, 6), imshow(binaryMapRunning, 'Border', 'tight');
    title('Binary Map 2');

    pause(0.01); % Pause to display the frames
end

% Close all figures
%close all;

fprintf('Finished processing video: %s\n', videoFile);
end

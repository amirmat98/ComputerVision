function [] = segmentAndTrack(videoFile, tau1, alpha, tau2)
% This function implements a simple tracker for a fixed target manually selected
% tau1 is the threshold for the change detection
% alpha is the parameter to weight the contribution of current image and
% previous background in the running average
% tau2 is the threshold for the image differencing in the running average

% Create a VideoReader object
videoReader = VideoReader(videoFile);

% Initialize variables
firstFrame = true;
runningBackground = [];
trajectory = [];

% Loop through each frame of the video
while hasFrame(videoReader)
    % Read the next frame
    frame = readFrame(videoReader);
    grayFrame = rgb2gray(frame); % Convert to grayscale

    if firstFrame
        % Initialize the running background with the first frame
        runningBackground = double(grayFrame);
        firstFrame = false;
        continue;
    end

    % Perform change detection
    diffRunning = abs(double(grayFrame) - runningBackground);
    binaryMapRunning = diffRunning > tau2;

    % Update running average background
    runningBackground = alpha * double(grayFrame) + (1 - alpha) * runningBackground;

    % Track target after manual selection
    if videoReader.CurrentTime * videoReader.FrameRate > 1380
        % Identify connected components in the binary map
        CC = bwconncomp(binaryMapRunning);
        stats = regionprops(CC, 'Centroid', 'BoundingBox');

        % If it's the first tracking frame, manually select target
        if isempty(trajectory)
            imshow(frame, 'Border', 'tight');
            title('Select the target to track');
            [x, y] = ginput(1); % Manual selection of the target
            target = [x, y];
            trajectory = target;
            hold on;
            plot(x, y, 'r*', 'MarkerSize', 10);
            hold off;
        else
            % Find the closest connected component to the target
            centroids = cat(1, stats.Centroid);
            distances = sqrt((centroids(:, 1) - target(1)).^2 + (centroids(:, 2) - target(2)).^2);
            [~, idx] = min(distances);

            % Update target position and append to trajectory
            target = centroids(idx, :);
            trajectory = [trajectory; target];
        end
    end

    % Display results
    imshow(frame, 'Border', 'tight');
    hold on;
    if ~isempty(trajectory)
        plot(trajectory(:, 1), trajectory(:, 2), 'r-', 'LineWidth', 2);
        plot(target(1), target(2), 'r*', 'MarkerSize', 10);
    end
    hold off;
    title(sprintf('Frame %d', round(videoReader.CurrentTime * videoReader.FrameRate)));
    pause(0.01);
end

% Visualize trajectory on the last frame
imshow(frame, 'Border', 'tight');
hold on;
if ~isempty(trajectory)
    plot(trajectory(:, 1), trajectory(:, 2), 'r-', 'LineWidth', 2);
    plot(trajectory(end, 1), trajectory(end, 2), 'r*', 'MarkerSize', 10);
end
hold off;
title('Final Trajectory');

% Close the figure when playback is finished
close all;

fprintf('Finished tracking on video: %s\n', videoFile);
end

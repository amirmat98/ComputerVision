clear; close all; clc

%% Define parameters
tau1 = 30; % Threshold for static background change detection
alpha = 0.1; % Weight for running average
tau2 = 40; % Threshold for running background change detection
W = 15; % W is the side of the square patch to compute the optical flow

%% Part 1.1 - Comparison between static and running average background
compareCDAlgo('videos/luce_vp.mp4', tau1, alpha, tau2);

%% Part 1.2 - Comparison between running average and optical flow 
compareCDOF('videos/tennis.mp4', tau1, alpha, tau2, W);

%% Part 2 - Tracker of fixed target
segmentAndTrack('videos/DibrisHall.mp4', tau1, alpha, tau2);
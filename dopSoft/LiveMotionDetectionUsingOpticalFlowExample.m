%% Live Motion Detection Using Optical Flow
%
% This example shows how to create a video algorithm to detect motion using 
% optical flow technique.This example uses the Image Acquisition Toolbox(TM) System Object 
% along with Computer Vision Toolbox(TM) System objects. 
%
% Copyright 2010-2018 The MathWorks, Inc.

%% Introduction
% This example streams images from an image acquisition device to detect motion 
% in the live video. It uses the optical flow estimation technique to
% estimate the motion vectors in each frame of the live video sequence.
% Once the motion vectors are determined, we draw it over the moving
% objects in the video sequence.

%% Initialization
% Create the Video Device System object.
vidDevice = imaq.VideoDevice('gige', 1, 'BayerGR8', ...
                             'ReturnedColorSpace', 'rgb');

%% 
% Create a System object to estimate direction and speed of object motion
% from one video frame to another using optical flow.
opticFlow = opticalFlowHS;

%% Stream Acquisition and Processing Loop
% Create a processing loop to perform motion detection in the input
% video. This loop uses the System objects you instantiated above.

% Set up for stream
nFrames = 0;
while (nFrames<300)     % Process for the first 100 frames.
    % Acquire single frame from imaging device.
    frameRGB = vidDevice();
    
    % Compute the optical flow for that particular frame.    
    flow = estimateFlow(opticFlow,rgb2gray(frameRGB));

    imshow(frameRGB)
    hold on
    plot(flow,'DecimationFactor',[5 5],'ScaleFactor',25)
    hold off

    % Increment frame count
    nFrames = nFrames + 1;
end

%% Summary
% In the figure window, you can see that the example detected the 
% motion of the black file. The moving objects are represented using the
% vector field lines as seen in the image. 

%% Release
% Here you call the release method on the System objects to close any open 
% files and devices.
release(vidDevice);

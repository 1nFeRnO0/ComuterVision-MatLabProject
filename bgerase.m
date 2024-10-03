cam = imaq.VideoDevice('gige', 1, 'BayerGB8', ...
                             'ReturnedColorSpace', 'rgb');

srcObj1 = get(cam, 'DeviceProperties');
set(srcObj1(1), 'AcquisitionFrameRateAbs', 60);
set(srcObj1(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj1(1), 'Gain', 2.5);
set(srcObj1(1), 'BGain', 80);
set(srcObj1(1), 'ColorTemperatureAutoSel', 'True');
set(srcObj1(1), 'Contrast', 110);
set(srcObj1(1), 'ExposureTime', 16667);
set(srcObj1(1), 'Gamma', 120);
set(srcObj1(1), 'PacketSize', 984);

global LOOP_RUNNUNG;
LOOP_RUNNUNG = true;

img_display = figure('CloseRequestFcn', {@my_closereq});
bg = im2double(imread("background_close.png"));

while (LOOP_RUNNUNG)
    frame = cam();
    dif = frame - bg;
    imshow(dif)
end

% frame = frame / 1000;
% imwrite(frame, "avgbackground.png");
release(cam);
clear cam;

function my_closereq(~, ~)
    global LOOP_RUNNUNG
    LOOP_RUNNUNG = false;
    delete(gcf);
    clear cam;
    return;
end
cam = imaq.VideoDevice('gige', 1, 'BayerGB8', ...
                             'ReturnedColorSpace', 'rgb');

srcObj1 = get(cam, 'DeviceProperties');
set(srcObj1(1), 'AcquisitionFrameRateAbs', 60);
set(srcObj1(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj1(1), 'Gain', 2.5);
set(srcObj1(1), 'BGain', 80);
set(srcObj1(1), 'ColorTemperatureAutoSel', 'True');
set(srcObj1(1), 'Contrast', 80);
set(srcObj1(1), 'ExposureTime', 16667);
% set(srcObj1(1), 'ExposureTime', 1000);
set(srcObj1(1), 'Gamma', 150);
set(srcObj1(1), 'PacketSize', 984);


% cam.DeviceProperties.AcquisitionFrameRateAbs = 60;
% cam.DeviceProperties.AcquisitionFrameRateEnable = "True";
% cam.DeviceProperties.BGain = 80;
% cam.DeviceProperties.ColorTemperatureAutoSel = "True";
% cam.DeviceProperties.Contrast = 110;
% % cam.DeviceProperties.DeviceTemperature = 39.9375;
% cam.DeviceProperties.ExposureTime = 16667;
% cam.DeviceProperties.Gamma = 120;
% cam.DeviceProperties.PacketSize = 9000;

% get(cam.DeviceProperties)



global LOOP_RUNNUNG;
LOOP_RUNNUNG = true;

img_display = figure('CloseRequestFcn', {@my_closereq});

% Создание объекта для детектирования объектов
if ~exist('detector', 'var')
    detector = vision.ForegroundDetector('NumGaussians', 4, ...
        'NumTrainingFrames', 5, 'MinimumBackgroundRatio', 0.7);
end

% Создание объекта для связывания объектов в последовательных кадрах
% if ~exist('blobAnalyzer', 'var')
blobAnalyzer = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, ...
    'MinimumBlobArea', 10000, 'MaximumBlobArea', 50000);
% end
bg = im2single(imread("background_close1.png"));

% Счетчик фреймов
count_of_frames = 0;

while (LOOP_RUNNUNG)
    frame = cam();
 
    grayframe = rgb2gray(frame);
    grayframe = grayframe - bg;
    
    % Детектирование переднего плана
    foregroundMask = detector(grayframe);

    % Очистка маски
%     filteredForeground = imopen(foregroundMask, strel('rectangle', [3, 3]));
%     filteredForeground = imclose(filteredForeground, strel('rectangle', [15, 15]));
%     filteredForeground = imfill(filteredForeground, 'holes');
    
    % Анализ объектов
    % bbox = step(blobAnalyzer, filteredForeground);
    filteredForeground = foregroundMask;
    bbox = blobAnalyzer(filteredForeground);
    
    % Наложение прямоугольников на оригинальный кадр
    % Фильтрация маленьких bbox    
%     if ~isempty(bbox)
%         for i = 1:length(bbox(:,1))
%             if bbox(i,3) > 60 && bbox(i,3) < 400 && bbox(i,4) > 60 && bbox(i,4) < 400
%                 frame = insertShape(frame, 'Rectangle', bbox(i,:), 'Color', 'red');
%             end
%         end
%     end

    resultFrame = insertShape(frame, 'Rectangle', bbox, 'Color', 'red');

    % Захват объекта и запись в отдельный файл
    if ~isempty(bbox) && bbox(1,1)<700 && bbox(1,1)>300
        obj = resultFrame(bbox(1,2):(bbox(1,2)+bbox(1,4)), bbox(1,1):(bbox(1,1)+bbox(1,3)),:);
%         obj = resultFrame;
        imwrite(obj, "cropped\cropped_image_"+count_of_frames+".png")
    end

    % Запись кадра в выходное видео
%     writeVideo(outputVideo, resultFrame);
    

    imshow(resultFrame)
    count_of_frames = count_of_frames + 1;
end
release(cam);
clear cam;

function my_closereq(~, ~)
    global LOOP_RUNNUNG
    LOOP_RUNNUNG = false;
    delete(gcf);
    clear('cam');
    return;
end
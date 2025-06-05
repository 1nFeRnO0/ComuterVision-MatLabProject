% out = imaqhwinfo;
% frameRGB = vidDevice();
% frameRGB;

% Загрузка видео
videoFile = 'recording1.avi'; % Замените на путь к вашему видео
videoReader = VideoReader(videoFile);

% Создание объекта для записи выходного видео
% outputVideo = VideoWriter('output_video.mp4', 'MPEG-4');
% outputVideo.FrameRate = videoReader.FrameRate;
% open(outputVideo);

% Создание объекта для детектирования объектов
detector = vision.ForegroundDetector('NumGaussians', 4, ...
    'NumTrainingFrames', 5, 'MinimumBackgroundRatio', 0.7);

% Создание объекта для связывания объектов в последовательных кадрах
blobAnalyzer = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, ...
    'MinimumBlobArea', 150);

count_of_frames = 0; % Счетчик фреймов


% Проход по каждому кадру видео
tic

while hasFrame(videoReader)
    frame = readFrame(videoReader);

    grayframe = rgb2gray(frame);
    grayframe(grayframe>150) = 0;
    
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
    resultFrame = insertShape(frame, 'Rectangle', bbox, 'Color', 'red');

    % Захват объекта и запись в отдельный файл
    if ~isempty(bbox) && bbox(1,1)<100 && bbox(1,1)>50
%         obj = resultFrame(bbox(1,2):(bbox(1,2)+bbox(1,4)), bbox(1,1):(bbox(1,1)+bbox(1,3)),:);
        obj = resultFrame;
%         imwrite(obj, "cropped\cropped_image_"+count_of_frames+".png")
    end

    % Запись кадра в выходное видео
%     writeVideo(outputVideo, resultFrame);
    
    count_of_frames = count_of_frames + 1; 
end

toc

% Закрытие объекта записи видео
% close(outputVideo);

disp('Обработка видео завершена.');
% clear;
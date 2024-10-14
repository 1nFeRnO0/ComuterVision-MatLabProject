% out = imaqhwinfo;
% frameRGB = vidDevice();
% frameRGB;

% Загрузка видео
videoFile = 'тест2.avi'; % Замените на путь к вашему видео
videoReader = VideoReader(videoFile);

% Создание объекта для записи выходного видео
outputVideo = VideoWriter('output_video.mp4', 'MPEG-4');
outputVideo.FrameRate =i videoReader.FrameRate;
open(outputVideo);

% Создание объекта для детектирования объектов
detector = vision.ForegroundDetector('NumGaussians', 4, ...
    'NumTrainingFrames', 5, 'MinimumBackgroundRatio', 0.7);

% Создание объекта для связывания объектов в последовательных кадрах
blobAnalyzer = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, ...
    'MinimumBlobArea', 150);

% Проход по каждому кадру видео
while hasFrame(videoReader)
    frame = readFrame(videoReader);
    
    % Детектирование переднего плана
    foregroundMask = detector(frame);

    % Очистка маски
    filteredForeground = imopen(foregroundMask, strel('rectangle', [3, 3]));
    filteredForeground = imclose(filteredForeground, strel('rectangle', [15, 15]));
    filteredForeground = imfill(filteredForeground, 'holes');

    summer = sum(sum(filteredForeground));
    
    % Анализ объектов
    bbox = step(blobAnalyzer, filteredForeground);
%     bbox = blobAnalyzer(foregroundMask);
    
    % Наложение прямоугольников на оригинальный кадр
    resultFrame = insertShape(frame, 'Rectangle', bbox, 'Color', 'red');
    
    % Запись кадра в выходное видео
    writeVideo(outputVideo, resultFrame);
end

% Закрытие объекта записи видео
close(outputVideo);

disp('Обработка видео завершена.');
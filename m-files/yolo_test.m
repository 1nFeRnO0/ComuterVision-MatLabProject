I = imread('bus.jpg');

% Load YOLO v8 model
det = yolov8ObjectDetector('yolov8s');

[bboxes, scores, labels] = detect(det, I);

annotations = string(labels) + ': ' + string(scores);
Iout = insertObjectAnnotation(I, 'rectangle', bboxes, annotations);
figure, imshow(Iout);
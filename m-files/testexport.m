function out = testexport
%TESTEXPORT Code for creating a video input object.
%   
%   This is the machine generated representation of a video input object.
%   This MATLAB code file, TESTEXPORT.M, was generated from the OBJ2MFILE function.
%   A MAT-file is created if the object's UserData property is not 
%   empty or if any of the callback properties are set to a cell array  
%   or to a function handle. The MAT-file will have the same name as the 
%   code file but with a .MAT extension. To recreate this video input object,
%   type the name of the code file, testexport, at the MATLAB command prompt.
%   
%   The code file, TESTEXPORT.M and its associated MAT-file, TESTEXPORT.MAT (if
%   it exists) must be on your MATLAB path.
%   
%   Example: 
%       vidobj = testexport;
%   
%   See also VIDEOINPUT, IMAQDEVICE/PROPINFO, IMAQHELP, PATH.
%   

% Check if we can check out a license for the Image Acquisition Toolbox.
canCheckoutLicense = license('checkout', 'Image_Acquisition_Toolbox');

% Check if the Image Acquisition Toolbox is installed.
isToolboxInstalled = exist('videoinput', 'file');

if ~(canCheckoutLicense && isToolboxInstalled)
    % Toolbox could not be checked out or toolbox is not installed.
    error(message('imaq:obj2mfile:invalidToolbox'));
end

% Load the MAT-file containing UserData and CallBack property values.
try
    MATvar = load('C:\Users\rusla\Desktop\matlabProject\testexport');
    MATLoaded = true;
catch
    warning(message('imaq:obj2mfile:MATload'));
   MATLoaded = false;
end


% Device Properties.
adaptorName = 'gige';
deviceID = 1;
vidFormat = 'BayerBG12';
tag = '';

% Search for existing video input objects.
existingObjs1 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs1)
    % If there are no existing video input objects, construct the object.
    vidObj1 = videoinput(adaptorName, deviceID, vidFormat);
else
    % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs1)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs1{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj1 = existingObjs1{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs1))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj1 = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if

% Configure properties whose values are saved in C:\Users\rusla\Desktop\matlabProject\testexport.mat.
if (MATLoaded)
    % MAT-file loaded successfully. Configure the properties whose values
    % are saved in the MAT-file.
    set(vidObj1, 'ErrorFcn', MATvar.errorfcn1);
else
   % MAT-file could not be loaded. Configure properties whose values were
   % saved in the MAT-file to their default value.
    set(vidObj1, 'ErrorFcn', @imaqcallback);
end

% Configure vidObj1 properties.
set(vidObj1, 'FramesPerTrigger', 1);

% Configure vidObj1's video source properties.
srcObj1 = get(vidObj1, 'Source');
set(srcObj1(1), 'AcquisitionFrameRate', 'Super');
set(srcObj1(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj1(1), 'Contrast', 80);
set(srcObj1(1), 'DeviceTemperature', 37.9375);
set(srcObj1(1), 'Gain', 10);
set(srcObj1(1), 'Gamma', 135);
set(srcObj1(1), 'PacketSize', 8984);



% Device Properties.
adaptorName = 'gige';
deviceID = 1;
vidFormat = 'BayerBG12Packed';
tag = '';

% Search for existing video input objects.
existingObjs2 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs2)
    % If there are no existing video input objects, construct the object.
    vidObj2 = videoinput(adaptorName, deviceID, vidFormat);
else
    % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs2)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs2{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj2 = existingObjs2{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs2))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj2 = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if

% Configure properties whose values are saved in C:\Users\rusla\Desktop\matlabProject\testexport.mat.
if (MATLoaded)
    % MAT-file loaded successfully. Configure the properties whose values
    % are saved in the MAT-file.
    set(vidObj2, 'ErrorFcn', MATvar.errorfcn2);
else
   % MAT-file could not be loaded. Configure properties whose values were
   % saved in the MAT-file to their default value.
    set(vidObj2, 'ErrorFcn', @imaqcallback);
end

% Configure vidObj2 properties.
set(vidObj2, 'FramesPerTrigger', 1);

% Configure vidObj2's video source properties.
srcObj2 = get(vidObj2, 'Source');
set(srcObj2(1), 'AcquisitionFrameRate', 'Super');
set(srcObj2(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj2(1), 'Contrast', 80);
set(srcObj2(1), 'DeviceTemperature', 37.9375);
set(srcObj2(1), 'Gain', 10);
set(srcObj2(1), 'Gamma', 135);
set(srcObj2(1), 'PacketSize', 8984);



% Device Properties.
adaptorName = 'gige';
deviceID = 1;
vidFormat = 'BayerBG8';
tag = '';

% Search for existing video input objects.
existingObjs3 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs3)
    % If there are no existing video input objects, construct the object.
    vidObj3 = videoinput(adaptorName, deviceID, vidFormat);
else
    % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs3)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs3{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj3 = existingObjs3{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs3))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj3 = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if

% Configure properties whose values are saved in C:\Users\rusla\Desktop\matlabProject\testexport.mat.
if (MATLoaded)
    % MAT-file loaded successfully. Configure the properties whose values
    % are saved in the MAT-file.
    set(vidObj3, 'ErrorFcn', MATvar.errorfcn3);
else
   % MAT-file could not be loaded. Configure properties whose values were
   % saved in the MAT-file to their default value.
    set(vidObj3, 'ErrorFcn', @imaqcallback);
end

% Configure vidObj3 properties.
set(vidObj3, 'FramesPerTrigger', 1);

% Configure vidObj3's video source properties.
srcObj3 = get(vidObj3, 'Source');
set(srcObj3(1), 'AcquisitionFrameRate', 'Super');
set(srcObj3(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj3(1), 'Contrast', 80);
set(srcObj3(1), 'DeviceTemperature', 37.9375);
set(srcObj3(1), 'Gain', 10);
set(srcObj3(1), 'Gamma', 135);
set(srcObj3(1), 'PacketSize', 8984);



% Device Properties.
adaptorName = 'gige';
deviceID = 1;
vidFormat = 'BayerGB12';
tag = '';

% Search for existing video input objects.
existingObjs4 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs4)
    % If there are no existing video input objects, construct the object.
    vidObj4 = videoinput(adaptorName, deviceID, vidFormat);
else
    % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs4)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs4{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj4 = existingObjs4{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs4))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj4 = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if

% Configure properties whose values are saved in C:\Users\rusla\Desktop\matlabProject\testexport.mat.
if (MATLoaded)
    % MAT-file loaded successfully. Configure the properties whose values
    % are saved in the MAT-file.
    set(vidObj4, 'ErrorFcn', MATvar.errorfcn4);
else
   % MAT-file could not be loaded. Configure properties whose values were
   % saved in the MAT-file to their default value.
    set(vidObj4, 'ErrorFcn', @imaqcallback);
end

% Configure vidObj4 properties.
set(vidObj4, 'FramesPerTrigger', 1);

% Configure vidObj4's video source properties.
srcObj4 = get(vidObj4, 'Source');
set(srcObj4(1), 'AcquisitionFrameRate', 'Super');
set(srcObj4(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj4(1), 'Contrast', 80);
set(srcObj4(1), 'DeviceTemperature', 37.9375);
set(srcObj4(1), 'Gain', 10);
set(srcObj4(1), 'Gamma', 135);
set(srcObj4(1), 'PacketSize', 8984);



% Device Properties.
adaptorName = 'gige';
deviceID = 1;
vidFormat = 'BayerGB8';
tag = '';

% Search for existing video input objects.
existingObjs5 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs5)
    % If there are no existing video input objects, construct the object.
    vidObj5 = videoinput(adaptorName, deviceID, vidFormat);
else
    % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs5)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs5{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj5 = existingObjs5{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs5))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj5 = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if

% Configure properties whose values are saved in C:\Users\rusla\Desktop\matlabProject\testexport.mat.
if (MATLoaded)
    % MAT-file loaded successfully. Configure the properties whose values
    % are saved in the MAT-file.
    set(vidObj5, 'ErrorFcn', MATvar.errorfcn5);
else
   % MAT-file could not be loaded. Configure properties whose values were
   % saved in the MAT-file to their default value.
    set(vidObj5, 'ErrorFcn', @imaqcallback);
end

% Configure vidObj5 properties.
set(vidObj5, 'FramesPerTrigger', 1);

% Configure vidObj5's video source properties.
srcObj5 = get(vidObj5, 'Source');
set(srcObj5(1), 'AcquisitionFrameRate', 'Super');
set(srcObj5(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj5(1), 'Contrast', 80);
set(srcObj5(1), 'DeviceTemperature', 37.9375);
set(srcObj5(1), 'Gain', 10);
set(srcObj5(1), 'Gamma', 135);
set(srcObj5(1), 'PacketSize', 8984);



% Device Properties.
adaptorName = 'gige';
deviceID = 1;
vidFormat = 'BayerGR12';
tag = '';

% Search for existing video input objects.
existingObjs6 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs6)
    % If there are no existing video input objects, construct the object.
    vidObj6 = videoinput(adaptorName, deviceID, vidFormat);
else
    % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs6)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs6{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj6 = existingObjs6{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs6))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj6 = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if

% Configure properties whose values are saved in C:\Users\rusla\Desktop\matlabProject\testexport.mat.
if (MATLoaded)
    % MAT-file loaded successfully. Configure the properties whose values
    % are saved in the MAT-file.
    set(vidObj6, 'ErrorFcn', MATvar.errorfcn6);
else
   % MAT-file could not be loaded. Configure properties whose values were
   % saved in the MAT-file to their default value.
    set(vidObj6, 'ErrorFcn', @imaqcallback);
end

% Configure vidObj6 properties.
set(vidObj6, 'FramesPerTrigger', 1);

% Configure vidObj6's video source properties.
srcObj6 = get(vidObj6, 'Source');
set(srcObj6(1), 'AcquisitionFrameRate', 'Super');
set(srcObj6(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj6(1), 'Contrast', 80);
set(srcObj6(1), 'DeviceTemperature', 37.9375);
set(srcObj6(1), 'Gain', 10);
set(srcObj6(1), 'Gamma', 135);
set(srcObj6(1), 'PacketSize', 8984);



% Device Properties.
adaptorName = 'gige';
deviceID = 1;
vidFormat = 'BayerGR8';
tag = '';

% Search for existing video input objects.
existingObjs7 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs7)
    % If there are no existing video input objects, construct the object.
    vidObj7 = videoinput(adaptorName, deviceID, vidFormat);
else
    % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs7)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs7{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj7 = existingObjs7{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs7))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj7 = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if

% Configure properties whose values are saved in C:\Users\rusla\Desktop\matlabProject\testexport.mat.
if (MATLoaded)
    % MAT-file loaded successfully. Configure the properties whose values
    % are saved in the MAT-file.
    set(vidObj7, 'ErrorFcn', MATvar.errorfcn7);
else
   % MAT-file could not be loaded. Configure properties whose values were
   % saved in the MAT-file to their default value.
    set(vidObj7, 'ErrorFcn', @imaqcallback);
end

% Configure vidObj7 properties.
set(vidObj7, 'FramesPerTrigger', 1);

% Configure vidObj7's video source properties.
srcObj7 = get(vidObj7, 'Source');
set(srcObj7(1), 'AcquisitionFrameRate', 'Super');
set(srcObj7(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj7(1), 'Contrast', 80);
set(srcObj7(1), 'DeviceTemperature', 37.9375);
set(srcObj7(1), 'Gain', 10);
set(srcObj7(1), 'Gamma', 135);
set(srcObj7(1), 'PacketSize', 8984);



% Device Properties.
adaptorName = 'gige';
deviceID = 1;
vidFormat = 'BayerRG12';
tag = '';

% Search for existing video input objects.
existingObjs8 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs8)
    % If there are no existing video input objects, construct the object.
    vidObj8 = videoinput(adaptorName, deviceID, vidFormat);
else
    % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs8)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs8{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj8 = existingObjs8{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs8))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj8 = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if

% Configure properties whose values are saved in C:\Users\rusla\Desktop\matlabProject\testexport.mat.
if (MATLoaded)
    % MAT-file loaded successfully. Configure the properties whose values
    % are saved in the MAT-file.
    set(vidObj8, 'ErrorFcn', MATvar.errorfcn8);
else
   % MAT-file could not be loaded. Configure properties whose values were
   % saved in the MAT-file to their default value.
    set(vidObj8, 'ErrorFcn', @imaqcallback);
end

% Configure vidObj8 properties.
set(vidObj8, 'FramesPerTrigger', 1);

% Configure vidObj8's video source properties.
srcObj8 = get(vidObj8, 'Source');
set(srcObj8(1), 'AcquisitionFrameRate', 'Super');
set(srcObj8(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj8(1), 'Contrast', 80);
set(srcObj8(1), 'DeviceTemperature', 37.9375);
set(srcObj8(1), 'Gain', 10);
set(srcObj8(1), 'Gamma', 135);
set(srcObj8(1), 'PacketSize', 8984);



% Device Properties.
adaptorName = 'gige';
deviceID = 1;
vidFormat = 'BayerRG8';
tag = '';

% Search for existing video input objects.
existingObjs9 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs9)
    % If there are no existing video input objects, construct the object.
    vidObj9 = videoinput(adaptorName, deviceID, vidFormat);
else
    % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs9)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs9{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj9 = existingObjs9{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs9))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj9 = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if

% Configure properties whose values are saved in C:\Users\rusla\Desktop\matlabProject\testexport.mat.
if (MATLoaded)
    % MAT-file loaded successfully. Configure the properties whose values
    % are saved in the MAT-file.
    set(vidObj9, 'ErrorFcn', MATvar.errorfcn9);
else
   % MAT-file could not be loaded. Configure properties whose values were
   % saved in the MAT-file to their default value.
    set(vidObj9, 'ErrorFcn', @imaqcallback);
end

% Configure vidObj9 properties.
set(vidObj9, 'FramesPerTrigger', 1);

% Configure vidObj9's video source properties.
srcObj9 = get(vidObj9, 'Source');
set(srcObj9(1), 'AcquisitionFrameRate', 'Super');
set(srcObj9(1), 'AcquisitionFrameRateEnable', 'True');
set(srcObj9(1), 'Contrast', 80);
set(srcObj9(1), 'DeviceTemperature', 37.9375);
set(srcObj9(1), 'Gain', 10);
set(srcObj9(1), 'Gamma', 135);
set(srcObj9(1), 'PacketSize', 8984);


out = [vidObj1 vidObj2 vidObj3 vidObj4 vidObj5 vidObj6 vidObj7 vidObj8 vidObj9 ];

vidDevice = imaq.VideoDevice('winvideo', 1, 'YUY2_640x480', ... % Acquire input video stream
'ROI', [1 1 640 480], ...
'ReturnedColorSpace', 'rgb');
redThresh = 0.12; % Threshold for red detection
greenThresh = 0.05; % Threshold for green detection
blueThresh = 0.2; % Threshold for blue detection

    preview(vidDevice);
    pause(5)
    rgbFrame = step(vidDevice); % Acquire single frame
    rgbFrame = flipdim(rgbFrame,2); % obtain the mirror image for displaying
    figure()
    [rgbFrame, rect] = imcrop(rgbFrame);
    closepreview(vidDevice);
    
    rgbFrame = step(vidDevice); % Acquire single frame
    rgbFrame = flipdim(rgbFrame,2); % obtain the mirror image for displaying    
    rgbFrame = imcrop(rgbFrame, rect);
    
    diffFrameRed = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame)); % Get red component of the image
    diffFrameRed = medfilt2(diffFrameRed, [3 3]); % Filter out the noise by using median filter
    binFrameRed = im2bw(diffFrameRed, redThresh); % Convert the image into binary image with the red objects as white
    
    diffFrameGreen = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get green component of the image
    diffFrameGreen = medfilt2(diffFrameGreen, [3 3]); % Filter out the noise by using median filter
    binFrameGreen = im2bw(diffFrameGreen, greenThresh); % Convert the image into binary image with the green objects as white
    
    diffFrameBlue = imsubtract(rgbFrame(:,:,3), rgb2gray(rgbFrame)); % Get blue component of the image
    diffFrameBlue = medfilt2(diffFrameBlue, [3 3]); % Filter out the noise by using median filter
    binFrameBlue = im2bw(diffFrameBlue, blueThresh); % Convert the image into binary image with the blue objects as white    

    r=rgbFrame(:,:,1) & binFrameRed;
    g=rgbFrame(:,:,2) & binFrameGreen;
    b=rgbFrame(:,:,3) & binFrameBlue;
    R=mean(mean(r));
    G=mean(mean(g));
    B=mean(mean(b));
%     figure(); imshow(rgbFrame), title('Image')
%     figure(); imshow(binFrameRed); title('Red objects');
%     figure(); imshow(binFrameGreen); title('Green objects');
%     figure(); imshow(binFrameBlue); title('Blue objects');
    if (R>G && R>B) color='red'
    elseif (G>R && G>B) color='green'
    elseif (B>R && B>G) color='blue'
    end
   

    rgbFrame = step(vidDevice); % Acquire single frame
    rgbFrame = flipdim(rgbFrame,2); % obtain the mirror image for displaying    
    rgbFrame = imcrop(rgbFrame, rect);
    
    diffFrameRed = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame)); % Get red component of the image
    diffFrameRed = medfilt2(diffFrameRed, [3 3]); % Filter out the noise by using median filter
    binFrameRed = im2bw(diffFrameRed, redThresh); % Convert the image into binary image with the red objects as white
    
    diffFrameGreen = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get green component of the image
    diffFrameGreen = medfilt2(diffFrameGreen, [3 3]); % Filter out the noise by using median filter
    binFrameGreen = im2bw(diffFrameGreen, greenThresh); % Convert the image into binary image with the green objects as white
    
    diffFrameBlue = imsubtract(rgbFrame(:,:,3), rgb2gray(rgbFrame)); % Get blue component of the image
    diffFrameBlue = medfilt2(diffFrameBlue, [3 3]); % Filter out the noise by using median filter
    binFrameBlue = im2bw(diffFrameBlue, blueThresh); % Convert the image into binary image with the blue objects as white    

    r=rgbFrame(:,:,1) & binFrameRed;
    g=rgbFrame(:,:,2) & binFrameGreen;
    b=rgbFrame(:,:,3) & binFrameBlue;
    R=mean(mean(r));
    G=mean(mean(g));
    B=mean(mean(b));
%     figure(); imshow(rgbFrame), title('Image');
%     figure(); imshow(binFrameRed); title('Red objects');
%     figure(); imshow(binFrameGreen); title('Green objects');
%     figure(); imshow(binFrameBlue); title('Blue objects');
    if (R>G && R>B) color='red'
    elseif (G>R && G>B) color='green'
    elseif (B>R && B>G) color='blue'
    end
   release(vidDevice);



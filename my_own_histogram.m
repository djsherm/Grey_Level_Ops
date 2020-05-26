function hist = my_own_histogram(img, bit, name)
%% DOCUMENTATION

% THIS FUNCTION ACCEPTS AN IMAGE AND RETURNS A HISTOGRAM WITHOUT USING MATLAB FUNCTIONS
% FUNCTION ALSO DISPLAYS THE IMAGE AFTER EQUALIZATION, AND PERFORMS IMAGE
% SUBTRACTION TO COMPARE RESULTS

% MADE BY: DANIEL SHERMAN
% MARCH 2, 2020

%% START OF CODE

%% FIND HISTOGRAM

grey_level = [1:2.^bit]; %store grey levels, corresponding from 0 to 255 for 8 bit
[len wid] = size(img); %take size of image
area = len*wid; %calculate area
I_max = double(max(img, [], 'all')); %get maximum grey level in the image

for k = grey_level %iterate through all possible grey levels
    %grab all indicies of pixels that correspond with the current grey level
    hist(k) = length(find(img == k - 1)); %count all the pixels that correspond, 
    %to find the histogram value
end

pdf = hist./area; %calculate pdf

for k = grey_level %iterate through all grey levels
    cdf(k) = sum(pdf(1:k)); %calculate the cdf
end

tx_pixels = round(I_max.*cdf); %find intensity at pixel values corresponding to the cdf

%% CREATE HISTOGRAM EQUALIZATION FUNCTION

for k = grey_level %iterate through all grey levels
    histo_eq(k) = I_max*sum(hist(1:k - 1))/area; %apply the histogram equalization integral, 
    %in discrete space
end

%%  PASS IMAGE THROUGH THE EQUALIZATION FUNCTION

reshaped_img = reshape(img, 1, area); %reshape to 1 by area vector for computational ease
img_eq = zeros(size(reshaped_img)); %initialize equalized image to zeros of the same size

for k = grey_level %iterate through all grey levels
    found_gl = find(reshaped_img == k - 1); %collect all indicies of image that 
    %correspond to current grey level
    img_eq(found_gl) = histo_eq(k); %set grey level in new image to be the 
    %value of the equalized histogram
end

img_eq = reshape(img_eq, len, wid); %reshape again to be the size of an image

%% PLOT NICELY

figure()
subplot(2,2,1)
imshow(img) %plot original image
colorbar
title(name)

subplot(2,2,2)
imshow(uint8(img_eq)) %plot equalized image
colorbar
title(strcat([name ' Passed Through f_e_q(I)']))

subplot(2,2,3)
plot(grey_level, hist) %plot the image's histogram
xlabel('Grey Level')
ylabel('Count')
title('Custom Histogram Routine')

subplot(2,2,4)
plot(grey_level, histo_eq) %plot the equalization function
xlabel('Original Grey Level')
ylabel('Transformed Grey Level')
title(strcat(['f_e_q(I) for ' name]))

%% COMPARISON TO IMADJUST()

img_adj = imadjust(img); %utilize imadjust()

img_delta_1 = image_subtract(img_adj, img_eq, name, '\gamma = 0.5'); %apply image 
%subtraction for comparison

figure()
subplot(3,1,1)
imshow(uint8(img_adj))
colorbar
ylabel(name)
title('1% High and Low Contrast Reduction')

subplot(3,1,2)
imshow(uint8(img_eq))
colorbar
title('Equalized Image')

subplot(3,1,3)
imshow(uint8(img_delta_1)) %plot differences
colorbar
title('1% Contrast - Equalized Image')


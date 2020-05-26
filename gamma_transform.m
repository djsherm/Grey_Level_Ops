function [gamma_img_1, gamma_img_2] = gamma_transform(image, name)
%% DOCUMENTATION

% FUNCTION TAKES AN IMAGE AND A FILE NAME.
% PERFORMS GREY LEVEL TRANSFORMATION f1(image) = I_max(image/I_max).^gamma
% FOR VARYING GAMMA VALUES AND RETURNS THE TRANSFORMED IMAGE

% MADE BY: DANIEL SHERMAN
% FEBRUARY 20, 2020

%% GAMMA TRANSFORM

gam = [0.5, 2];

I_max = double(max(image, [], 'all')); %get maximum grey level in the image

gamma_img_1 = I_max.*(double(image)./I_max).^gam(1);
gamma_img_2 = I_max.*(double(image)./I_max).^gam(2);

%% IMAGE ADJUST AND COMPARE

img_a = imadjust(image);

img_delta_1 = image_subtract(img_a, gamma_img_1, name, '\gamma = 0.5');
img_delta_2 = image_subtract(img_a, gamma_img_2, name, '\gamma = 2');

figure()
subplot(1,2,1)
imshow(uint8(gamma_img_1))
colorbar
xlabel('\gamma = 0.5')

subplot(1,2,2)
imshow(uint8(gamma_img_2))
xlabel('\gamma = 2')
sgtitle(strcat(['\gamma Transformed ' name]))
colorbar

figure()
subplot(3,1,1)
imshow(uint8(img_a))
title('1% Saturation - High and Low')
colorbar
ylabel(name)

subplot(3,1,2)
imshow(uint8(img_delta_1))
ylabel(name)
xlabel('\gamma = 0.5')
colorbar
title('1% Contrast - \gamma Transformed')

subplot(3,1,3)
imshow(uint8(img_delta_2))
ylabel(name)
colorbar
title('1% Contrast - \gamma Transformed')
xlabel('\gamma = 2')

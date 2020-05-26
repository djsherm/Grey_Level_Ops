function [alpha_img_1, alpha_img_2, alpha_img_3] = alpha_transform(image, name)
%% DOCUMENTATION

% FUNCTION TAKES AN IMAGE AND A FILE NAME.
% PERFORMS GREY LEVEL TRANSFORMATION f2(image) = I_max/(1 + (image/(I_max - 1/2)).*e^(-alph))
% FOR VARYING ALPHA VALUES AND RETURNS THE TRANSFORMED IMAGE

% MADE BY: DANIEL SHERMAN
% MARCH 2, 2020

%% ALPHA TRANSFORM

alph = [4, 8, 16];

I_max = double(max(image, [], 'all')); %get maximum grey level in the image

alpha_img_1 = I_max./(1 + exp(-alph(1)*(-0.5 + double(image)./I_max)));
alpha_img_2 = I_max./(1 + exp(-alph(2)*(-0.5 + double(image)./I_max)));
alpha_img_3 = I_max./(1 + exp(-alph(3)*(-0.5 + double(image)./I_max)));

%% IMAGE ADJUST AND COMPARE

img_adj = imadjust(image);

img_delta_1 = image_subtract(img_adj, alpha_img_1, 'mri.jpg', '\alpha = 4');
img_delta_2 = image_subtract(img_adj, alpha_img_2, 'mri.jpg', '\alpha = 8');
img_delta_3 = image_subtract(img_adj, alpha_img_3, 'mri.jpg', '\alpha = 16');

figure()
subplot(3,1,1)
imshow(uint8(alpha_img_1))
colorbar
xlabel('\alpha = 4')
ylabel(name)

subplot(3,1,2)
imshow(uint8(alpha_img_2))
colorbar
xlabel('\alpha = 8')
ylabel(name)

subplot(3,1,3)
imshow(uint8(alpha_img_3))
colorbar
xlabel('\alpha = 16')
ylabel(name)
sgtitle(strcat(['\alpha Transformed ' name]))

figure()
subplot(2,2,1)
imshow(uint8(img_adj))
colorbar
ylabel(name)
title('1% Saturated - High and Low')

subplot(2,2,2)
imshow(uint8(img_delta_1))
colorbar
ylabel(name)
title('1% Contrast - \alpha Transformed')
xlabel('\alpha = 4')

subplot(2,2,3)
imshow(uint8(img_delta_2))
colorbar
ylabel(name)
title('1% Contrast - \alpha Transformed')
xlabel('\alpha = 8')

subplot(2,2,4)
imshow(uint8(img_delta_3))
colorbar
ylabel(name)
title('1% Contrast - \alpha Transformed')
xlabel('\alpha = 16')

%% ENGG 4660: MEDICAL IMAGE PROCESSING
% LAB 3: GREY LEVEL OPERATIONS
% DANIEL SHERMAN
% 0954083
% FEBRUARY 28, 2020

%% CLEAN UP

close all
clear all
clc

%%  LOAD IN IMAGES

mri = imread('mri.jpg');
chest = imread('chest1.jpg');
badchest = imread('badchest.jpg');

%% IMPLEMENT GAMMA TRANSFORM

[mri_g05, mri_g2] = gamma_transform(mri, 'mri.jpg');
[chest_g05, chest_g2] = gamma_transform(chest, 'chest1.jpg');
[bchest_g05, bchest_g2] = gamma_transform(badchest, 'badchest.jpg');

%% IMPLEMENT ALPHA TRANSFORM

[mri_a4, mri_a8, mri_a16] = alpha_transform(mri, 'mri.jpg');
[chest_a4, chest_a8, chest_a16] = alpha_transform(chest, 'chest1.jpg');
[bchest_a4, bchest_a8, bchest_a16] = alpha_transform(badchest, 'badchest.jpg');

%% DISPLAY GREY LEVEL TRANSFORMS

%gamma transform
bits = [0:255];

figure()
plot(bits, 255*(bits./255).^0.5);
hold on
plot(bits, 255*(bits./255).^2);
title('f_1(I) - \gamma Transfomation')
xlabel('I (Grey Level)')
ylabel('f_1(I) (Transformed Grey Level)')
legend('\gamma = 0.5', '\gamma = 2')

%alpha transform
figure()
plot(bits, 255./(1 + exp(-4*((bits./255) - 0.5))))
hold on
plot(bits, 255./(1 + exp(-8*((bits./255) - 0.5))))
hold on
plot(bits, 255./(1 + exp(-16*((bits./255) - 0.5))))
title('f_2(I) - \alpha Transformation')
xlabel('I (Grey Level)')
ylabel('f_2(I) (Transformed Grey Level)')
legend('\alpha = 4', '\alpha = 8', '\alpha = 16')

%% MRI HISTOGRAM

mri_hist = imhist(mri);

figure()
imhist(mri)
title('Histogram of mri.jpg')
ylabel('Count')
ylim([0 8000])

background_area = sum(mri_hist(1:3))/(256*256);
eye_area = sum(mri_hist(4:30))/(256*256);
brain_area = sum(mri_hist(31:90))/(256*256);
fat_area = sum(mri_hist(91:256))/(256*256);

%% EQUALIZE HISTOGRAM

histo = 12.*((bits/255).^2 - (bits/255).^3);

f_eq = 255.*(4.*(bits./255).^3 - 3.*(bits./255).^4);

figure()
plot(bits, f_eq)
title('Histogram Equalization Function, f_e_q(I)')
xlabel('Original Grey Level')
ylabel('Transformed Grey Level')
xlim([0 260])
ylim([0 260])

%% APPLY EQUALIZATION TO THE TEST IMAGES

eq_mri = histo_eq(mri, 'mri.jpg');
eq_chest = histo_eq(chest, 'chest1.jpg');
eq_bchest = histo_eq(badchest, 'badchest.jpg');

%% MY OWN ROUTINE

my_mri_hist = my_own_histogram(mri, 8, 'mri.jpg');
my_own_histogram(chest, 8, 'chest1.jpg')
my_own_histogram(badchest,8, 'badchest.jpg')

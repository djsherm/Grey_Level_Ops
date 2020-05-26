function new_img = histo_eq(img, name)
%% DOCUMENTATION

% FUNCTION RECIEVES AN IMAGE AND APPLIES THE HISTOGRAM EQUALIZATION FUNCTION 
% DERIVED FROM LAB 3 QUESTION 3
% FUNCTION DISPLAYS THE IMAGE AFTER EQUALIZATION

% MADE BY: DANIEL SHERMAN
% MARCH 4, 2020

%% START OF CODE

new_img = 255.*(4.*(double(img)./255).^3 - 3.*(double(img)./255).^4);

figure()
imshow(uint8(new_img))
colorbar
title('After Applying f_e_q(I)')
xlabel(name)

uint8(new_img);


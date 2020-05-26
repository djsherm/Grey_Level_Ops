function delta = image_subtract(img1, img2, name, trial)

delta = abs(double(img1) - double(img2));

% figure()
% imshow(uint8(delta))
% colorbar
% title(name)
% ylabel('Adjusted Image - Custom Transform')
% xlabel(trial)
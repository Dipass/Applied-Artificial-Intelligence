clear, close all;

%% 1. Вбудовані зображення
img1 = imread('pout.tif'); 
img2 = imread('peppers.png'); 

figure('Name', 'Пункт 1');
subplot(1, 2, 1); imshow(img1); title('pout.tif');
subplot(1, 2, 2); imshow(img2); title('peppers.png');

%% 2.
img_custom = imread('foto.jpg'); 
figure('Name', 'Пункт 2');
imshow(img_custom); 
title('Завантажене: foto.jpg');

%% 3. Інформація
disp('--- Інформація про завантажене фото ---');
whos('img_custom')

%% 5-7. Гістограма та контраст 
if size(img_custom, 3) == 3
    img_gray = rgb2gray(img_custom);
else
    img_gray = img_custom;
end

img_adj = imadjust(img_gray);

figure('Name', 'Контрастування');
subplot(2,2,1); imshow(img_gray); title('Оригінал (сіре)');
subplot(2,2,2); imhist(img_gray); title('Гістограма до');
subplot(2,2,3); imshow(img_adj); title('Після imadjust');
subplot(2,2,4); imhist(img_adj); title('Гістограма після');

%% 8. Негатив
img_neg = imadjust(img_gray, [0 1], [1 0]);
figure('Name', 'Негатив');
imshow(img_neg); title('Негатив фото');
% Завдання 1: Завантаження зображень
imgRGB = imread('peppers.png'); 
imgGray = imread('cameraman.tif'); 

figure;
subplot(1,2,1); imshow(imgRGB); title('Завдання 1: Вихідне кольорове');
subplot(1,2,2); imshow(imgGray); title('Завдання 1: Вихідне чорно-біле');

% Завдання 2: Перетворення кольорового в чорно-біле
imgConverted = rgb2gray(imgRGB);
figure; 
imshow(imgConverted); 
title('Завдання 2: Перетворене в чорно-біле');

% Завдання 3: Дискретне косинусне перетворення (ДКП)
I = im2double(imgConverted); 
J = dct2(I);
figure; 
imshow(log(abs(J)), []); 
colormap(gca, jet(64)); colorbar;
title('Завдання 3: ДКП-спектр (логарифмічний масштаб)');

% Завдання 4: Відновлення за ДКП-спектром
I_reconstructed = idct2(J);
figure; 
imshow(I_reconstructed); 
title('Завдання 4: Відновлене зображення (без втрат)');

% Завдання 5: Квантування результатів ДКП
N = 0.05; 
J_quantized = N * round(J / N);

% Завдання 6: Відображення квантованого спектра
figure; 
imshow(log(abs(J_quantized)), []); 
colormap(gca, jet(64)); colorbar;
title(['Завдання 6: Квантований ДКП-спектр (N = ', num2str(N), ')']);

% Завдання 7: Відновлення зображення за квантованим спектром
Iq_reconstructed = idct2(J_quantized);
figure; 
imshow(Iq_reconstructed); 
title(['Завдання 7: Відновлене з квантованого спектру (N = ', num2str(N), ')']);

% Завдання 9: Квантування вихідного зображення (просторовий домен)
n_space = 0.2; 
I_quantized_space = n_space * round(I / n_space);
figure; 
imshow(I_quantized_space); 
title('Завдання 9: Квантоване вихідне зображення');
%% 1. Завантаження з бібліотеки MATLAB кількох різних зображень
img1 = imread('cameraman.tif');
img2 = imread('liftingbody.png'); % Друге зображення для демонстрації

f = double(img1);
[M, N] = size(f);

%% 2. Формування й відображення двовимірного спектра
F = fft2(f);

% Використовуємо логарифмічний масштаб для візуалізації
S_log = log(1 + abs(F));

figure('Name', 'Пункти 2-4: Спектри та відновлення', 'Position', [100, 100, 900, 600]);
subplot(2,2,1);
imshow(S_log, []);
title('2. Спектр (нульова частота в куті)');

%% 3. Зсув нульової частоти в центр
F_shifted = fftshift(F);
S_shifted_log = log(1 + abs(F_shifted));

subplot(2,2,2);
imshow(S_shifted_log, []);
title('3. Спектр (нульова частота в центрі)');

%% 4. Відновлення зображення за його спектром
f_rec_unshifted = real(ifft2(F));
f_rec_shifted = real(ifft2(F_shifted));

subplot(2,2,3);
imshow(f_rec_unshifted, []);
title('4. Відновлене з початкового спектра');

subplot(2,2,4);
imshow(f_rec_shifted, []);
title('4. Відновлене зі зсунутого спектра');

%% 5. Гауссівський фільтр у просторовій області (sigma = 10)
sigma1 = 10;
% Задаємо розмір фільтра рівним розміру зображення [M N]
h1 = fspecial('gaussian', [M, N], sigma1);

figure('Name', 'Пункти 5-7: Фільтри та АЧХ', 'Position', [150, 150, 900, 600]);
subplot(2,2,1);
imshow(h1, []);
title(sprintf('5. Вікно фільтра (\\sigma = %d)', sigma1));

%% 6. АЧХ двовимірного фільтра
H1 = fft2(h1);
H1_shifted = fftshift(H1); 

subplot(2,2,2);
imshow(abs(H1_shifted), []);
title(sprintf('6. АЧХ фільтра (\\sigma = %d)', sigma1));

%% 7. Зміна параметра sigma (sigma = 30)
sigma2 = 30;
h2 = fspecial('gaussian', [M, N], sigma2);
H2 = fft2(h2);
H2_shifted = fftshift(H2);

subplot(2,2,3);
imshow(h2, []);
title(sprintf('7. Вікно фільтра (\\sigma = %d)', sigma2));

subplot(2,2,4);
imshow(abs(H2_shifted), []);
title(sprintf('7. АЧХ фільтра (\\sigma = %d)', sigma2));

%% 8. Фільтрація зображень у частотній області
% Множення спектра зображення на АЧХ фільтра (без зсуву для коректного ifft2)
G1 = F .* H1;
g1_freq = real(ifft2(G1));

G2 = F .* H2;
g2_freq = real(ifft2(G2));

figure('Name', 'Пункти 8-9: Результати фільтрації', 'Position', [200, 200, 1000, 400]);
subplot(1,3,1);
imshow(g1_freq, []);
title(sprintf('8. Частотна фільтр. (\\sigma = %d)', sigma1));

subplot(1,3,2);
imshow(g2_freq, []);
title(sprintf('8. Частотна фільтр. (\\sigma = %d)', sigma2));

%% 9. Фільтрація в просторовій області
% Використовуємо 'circular' (циклічну згортку), щоб результат просторової
% фільтрації ідеально збігався з частотною (яка базується на ДПФ)
g1_spatial = imfilter(f, h1, 'circular');

subplot(1,3,3);
imshow(g1_spatial, []);
title(sprintf('9. Просторова фільтр. (\\sigma = %d)', sigma1));
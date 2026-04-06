%% 1. Завантаження тестових зображень
I1 = im2double(imread('cameraman.tif'));
I2 = im2double(imread('coins.png'));

%% 2. Відображення вихідних зображень
figure('Name', 'Вихідні зображення');
subplot(1,2,1); imshow(I1); title('Cameraman');
subplot(1,2,2); imshow(I2); title('Coins');

%% 3-4. Зашумлення та відображення
% Гаусів шум (нормальний білий)
I1_gauss = imnoise(I1, 'gaussian', 0, 0.02); 
% Імпульсна перешкода (salt & pepper)
I1_sp = imnoise(I1, 'salt & pepper', 0.05);

figure('Name', 'Зашумлені зображення');
subplot(1,2,1); imshow(I1_gauss); title('Гаусів шум (0.02)');
subplot(1,2,2); imshow(I1_sp); title('Імпульсний шум (0.05)');

%% 5-6. Лінійна фільтрація 
% Низькі частоти (розмиття)
h_low = fspecial('average', [3 3]);
I_low = imfilter(I1, h_low);

% Високі частоти (підкреслення контурів/різкість)
h_high = [0 -1 0; -1 5 -1; 0 -1 0]; 
I_high = imfilter(I1, h_high);

figure('Name', 'Лінійна фільтрація вихідного зображення');
subplot(1,2,1); imshow(I_low); title('Низькочастотна (Average)');
subplot(1,2,2); imshow(I_high); title('Високочастотна (Unsharp)');

%% 7. Фільтрація зашумлених зображень лінійними фільтрами
I_gauss_avg = imfilter(I1_gauss, h_low);
I_sp_avg = imfilter(I1_sp, h_low);

figure('Name', 'Лінійна фільтрація шумів');
subplot(1,2,1); imshow(I_gauss_avg); title('Гаус + Осереднення');
subplot(1,2,2); imshow(I_sp_avg); title('Імпульсний + Осереднення');

%% 8. Адаптивна фільтрація Вінера
I_wiener_gauss = wiener2(I1_gauss, [5 5]);
I_wiener_sp = wiener2(I1_sp, [5 5]);

figure('Name', 'Фільтр Вінера');
subplot(1,2,1); imshow(I_wiener_gauss); title('Вінер (Гаус)');
subplot(1,2,2); imshow(I_wiener_sp); title('Вінер (Імпульсний)');

%% 9. Нелінійна медіанна фільтрація
I_med_gauss = medfilt2(I1_gauss, [3 3]);
I_med_sp = medfilt2(I1_sp, [3 3]);

figure('Name', 'Медіанна фільтрація');
subplot(1,2,1); imshow(I_med_gauss); title('Медіанний (Гаус)');
subplot(1,2,2); imshow(I_med_sp); title('Медіанний (Імпульсний)');
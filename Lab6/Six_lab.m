% Завдання 1: Завантаження кольорових і чорно-білих зображень
img_color = imread('peppers.png'); 
img_gray_orig = imread('cameraman.tif'); 

figure('Name', 'Завдання 1: Вихідні зображення');
subplot(1, 2, 1); imshow(img_color); title('Кольорове зображення');
subplot(1, 2, 2); imshow(img_gray_orig); title('Чорно-біле зображення');

% Завдання 2: Перетворення кольорового зображення в чорно-біле
img_gray = rgb2gray(img_color);
img_gray = im2double(img_gray); 
figure('Name', 'Завдання 2: Результат rgb2gray');
imshow(img_gray); title('Перетворене в ч/б');

% Завдання 3: Поблочне ДКП (блоки 8x8)
T = dctmtx(8); 
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(img_gray, [8 8], dct);

% Завдання 4: Відображення результату ДКП у логарифмічному масштабі
figure('Name', 'Завдання 4: Поблочне ДКП');
imshow(log(abs(B) + 1), []);
title('Спектр поблочного ДКП (логарифмічний масштаб)');

% Завдання 5: Відновлення зображення за ДКП-спектром (без квантування)
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B, [8 8], invdct);
figure('Name', 'Завдання 5: Відновлене зображення');
imshow(I2); title('Повністю відновлене зображення (без втрат)');

% Завдання 6: Квантування результатів ДКП (скалярне)
N = 10; 
B_quantized_scalar = N * round(B / N);

% Завдання 7: Зональне квантування коефіцієнтів ДКП за допомогою маски
mask = [1 1 1 1 0 0 0 0;
        1 1 1 0 0 0 0 0;
        1 1 0 0 0 0 0 0;
        1 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0];
        
B2 = blockproc(B, [8 8], @(block_struct) mask .* block_struct.data);

% Завдання 8: Відновлення зображення за квантованими спектрами
I2_quantized_scalar = blockproc(B_quantized_scalar, [8 8], invdct);
I2_quantized_mask = blockproc(B2, [8 8], invdct);

figure('Name', 'Завдання 8: Відновлення після квантування');
subplot(1, 2, 1); imshow(I2_quantized_scalar); title(['Відновлене (скалярне квант., N=' num2str(N) ')']);
subplot(1, 2, 2); imshow(I2_quantized_mask); title('Відновлене (зональне квант. за маскою)');
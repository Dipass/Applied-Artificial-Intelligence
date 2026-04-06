%% 1. Завантаження та підготовка зображення
I = checkerboard(8); % Створення тестового зображення (шахівниця)
I = im2double(I);
figure; imshow(I); title('Оригінальне зображення');

%% 2. Моделювання спотворення (Розмиття + Шум)
% Створюємо функцію розмиття (PSF) - лінійний рух
PSF = fspecial('motion', 21, 11);
% Застосовуємо розмиття
blurred = imfilter(I, PSF, 'conv', 'circular');

% Додаємо білий гаусів шум
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);

figure; imshow(blurred_noisy); title('Спотворене зображення (Розмиття + Шум)');

%% 3. Відновлення методом інверсної фільтрації 
luc1 = deconvwnr(blurred_noisy, PSF, 0);
figure; imshow(luc1); title('Інверсна фільтрація (без урахування шуму)');

%% 4. Відновлення за допомогою фільтра Вінера
% Розрахунок відношення сигнал/шум (NSR)
snr = noise_var / var(I(:));
luc2 = deconvwnr(blurred_noisy, PSF, snr);
figure; imshow(luc2); title('Фільтр Вінера (NSR)');

%% 5. Відновлення методом регуляризації 
% Використовуємо метод найменших квадратів з обмеженнями
luc3 = deconvreg(blurred_noisy, PSF);
figure; imshow(luc3); title('Регуляризація за Тихоновим');

%% 6. Відновлення методом Люсі-Річардсона 
% Ітераційний метод
luc4 = deconvlucy(blurred_noisy, PSF, 20); % 20 ітерацій
figure; imshow(luc4); title('Метод Люсі-Річардсона');

%% 7. Додаткове завдання: Експерименти з шумом
% 7.1 Створення зображення з сильним шумом (без розмиття для тесту)
I_noisy_only = imnoise(I, 'gaussian', 0, 0.01); 

% 7.2 Повторення пунктів 2-6 для нового стану шум)
PSF_strong = fspecial('motion', 40, 45);
blurred_strong = imfilter(I, PSF_strong, 'conv', 'circular');
blurred_noisy_strong = imnoise(blurred_strong, 'gaussian', 0, 0.005);

% Відновлення Вінером для порівняння 
snr_strong = 0.005 / var(I(:));
res_strong = deconvwnr(blurred_noisy_strong, PSF_strong, snr_strong);

figure;
subplot(1,2,1); imshow(blurred_noisy_strong); title('Сильне спотворення (п.7)');
subplot(1,2,2); imshow(res_strong); title('Відновлення при сильному шумі');
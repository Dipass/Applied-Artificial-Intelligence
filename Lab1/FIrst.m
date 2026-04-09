% 1. Завантаження та відображення зображень з бібліотеки MATLAB
% Ці файли є стандартними та вбудованими у MATLAB
img_peppers = imread('peppers.png');
img_cameraman = imread('cameraman.tif');

figure('Name', 'Бібліотечні зображення');
subplot(1, 2, 1); imshow(img_peppers); title('peppers.png');
subplot(1, 2, 2); imshow(img_cameraman); title('cameraman.tif');

% 2. Завантаження власного зображення
% Вказуємо назву файлу, що завантажений на MATLAB Drive
filename = 'foto.jpg';
my_img = imread(filename);

figure('Name', 'Оригінальне зображення');
imshow(my_img); title('Власне зображення');

% 3. Одержання інформації про завантажене зображення
img_info = imfinfo(filename);
disp('Інформація про файл:');
disp(img_info);

% 4. Збереження зображення в заданому каталозі
% Створюємо папку 'MyResults' у MATLAB Drive, якщо її не існує
folder_name = 'MyResults';
if ~exist(folder_name, 'dir')
    mkdir(folder_name);
end
save_path = fullfile(folder_name, 'saved_photo.png');
imwrite(my_img, save_path);
disp(['Зображення успішно збережено за шляхом: ', save_path]);

% 5. Побудова гістограми розподілу яскравостей
% Функція imhist працює з 2D-матрицями. Для кольорового (RGB) зображення 
% спочатку конвертуємо його у відтінки сірого.
img_gray = rgb2gray(my_img);
figure('Name', 'Гістограма');
imhist(img_gray);
title('Гістограма розподілу яскравостей (градації сірого)');

% 6 та 7. Контрастування та відображення результату
% Функція imadjust за замовчуванням розтягує гістограму, обрізаючи по 1%
% найсвітліших і найтемніших пікселів, що підвищує контраст.
img_adj = imadjust(img_gray);

figure('Name', 'Контрастування');
subplot(1, 2, 1); imshow(img_gray); title('Оригінал (сірий)');
subplot(1, 2, 2); imshow(img_adj); title('Підвищена контрастність');

% 8. Відображення негативу зображення
% Можна застосувати як до кольорового, так і до чорно-білого зображення
img_neg = imcomplement(my_img); 
figure('Name', 'Негатив');
imshow(img_neg); title('Негативний результат');

% Виведення короткої довідки безпосередньо в командному вікні
help imadjust

% Відкриття повної документації з прикладами в окремому вікні довідки
doc imadjust
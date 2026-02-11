
img = imread('s1.png');
figure, imshow(img);
title('Original Satellite Image');

%%%
gray = rgb2gray(img);

figure, imshow(gray);
title('Grayscale Image');

%%%
blur = imgaussfilt(gray, 2);

figure, imshow(blur);
title('Smoothed Image');

%%%
level = graythresh(blur);
bw = imbinarize(blur, level);
bw = ~bw;   % invert so water becomes white

figure, imshow(bw);
title('Binary Image (Water Mask)');

%%%
se = strel('disk', 5);
clean_bw = imopen(bw, se);

figure, imshow(clean_bw);
title('Cleaned Water Mask');

%%%
result = img;

result(:,:,1) = img(:,:,1) .* uint8(~clean_bw);
result(:,:,2) = img(:,:,2) .* uint8(~clean_bw);
result(:,:,3) = img(:,:,3) + uint8(clean_bw)*300;

figure, imshow(result);
title('Detected Water Bodies');

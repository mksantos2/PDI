arq1 = im2double(imread('./img/lena_cinza.bmp','bmp'));

A = fft2(arq1);

A = ifftshift(A);

#imshow(A);

filename = 'test.mat';
save(filename);




%B = ifft2(A);

#B = log(abs(B));
#A = ifftshift(B);
#imshow(A, []);



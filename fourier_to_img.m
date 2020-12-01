
# XXXXXXXXXXXXXXXXXXXXXXX  EXERCÍCIO 2  XXXXXXXXXXXXXXXXXXXXXXXX

# acessando a struct test.mat
s = load('test.mat');

# shifta a frequencia zero
B = ifftshift(s.A);

# aplica a transformação fourier inversa
imgfinal = ifft2(B);

#exibe a imagem
imshow(abs(imgfinal));


# XXXXXXXXXXXXXXXXXXXXXXX  EXERCÍCIO 2  XXXXXXXXXXXXXXXXXXXXXXXX








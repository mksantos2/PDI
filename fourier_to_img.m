
# XXXXXXXXXXXXXXXXXXXXXXX  EXERC�CIO 2  XXXXXXXXXXXXXXXXXXXXXXXX

# acessando a struct test.mat
s = load('test.mat');

# shifta a frequencia zero
B = ifftshift(s.A);

# aplica a transforma��o fourier inversa
imgfinal = ifft2(B);

#exibe a imagem
imshow(abs(imgfinal));


# XXXXXXXXXXXXXXXXXXXXXXX  EXERC�CIO 2  XXXXXXXXXXXXXXXXXXXXXXXX








function arquivo2 = transform_freq(arquivo1, s) 
  # s == 0 : Transforma para domínio Fourier
  # s == 1 : Recebe transformada e a monta em domínio espacial
  if s == 0
    
    arq1 = imread(arquivo1); #carrega o arquivo
    A = fft2(arq1);# aplica fourier transform
    
    A = ifftshift(A); # shifta os zeros para o centro
    
    filename = 'test.mat'; 
    save(filename); # salva .mat 
    
    trans = log(abs(A)); #melhora a visualização
    
    I = (trans - min(trans(:))) / (max(trans(:)) - min(trans(:))); #converte para [0,1]

    imgfin = im2uint8(I); #converte imagem double para uint8
    
    #salva imagem
    imwrite(imgfin, './results/fourier_transformada.png', 'png'); 
    
    arquivo2 = 'fourier_transformada.png';
    
  endif
  
  if s == 1
    
    x = load(arquivo1); #carrega o arquivo .mat

    B = ifftshift(x.A); # shifta os zeros para as extremidades

    imgfinal = ifft2(B); # aplica fourier inversa
    
    #converte para [0,1]
    I = (imgfinal - min(imgfinal(:))) / (max(imgfinal(:)) - min(imgfinal(:)));

    imgfin = im2uint8(abs(I)); # converte imagem double para uint8
    
    #salva imagem
    imwrite(imgfin, './results/img_espacial.png', 'png');
    
    arquivo2 = 'img_espacial.png';
   
    
  endif
endfunction

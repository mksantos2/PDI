
function arquivo2 = filtragem_freq(arquivo1, tipo, raio) 
  
  # tipo == 1 : Passa Baixas
  # tipo == 2 : Eliminar bordas verticais
  # tipo == 3 : Passa Altas
  # tipo == 4 : Rejeita Faixa
  # tipo == 5 : Passa Faixa
  
  I = imread(arquivo1);
  [row, col] = size(I);
  figure, imshow(I);
  title('Domínio Espacial');
  
  out = fft2(I);
  outf = fftshift(out);

  figure, imshow(log(abs(outf)),[]);
  title('Dominio Fourier');
  
  r = raio;
  
  if tipo == 1
    
    ###### Cria um padrão circular ###### 
    ref1 = [];
    #r = 20;
    for I = 0:2*r
        for J = 0:2*r
              #percorre a matriz e cria a forma circular de acordo com o raio
              ref1(I+1,J+1) = (double((I-r).^2+(J-r).^2<=r^2));
        end
    end

    ###### Posiciona o padrão circular ao centro da imagem ######
    
    mascara2 = zeros(size(outf,1), size(outf,2));
    mascara2(size(outf,1)/2-r:size(outf,1)/2+r, size(outf,2)/2-r:size(outf,2)/2+r) = ref1; 

    
    figure(), imshow(ref1);
    title('Padrão circular');
    figure(), imshow(mascara2);
    title('Mascara');
    
    ###### APLICA A MASCARA NA FREQUENCIA DA IMG ######
    
    filtrado = outf.*mascara2;
    
    ###### TRANSFORMA PRA ESPACIAL ######

    I2 = ifft2(ifftshift(filtrado));
    figure, imshow(abs(I2),[]);
    title('Transformada inversa de frequência.*mascara')
    
    #converte para [0,1]
    I = (I2 - min(I2(:))) / (max(I2(:)) - min(I2(:)));

    imgfin = im2uint8(abs(I)); # converte imagem double para uint8
    
    #salva imagem
    imwrite(imgfin, './results/img_passaBaixas.png', 'png');
    
    imwrite(ref1, './results/padrao_passaBaixas.png', 'png');
    imwrite(mascara2, './results/mask_passaBaixas.png', 'png');
    
    
    arquivo2 = 'img_passaBaixas.png';
    
  
  end

    if tipo == 2 

    ###### Cria um padrão circular ###### 
    ref1 = [];
    #r = 20;
    for I = 0:2*r
        for J = 0:2*r
              #percorre a matriz e cria a forma circular de acordo com o raio
              ref1(I+1,J+1) = (double((I-r).^2+(J-r).^2<=r^2));
        end
    end

    % Posiciona o padrão circular ao centro da imagem
    # seta matriz de 1's 
    mascara2 = ones(size(outf,1), size(outf,2));
    
    #seta todas as colunas da linha da mascara pra 0
    for i = 1: col
       mascara2(size(outf,1)/2-r:size(outf,1)/2+r, i) = 0;
    end
    mascara2(size(outf,1)/2-r:size(outf,1)/2+r, size(outf,2)/2-r:size(outf,2)/2+r) = ref1; 

    figure(), imshow(ref1);
    title('Padrão circular');
    figure(), imshow(mascara2);
    title('Mascara');

    filtrado = outf.*mascara2;

    I2 = ifft2(ifftshift(filtrado));
    figure, imshow(abs(I2),[]);
    title('Transformada inversa de frequência.*mascara')
    
    #converte para [0,1]
    I = (I2 - min(I2(:))) / (max(I2(:)) - min(I2(:)));

    imgfin = im2uint8(abs(I)); # converte imagem double para uint8
    
    #salva imagem
    imwrite(imgfin, './results/img_vertical.png', 'png');
    
    imwrite(ref1, './results/padrao_vertical.png', 'png');
    imwrite(mascara2, './results/mask_vertical.png', 'png');
    
    
    arquivo2 = 'img_vertical.png';
  end
  
    if tipo == 3
    
    ###### Cria um padrão circular ###### 
    ref1 = [];
    #r = 20;
    for I = 0:2*r
        for J = 0:2*r
              ref1(I+1,J+1) = (double((I-r).^2+(J-r).^2>=r^2));
        end
    end

    % Posiciona o padrão circular ao centro da imagem
    mascara2 = ones(size(outf,1), size(outf,2));
    mascara2(size(outf,1)/2-r:size(outf,1)/2+r, size(outf,2)/2-r:size(outf,2)/2+r) = ref1; 

    figure(), imshow(ref1);
    title('Padrão circular');
    figure(), imshow(mascara2);
    title('Mascara');

    filtrado = outf.*mascara2;

    I2 = ifft2(ifftshift(filtrado));
    figure, imshow(abs(I2),[]);
    title('Transformada inversa de frequência.*mascara')
    
    #converte para [0,1]
    I = (I2 - min(I2(:))) / (max(I2(:)) - min(I2(:)));

    imgfin = im2uint8(abs(I)); # converte imagem double para uint8
    
    #salva imagem
    imwrite(imgfin, './results/img_passaAltas.png', 'png');
    
    imwrite(ref1, './results/padrao_passaAltas.png', 'png');
    imwrite(mascara2, './results/mask_passaAltas.png', 'png');
    
    
    arquivo2 = 'img_passaAltas.png';
    
  
end

    if tipo == 4
    
    ###### Cria um padrão circular ###### 
    ref1 = [];
    #r = 20;
    for I = 0:2*r
        for J = 0:2*r
            #percorre a matriz e cria a forma circular de acordo com o raio
              if ((I-r).^2+(J-r).^2<=r*5)
                ref1(I+1,J+1) = (double((I-r).^2+(J-r).^2>=r^2));
              else
                ref1(I+1,J+1) = (double((I-r).^2+(J-r).^2<r^2));
              end
        end
    end

    % Posiciona o padrão circular ao centro da imagem
    mascara2 = zeros(size(outf,1), size(outf,2));
    mascara2(size(outf,1)/2-r:size(outf,1)/2+r, size(outf,2)/2-r:size(outf,2)/2+r) = ref1; 

    figure(), imshow(ref1);
    title('Padrão circular');
    figure(), imshow(mascara2);
    title('Mascara');

    filtrado = outf.*mascara2;

    I2 = ifft2(ifftshift(filtrado));
    figure, imshow(abs(I2),[]);
    title('Transformada inversa de frequência.*mascara')
    
    #converte para [0,1]
    I = (I2 - min(I2(:))) / (max(I2(:)) - min(I2(:)));

    imgfin = im2uint8(abs(I)); # converte imagem double para uint8
    
    #salva imagem
    imwrite(imgfin, './results/img_rejeitaFaixa.png', 'png');
    
    imwrite(ref1, './results/padrao_rejeitaFaixa.png', 'png');
    imwrite(mascara2, './results/mask_rejeitaFaixa.png', 'png');
    
    
    arquivo2 = 'img_rejeitaFaixa.png';
    
  
    end

    if tipo == 5
    
    ###### Cria um padrão circular ###### 
    ref1 = [];
    #r = 20;
    for I = 0:2*r
        for J = 0:2*r
            #percorre a matriz e cria a forma circular de acordo com o raio
              if ((I-r).^2+(J-r).^2<=r*5)
                ref1(I+1,J+1) = (double((I-r).^2+(J-r).^2<=r^2));
              else
                ref1(I+1,J+1) = (double((I-r).^2+(J-r).^2>r^2));
              end
        end
    end

    % Posiciona o padrão circular ao centro da imagem
    mascara2 = ones(size(outf,1), size(outf,2));
    mascara2(size(outf,1)/2-r:size(outf,1)/2+r, size(outf,2)/2-r:size(outf,2)/2+r) = ref1; 

    figure(), imshow(ref1);
    title('Padrão circular');
    figure(), imshow(mascara2);
    title('Mascara');

    filtrado = outf.*mascara2;

    I2 = ifft2(ifftshift(filtrado));
    figure, imshow(abs(I2),[]);
    title('Transformada inversa de frequência.*mascara')
    
    #converte para [0,1]
    I = (I2 - min(I2(:))) / (max(I2(:)) - min(I2(:)));

    imgfin = im2uint8(abs(I)); # converte imagem double para uint8
    
    #salva imagem
    imwrite(imgfin, './results/img_passaFaixa.png', 'png');
    
    imwrite(ref1, './results/padrao_passaFaixa.png', 'png');
    imwrite(mascara2, './results/mask_passaFaixa.png', 'png');
    
    
    arquivo2 = 'img_passaFaixa.png';
    
  
    end

  
  
endfunction
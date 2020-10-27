function arquivo2 = atividade3_PDI(arquivo1, tipo, num1, num2)
  
  # 1 - INTERPOLACAO POR VIZINHO MAIS PROX
  # 2 - INTERPOLAÇÃO BILINEAR
  
  
  lena = imread(arquivo1);
  
  if tipo == 1

    #PARTE DE INTERPOLACAO - NEAREST NEIGHBOR

    [i,j] = size(lena);

    x_new = ceil(i*num1);
     
    y_new = ceil(j*num2);
     
     
    x_scale = x_new./(i-1);
     
    y_scale = y_new./(j-1);
     
    newLena = zeros(x_new,y_new);
     
    %Generate the output image
     
     
    for row = 0:x_new-1
     
     for col = 0:y_new-1
     
      newLena(row+1,col+1) = lena(1+round(row./x_scale),1+round(col./y_scale));
     
     end
     
    end


    final = uint8(newLena);
    
    imshow(final);

    imwrite(final,'arquivo2_vizinho.bmp','bmp');
    
    arquivo2 = 'arquivo2_vizinho.bmp';
  endif
  if tipo == 2

    #PARTE DE INTERPOLACAO - BILINEAR

    [x, y] = size(lena);
    
    
    x_new = ceil(x*num1);
     
    y_new = ceil(y*num2);

    re_img = zeros(x_new, y_new);
    
    
    #PADDING

    pad = 1;

    pad_img = zeros(x+2*pad, y+2*pad);
    pad_img(1+pad:x+pad, 1+pad:y+pad) = lena;


    pad_img(1:pad, 1:pad) = pad_img(2*pad:-1:1+pad, 2*pad:-1:1+pad);
    pad_img(1:pad, 1+y+pad:y+2*pad) = pad_img(2*pad:-1:1+pad, y+pad:-1:y+1);
    pad_img(1+x+pad:x+2*pad, 1:pad) = pad_img(x+pad:-1:x+1, 2*pad:-1:1+pad);
    pad_img(1+x+pad:x+2*pad, 1+y+pad:y+2*pad) = pad_img(x+pad:-1:x+1, y+pad:-1:y+1);

    pad_img(1:pad, 1+pad:y+pad) = pad_img(2*pad:-1:1+pad,1+pad:y+pad);
    pad_img(1+x+pad:x+2*pad, 1+pad:y+pad) = pad_img(x+pad:-1:x+1,1+pad:y+pad);
    pad_img(1+pad:x+pad, 1:pad) = pad_img(1+pad:x+pad,2*pad:-1:1+pad);
    pad_img(1+pad:x+pad, 1+y+pad:y+2*pad) = pad_img(1+pad:x+pad,y+pad:-1:y+1);

    img = uint8(pad_img);
    #PADDING
    
    
    

    h_p = x/x_new;
    w_p = y/y_new;

    for i = 1:x_new
       for j = 1:y_new
           % Valor real ponto ( u, v )
           u = i*h_p +1;
           v = j*w_p +1;
           
           % ttranforma para valor inteiro
           m = floor(u);
           n = floor(v);
           
           % interpolacao dos pontos
           s = v - n;
           t = u - m;
           
           % calculo da interpolacao bilinear
           re_img(i, j) = (1-s) * (1-t) * img(m, n)...
               + s * (1-t) * img(m, n+1)...
               + (1-s) * t * img(m+1, n)...
               + s * t * img(m+1, n+1);
       end
    end

    final = uint8(re_img);
    imshow(final);
    #imshow(arquivo2);
    imwrite(final,'arquivo2_bilinear.bmp','bmp');
    
    arquivo2 = 'arquivo2_bilinear.bmp';
    
  endif


endfunction
function arquivo2 = suaviza(arquivo1)
img=im2double(imread(arquivo1));

#definindo o numero da mascara
mask=3;

#criando o padding 

pad_size = 2*floor(mask/2);
pad=zeros(size(img)+pad_size);

#size da img
[x,y] = size(img);

#add elementos no padding
for a=1:x
    for b=1:y
        pad(a+floor(mask/2),b+floor(mask/2))=img(a,b);
    end
end

#matriz q recebera a imagem filtrada
final_img=im2double(zeros(size(img)));

#suavizando a img
for a=1:x
    for b=1:y
        #criando janela que recebera os coeficientes
        window=zeros(mask*mask,1);
        #add em cada posição do vetor, qual o coeficiente vai receber * o pixel naquela pos
        window(1) =  1 * (pad(1 + (a-1), 1 + (b-1)));
        window(2) =  2 * (pad(1 + (a-1), 2 + (b-1)));
        window(3) =  1 * (pad(1 + (a-1), 3 + (b-1)));
        window(4) =  2 * (pad(2 + (a-1), 1 + (b-1)));
        window(5) =  4 * (pad(2+ (a-1), 2 + (b-1)));
        window(6) =  2 * (pad(2 + (a-1), 3 + (b-1)));
        window(7) =  1 * (pad(3 + (a-1), 1 + (b-1)));
        window(8) =  2 * (pad(3 + (a-1), 2 + (b-1)));
        window(9) =  1 * (pad(3 + (a-1), 3 + (b-1)));
        
        #calculando a soma da janela do pixel 
        soma=sum(window);
        #dividindo tudo por 16
        final_img(a,b)=(soma/16);
    end
end
#criando imagem filtrada
imwrite(final_img,'suaviza.jpg','jpg');
arquivo2 = 'suaviza.jpg';
endfunction

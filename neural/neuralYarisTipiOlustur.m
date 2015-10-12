function [lutIndice] = neuralYarisTipiOlustur(kosu)

if(kosu(:,8) == 1)
    lutIndice = kosu(1,7)*2;
else
    lutIndice = kosu(1,7)*2-1;
end

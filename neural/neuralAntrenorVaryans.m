function [varyans] = neuralAntrenorVaryans(kosu,kosuInd)

N = size(kosu,1);


for i = 1:N
    antrenor = kosu(i,34);
    %toplam antrenörlüðü
    indice = find(kosuInd(:,34) == antrenor);
    toplamSayi = size(indice,1);
    %1.geldikleri
    indice = find(kosuInd(indice,17) == 1);
    birinciSayi = size(indice,1);
    if toplamSayi == 0
        kazanmaOrani(i,1) = 0;
    else
        kazanmaOrani(i,1) = birinciSayi/toplamSayi;
    end
end


varyans = var(kazanmaOrani);

    
    
    
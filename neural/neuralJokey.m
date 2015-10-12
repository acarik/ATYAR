function [jokeyVeri] = neuralJokey(kosu,kosuInd)

n = size(kosu,1);
kazanmaOrani = zeros(n,1);
kazanmaOrani2 = zeros(n,1);

%jokey genel kazanma oranlari
for i = 1:n
    jokey = kosu(i,32);
    %toplam kosu sayisi
    indice = find(kosuInd(:,32) == jokey);
    toplamSayi = size(indice,1);
    %1.geldikleri
    indice = find(kosuInd(indice,17) == 1);
    birinciSayi = size(indice,1);
    kazanmaOrani(i,1) = birinciSayi/toplamSayi;
end

a = sort(kazanmaOrani,'Descend');

jokeyVeri(1) = a(1);
jokeyVeri(2) = a(end);
jokeyVeri(3) = mean(a);
jokeyVeri(4) = a(1) - a(2);


%yarista 2 veya 3 at olmasý durumunda
switch n
    case 2
        jokeyVeri(1,5) = 0;
    case 3
        jokeyVeri(1,5) = 0;
        jokeyVeri(1,6) = 0;
    otherwise
        jokeyVeri(1,5) = (a(2) - a(3));
        jokeyVeri(1,6) = (a(3) - a(4));
end





%yarýþ tipi için kazanma orani
%o yaris tipini kosuInd'den cek
indice= find((kosuInd(:,7) == kosu(i,7)) &(kosuInd(:,8) == kosu(i,8)) );

yarisTemp = kosuInd(indice,:);


%yaris tipi için jokey genel kazanma oranlari
for i = 1:n
    jokey = kosu(i,32);
    %toplam kosu sayisi
    indice = find(yarisTemp(:,32) == jokey);
    toplamSayi = size(indice,1);
    %1.geldikleri
    indice = find(yarisTemp(indice,17) == 1);
    birinciSayi = size(indice,1);
    if toplamSayi == 0;
        kazanmaOrani2(i,1) = 0;
    else        
        kazanmaOrani2(i,1) = birinciSayi/toplamSayi;
    end
end
a = sort(kazanmaOrani2,'Descend');

jokeyVeri(7) = a(1);
jokeyVeri(8) = a(1) - a(2);
jokeyVeri(9) = var(a);

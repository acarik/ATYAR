function [ayak] = neuralAyakBul(kosuInd,i)

if (i+260 < size(kosuInd,1))
    kosuNo = kosuInd(i:i+260,5);
else
    kosuNo = kosuInd(i:end,5);
end
mevcutKosuNo = kosuInd(i,5);

kosuNofark = diff(kosuNo);

programAtlama = find(kosuNofark < 0);
if isempty(programAtlama)
    sonKosuNo = kosuNo(end);
else
    sonKosuNo = kosuNo(programAtlama(1));
end

altiliBaslama = sonKosuNo - 6  + 1;


if mevcutKosuNo < altiliBaslama
    ayak = 0;
else
    ayak = mevcutKosuNo(1) - altiliBaslama + 1;
end





    



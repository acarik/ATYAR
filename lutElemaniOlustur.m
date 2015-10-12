function L = lutElemaniOlustur(alanAdi, lutFlag, altElemanlar, deger)
L.alanAdi = alanAdi;
L.lutFlag = lutFlag;
L.altElemanlar = altElemanlar;
% eger fonksiyona girilmisse indeks ve deger alanlarini da doldur
% if exist('indeks','var')
%     L.indeks = indeks;
% else
%     L.indeks = [];
% end
if exist('deger','var')
    L.deger = deger;
else
    L.deger = {};
end
% L = struct('alanAdi',alanAdi,'lutFlag',lutFlag,'altElemanlar',altElemanlar);
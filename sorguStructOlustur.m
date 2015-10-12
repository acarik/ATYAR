function s = sorguStructOlustur(tagTipi,sorguAdi,sorguUstAlani,sorgulananDeger,aralikFlag)

s = struct( ...
    'tagTipi',tagTipi, ... % gui'de tag adi neyle basliyor
    'sorguAdi',sorguAdi, ... % mesela: Sehir, Grup, KosuCinsi
    'sorguUstAlani',sorguUstAlani, ... % mesela: yaris, kosu, at
    'sorgulananDeger',sorgulananDeger, ... % mesela: Izmir, {'Ankara','Bursa'}
    'aralikFlag',aralikFlag); % eger degerler araligi varsa true, mesela tarih

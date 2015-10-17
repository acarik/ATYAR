addpath('sifirBayt');

TJK_DAN_YARIS_OKU = true;
YARISLAR_GUNCELLE = true;
LUT_BASTAN_INDEKSLE = true; % true=>bastan indeksler
NEURAL_DATA_GUNCELLE = false;

%% internetten veri cekme
if TJK_DAN_YARIS_OKU
    YarislarVerisiCek();
end

%% programi cek
if YARISLAR_GUNCELLE
    YarislarVerisiOku();
end

%% yarislar yapisini LUT'a gecir
if LUT_BASTAN_INDEKSLE
    YarislarIndeksle();
else
    % burasi yazilacak.
end

%% NEURAL_DATA_GUNCELLE
if NEURAL_DATA_GUNCELLE
    cd neural
    neuralNetworkData
    neuralNetworkDataKisitli
    cd ..
end

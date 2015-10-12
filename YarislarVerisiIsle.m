% mat dosyasini oku, varsa okuma
global yarislar bilgilerLUT
if isempty(yarislar)
    % demek ki yok
    load('yarislar.mat')
end

if exist('yarislarIslenmis.mat','file')
    % veri tabanini guncelle
else
    % veri tabanini bastan olustur
    for y = 1:length(yarislar)
        disp(['yaris no ' num2str(y) ' isleniyor'])
        bilgiler.yaris = yarislar(y).bilgiler;
        for k = 1:length(yarislar(y).kosular)
            bilgiler.kosu = yarislar(y).kosular{k}.bilgiler;
            for a = 1:length(yarislar(y).kosular{k}.atlar)
                bilgiler.at = yarislar(y).kosular{k}.atlar;
                LutaEkle(bilgiler);
            end
        end
    end
end
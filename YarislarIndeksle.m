global yarislar
global lut
global yarislarInd

if exist('yarislar','var')
    if isempty(yarislar)
        load('yarislar.mat')
    end
end

% atlarin altindaki 13. alanlari sil (Fark)
for y = 1:length(yarislar)
    for k = 1:length(yarislar(y).kosular)
        try
            % bazi bos yarislar icin try bloku yazildi.
            yarislar(y).kosular{k}.atlar(:,13) = [];
        end
    end
end

% once lut yapisini ilkle
lutIlkle();

% yarislarInd icine yazilacak toplam olay sayisini hesapla ve buna gore
% init yap.
n = 0;
for y = 1:length(yarislar)
    for k = 1:length(yarislar(y).kosular)
        try
            % bazi bos yarislar icin try bloku yazildi.
            n = n + size(yarislar(y).kosular{k}.atlar,1);
        end
    end
end

% m'yi hesapla
m = 0;
for i = 1:length(lut)
    if isempty(lut{i}.altElemanlar)
        m = m + 1;
    else
        m = m + length(lut{i}.altElemanlar);
    end
end
yarislarInd = zeros(n,m);

% alan isimleri yapisini doldur
alanIsim.yaris = {'Sehir','YarisGunNo','Tarih'};
alanIsim.kosu = {'KosuNo','KosuCinsi','Grup','Agirlik','Mesafe','Pist'};
alanIsim.at = yarislar(1).kosular{1}.alanIsimleri;

% alanIsim, atlarin altindaki 13. alanlari sil (Fark)
alanIsim.at(13) = [];

% tum olaylari tara (olay: her bir atin bir kosusu)
i = 0;
for y = 1:length(yarislar)
    tic;
    for k = 1:length(yarislar(y).kosular)
        if ~isempty(yarislar(y).kosular{k})
            if isfield(yarislar(y).kosular{k},'atlar')
                for a = 1:size(yarislar(y).kosular{k}.atlar,1)
                    %             try
                    i = i + 1;
                    bilgi.yaris = yarislar(y).bilgiler;
                    bilgi.kosu = yarislar(y).kosular{k}.bilgiler;
                    bilgi.at = yarislar(y).kosular{k}.atlar(a,:);
                    ind = olayIndCek(bilgi,alanIsim);
                    %                 yarislarInd(i,1:length(ind)) = ind;
                    yarislarInd(i,:) = ind;
                    disp(['yaris#', num2str(y), '/', num2str(length(yarislar)) ' kosu#', num2str(k), ' at#' num2str(a) ' indekslendi'])
                    %             catch
                    %                 i = i - 1;
                    %                 % neden bu bloka dustugunun aciklamasi eklenecek
                    %                 error(' ');
                    %             end
                end
            end
        end
    end
    disp(['yaris #' num2str(y) ', ' num2str(toc) ' saniyede indekslendi'])
end

disp('yarislarInd.mat kaydediliyor...')
save('yarislarInd.mat','yarislarInd','lut');
disp('yarislarInd.mat kaydedildi.')
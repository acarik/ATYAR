function [yarisNo, kosuNo, atNo] = YarisVerisiSorgula(sorgu)
global yarislar
if isempty(yarislar)
    % demek ki onceden yuklenmemis
    YarislarDosyasiniYukle
end

yarisNo = [];
kosuNo = [];
atNo = [];
tic
for y = 1:length(yarislar)
%     tic
    disp(['yaris no ' num2str(y) ' icindeki kosular ve atlar sorgulaniyor'])
    currYarisBilgiler = yarislar(y).bilgiler;
    for k = 1:length(yarislar(y).kosular)
        currKosuBilgiler = yarislar(y).kosular{k}.bilgiler;
        currAtAlanIsimleri = yarislar(y).kosular{k}.alanIsimleri;
        for a = 1:size(yarislar(y).kosular{k}.atlar,1)
            currAtBilgiler = yarislar(y).kosular{k}.atlar(a,:);
            if SorguyuSagliyorMu(sorgu, currYarisBilgiler, currKosuBilgiler, currAtAlanIsimleri, currAtBilgiler);
                yarisNo(end+1) = y;
                kosuNo(end+1) = k;
                atNo(end+1) = a;
            end 
        end
    end
%     toc
end
toc
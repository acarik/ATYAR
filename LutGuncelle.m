function LutGuncelle(bilgiler)
global yarislarIslenmis yarislarLut

for i = 1:size(bilgiler.at,1)
    % once yaris
    for y = 1:length(bilgiler.yaris)
        switch y
            case 1
                % sehir
                ind = IndeksBul(bilgiler.yaris{y},'Yaris',y);
                if ind == -1
                    % demek ki lut'a girisi yapilmamis, yapilacak
                    LutaEkle
                end
        end
    end
    % kosu
    % at
end

function ret = IndeksBul(deger,ustYapi,ind)
global yarislarLut
if ~isfield(yarislarLut,'yaris')
    yarislarLut.yaris = {};
end
ret = -1;
switch ustYapi
    case 'Yaris'
        for i = 1:size(yarislarLut.yaris,1)
            if strcmp(deger,yarislarLut.yaris{i,ind}.deger)
                ret = yarislarLut.yaris{i,ind}.indeks;
            end
        end
end

function LutaEkle(bilgiler)
global yarislarIslenmis yarislarLut

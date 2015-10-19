function sorguSonucDokum(indL)
global lut yarislarInd
dokumAlanlar = {
    'Tarih'
    'At �smi>Isim'
    'Ya�>Yas'
    'Ya�>Cinsiyet'
    'Orijin(Baba)>Isim'
    'Kilo'
    'Jokey Ad�'
    'Derece'
    'Ganyan'
    '_Fark'
    'HK'
    '_Ganyan S�ralamas�'
    '_Jokey �ehir Kazanma Oran�'
    '_Ko�u Program No'
    '_Start No'
    };
A = cell(length(dokumAlanlar),length(indL));
for j = 1:length(indL)
    for i = 1:length(dokumAlanlar)
        alanAdi = dokumAlanlar{i};
        if alanAdi(1) == '_'
            r = [];
        else
            [ind, ustInd, altInd] = getLutInd(alanAdi);
            currDeger = yarislarInd(indL(j),ind);
            if isempty(altInd)
                if lut{ustInd}.lutFlag
                    r = lut{ustInd}.deger{currDeger};
                else
                    r = currDeger;
                end
            else
                if lut{ustInd}.altElemanlar{altInd}.lutFlag
                    r = lut{ustInd}.altElemanlar{altInd}.deger{currDeger};
                else
                    r = currDeger;
                end
            end
            1;
            if strcmp(alanAdi,'Tarih')
                r = datestr(r);
            elseif strcmp(alanAdi,'Ya�>Cinsiyet')
                r = char(r);
            end
        end
        A{j,i} = r;
    end
end
A = [dokumAlanlar(:)'; A];
xlswrite('dokum.xls',A);
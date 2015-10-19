function sorguSonucDokum(indL)
global lut yarislarInd
dokumAlanlar = {
    'Tarih'
    'At Ýsmi>Isim'
    'Yaþ>Yas'
    'Yaþ>Cinsiyet'
    'Orijin(Baba)>Isim'
    'Kilo'
    'Jokey Adý'
    'Derece'
    'Ganyan'
    'Fark'
    'HK'
    '_Ganyan Sýralamasý'
    '_Jokey Þehir Kazanma Oraný'
    '_Koþu Program No'
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
            % sutunInd = yarislarIndSutunIndeksBul(ind,altInd);
            deger = {yarislarInd(indL(j),ind)};
            if isempty(find(alanAdi=='>'))
                sorguDegeri = struct('alanAdi',alanAdi,'deger',deger,'karsilastirmaTipi',[]);
            else
                sorguDegeri = struct('alanAdi',alanAdi(find(alanAdi=='>')+1:end),'deger',deger,'karsilastirmaTipi',[]);
            end
            if ~iscell(sorguDegeri.deger)
                tmp = sorguDegeri.deger;
                sorguDegeri.deger = cell(1,1);
                sorguDegeri.deger{1} = tmp;
            end
            r = gercekDegeriBul(sorguDegeri,ustInd,altInd);
            if strcmp(alanAdi,'Tarih')
                r = datestr(r);
            end
        end
        A{j,i} = r;
    end
end
A = [dokumAlanlar(:)', A];
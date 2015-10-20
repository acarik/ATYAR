function sorguSonucDokum(indL)
global lut yarislarInd
% once her kosunun ilk ikisini alacak sekilde indL'yi aalt
dokumAlanlar = {
    'Tarih'
    'At No'
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
    '_Jokey Ko�u T�r� Kazanma Oran�'
    '_Antren�r Kazanma Oran�'
    'KosuNo>KosuNo'
    '_Yar�� G�n� Toplam Ko�u'
    '_Start No'
    };
A = cell(length(indL),length(dokumAlanlar));
for j = 1:length(indL)
    for i = 1:length(dokumAlanlar)
        alanAdi = dokumAlanlar{i};
        if alanAdi(1) == '_'
            % !!! lut degisince buradaki indekslerin de degismesi
            % gerekecek.
            switch alanAdi
                case '_Fark'
                    r = [];
                case '_Ganyan S�ralamas�'
                    % bu kosuya ait indeksleri bul
                    % sehir
                    ind1 = (yarislarInd(indL(j),1) == yarislarInd(:,1));
                    % yarisGunNo
                    ind2 = (yarislarInd(indL(j),2) == yarislarInd(:,2));
                    % tarih
                    ind3 = (yarislarInd(indL(j),3) == yarislarInd(:,3));
                    % kosuNo
                    ind4 = (yarislarInd(indL(j),4) == yarislarInd(:,4));
                    % saat
                    ind5 = (yarislarInd(indL(j),5) == yarislarInd(:,5));
                    
                    ind = and(ind1,and(ind2,and(ind3,and(ind4,ind5))));
                    
                    buYarisIcinGanyan = yarislarInd(ind,36);
                    [B,I] = sort(buYarisIcinGanyan);
                    
                    atNo = yarislarInd(indL(j),16);
                    r = find(I==atNo);
                case '_Jokey �ehir Kazanma Oran�'
                    jokeyNo = (yarislarInd(indL(j),31) == yarislarInd(:,31));
                    sehir = (yarislarInd(indL(j),1) == yarislarInd(:,1));
                    i1 = sum(and(jokeyNo,sehir));
                    atNo1 = (yarislarInd(:,16) == 1);
                    i2 = sum(and(jokeyNo,and(sehir,atNo1)));
                    r = i2/i1;
                case '_Jokey Ko�u T�r� Kazanma Oran�'
                    jokeyNo = (yarislarInd(indL(j),31) == yarislarInd(:,31));
                    kosuCinsi = (yarislarInd(indL(j),6) == yarislarInd(:,6));
                    i1 = sum(and(jokeyNo,kosuCinsi));
                    atNo1 = (yarislarInd(:,16) == 1);
                    i2 = sum(and(jokeyNo,and(kosuCinsi,atNo1)));
                    r = i2/i1;
                case '_Yar�� G�n� Toplam Ko�u'
                    % sehir
                    ind1 = (yarislarInd(indL(j),1) == yarislarInd(:,1));
                    % yarisGunNo
                    ind2 = (yarislarInd(indL(j),2) == yarislarInd(:,2));
                    % tarih
                    ind3 = (yarislarInd(indL(j),3) == yarislarInd(:,3));
                    % atNo1
                    ind4 = (yarislarInd(:,16) == 1);
                    ind = and(ind1,and(ind2,and(ind3,and(ind4,ind4))));
                    r = sum(ind);
                case '_Start No'
                    r = [];
                case '_Antren�r Kazanma Oran�'
                    antNo = (yarislarInd(indL(j),33) == yarislarInd(:,33));
                    i1 = sum(antNo);
                    atNo1 = (yarislarInd(:,16) == 1);
                    i2 = sum(and(atNo1,antNo));
                    r = i2/i1;
                otherwise
                    error('hata')
            end
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
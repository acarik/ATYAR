function r = SorgulananDegerKontrol(s,alanIsim,bilgi) %#ok<INUSL>

sorguUstAlanStr = lower(s(1).sorguUstAlani);
% once bu alanin indeksini bul
ind = 0;
for j = 1:eval(['length(alanIsim.' sorguUstAlanStr ')'])
    if eval(['strcmp(alanIsim.' sorguUstAlanStr '{j},s(1).sorguAdi)'])
        ind = j;
        break
    end
end
if ind == 0
    error('sorguAdi = %s bulunamadi',s.sorguAdi);
end

% dosyadan okunan deger ile karsilastir
switch s(1).sorguUstAlani
    case 'Yaris'
        switch s(1).sorguAdi
            case 'Sehir'
                % karsilastir
                r = false;
                for i = 1:length(s)
                    r = r || strcmp(SehirDegeriHam(s(i).sorgulananDeger),bilgi.yaris{ind});
                end
            otherwise
                keyboard
        end
    case 'Kosu'
        switch s(1).sorguAdi
            case 'Mesafe'
                % sayi ifade etmeyen karakterleri temizle
                okunanDeger = nonnum_temizle_double_cevir(bilgi.kosu{ind});
                % ve karsilastir
                r = ...
                    (okunanDeger >= str2double(s(1).sorgulananDeger)) && ...
                    (okunanDeger <= str2double(s(2).sorgulananDeger));
            case 'Grup'
                if isempty(strcmp('Yukari',s.sorgulananDeger))
                    % demek ki tam deger araniyor
                    r = nonnum_temizle_double_cevir(bilgi.kosu{ind}) ...
                        == nonnum_temizle_double_cevir(s.sorgulananDeger);
                else
                    % demek ki 've yukari' deger araniyor
                    r = nonnum_temizle_double_cevir(bilgi.kosu{ind}) ...
                        >= nonnum_temizle_double_cevir(s.sorgulananDeger);
                end
        end
    case 'At'
        switch s(1).sorguAdi
            case char([65 116 32 304 115 109 105]) % at ismi
                % karsilastir
                r = false;
                for i = 1:length(s)
                    r = r || strcmp(s(i).sorgulananDeger,bilgi.at{ind});
                end
            otherwise
                keyboard
        end
    otherwise
        error('Yanlis sorguUstAlani (%s)',s.sorguUstAlani)
end


function hamDeger = SehirDegeriHam(sehirDegeri)
switch sehirDegeri
    case 'Adana'
        hamDeger = '\u001aAdana';
    case 'Istanbul'
        hamDeger = char([26   304   115   116    97   110    98   117   108]);
    case 'Izmir'
        hamDeger = char([26   304   122   109   105   114]);
    case 'Bursa'
        hamDeger = char([26    65   100    97   110    97]);
    otherwise
        keyboard
end

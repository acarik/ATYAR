function hamDeger = SorguDegeriniHamDegereDonustur(s)
if length(s) == 2
    if s(1).aralikFlag == true
        hamDeger1 = SorguDegeriniHamDegereDonustur(s(1));
        hamDeger2 = SorguDegeriniHamDegereDonustur(s(2));
        hamDeger.deger = {min([hamDeger1,hamDeger2]), max([hamDeger1,hamDeger2])};
        hamDeger.karsilastirmaTipi = 'aralik';
        return
    else
        keyboard
    end
end
sorguUstAlani = s(1).sorguUstAlani;
sorguAdi = s(1).sorguAdi;
sorgulananDeger = s(1).sorgulananDeger;
% sorguUstAlani,sorguAdi,sorguDegeri)
% sorgu

switch sorguUstAlani
    case 'Yaris'
        switch sorguAdi
            case 'Sehir'
                switch sorgulananDeger
                    case 'Adana'
                        hamDeger = '\u001aAdana';
                    case 'Istanbul'
                        hamDeger = char([26   304   115   116    97   110    98   117   108]);
                    case 'Izmir'
                        hamDeger = char([26   304   122   109   105   114]);
                    otherwise
                        keyboard
                end
                
            otherwise
                keyboard
        end
        
    case 'Kosu'
        hamDeger = str2double(sorgulananDeger);
        
    otherwise
        keyboard
end
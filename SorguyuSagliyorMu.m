function r = SorguyuSagliyorMu(sorgu, yarisBilgi, kosuBilgi, atAlanIsim, atBilgi)
alanIsim.yaris = {'Sehir','YarisGunNo','Tarih'};
alanIsim.kosu = {'KosuNo','KosuCinsi','Grup','Agirlik','Mesafe','Pist'};
alanIsim.at = atAlanIsim;
bilgi.yaris = yarisBilgi;
bilgi.kosu = kosuBilgi;
bilgi.at = atBilgi;

% simdi her bir deger icin sorgu yap
r = true;
for i = 1:length(sorgu)
    s = sorgu{i};
    % simdi sorgulanan degeri kontrol et
    if SorgulananDegerKontrol(s,alanIsim,bilgi)
        % sagliyor
    else
        % saglamiyor
%         r = and(r,false); % aslinda return de olur
r = false;
return
    end
end


if ~r
    % en az bir kontrolde false aldiysak cik
    return
end






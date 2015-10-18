%% internetten veri cekme

% 1: Adana
% 2: Ýzmir (%c4%b0zmir)
% 3: Ýstanbul (%c4%b0stanbul)
% 4: Bursa
% 5: Ankara

sehirStr = {...
    'Adana';
    '%c4%b0zmir';
    '%c4%b0stanbul';
    'Bursa';
    'Ankara';};
% Ornek csv dosyasi URL'si
% http://www.tjk.org/TR/YarisSever/Info/GetCSV/GunlukYarisSonuclari?SehirId=3&QueryParameter_Tarih=07/05/2006&Sehir=%c4%b0stanbul

% internet baglantisi var mi?
try
    fid = fopen('temp.txt','w');
    fprintf(fid,'%s',urlread('http://www.google.com'));
    fclose(fid);
    delete('temp.txt');
catch
    fclose(fid)
    error('internet baglantisi yok ki.')
end

t0 = datenum('January 1, 2008')-1;
tend = now-1;
gunNo = 0;
while true
    gunNo = gunNo + 1;
    t = t0 + gunNo;
    if (t > tend  )
        break;
    end
    
    [year, month, day] = datevec(t);
    tic
    for sehirId = 1:5
        url = sprintf('http://www.tjk.org/TR/YarisSever/Info/GetCSV/GunlukYarisSonuclari?SehirId=%d&QueryParameter_Tarih=%02g/%02g/%d&Sehir=%s',...
            sehirId,day,month,year,sehirStr{sehirId});
%         fname = [int2str(year), num2str(month,'%02g'), num2str(day,'%02g'), '-' int2str(sehirId) '.csv'];
        fname = sprintf('%d%02g%02g-%d.csv',year,month,day,sehirId);
        if exist(['sonuclar\' fname],'file')% || exist(['sonuclar\0bayt\' fname],'file')
            disp(['sonuclar\' fname, ' dosyasi zaten var, atlaniyor']);
            % oyleyse bunu okuma
        else
            if sifirBaytKontrol(fname)
                disp([fname ' dosyasi sifir bayt, devam et.']);
                % demek ki varmis, devam et.
            else
                fid = fopen(['sonuclar\' fname],'w');
                try
                    disp([num2str(year), num2str(month,'%02g'), num2str(day,'%02g') ' tarihi icin yaris verileri okunuyor... (' num2str(toc) ')']);
                    fprintf(fid,'%s',urlread(url));
                    fclose(fid);
                    disp([num2str(year), num2str(month,'%02g'), num2str(day,'%02g') ' tarihi icin yaris verileri cekildi. (' num2str(toc) ')']);
                catch
                    fclose(fid);
                    sifirBaytEkle(fname);
                    delete(['sonuclar\' fname]);
                end
            end
        end
    end
end

sifirBaytKaydet();
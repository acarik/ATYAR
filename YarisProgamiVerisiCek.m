function yarisProgramInd = YarisProgamiVerisiCek(sehirId,day,month,year)

% adim 1: internetten program dosyasini oku

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
url = sprintf('http://www.tjk.org/TR/YarisSever/Info/GetCSV/GunlukYarisProgrami?SehirId=%d&QueryParameter_Tarih=%02g/%02g/%d&Sehir=%s',...
    sehirId,day,month,year,sehirStr{sehirId});
fname = [num2str(year), num2str(month,'%02g'), num2str(day,'%02g'), '-' num2str(sehirId) '.csv'];

if ~exist(['programlar\' fname],'file') % eger dosya onceden okunup kaydedilmemisse...
    fid = fopen(['programlar\' fname],'w');
    tic
    try
        fprintf(fid,'%s',urlread(url));
        fclose(fid);
        disp([num2str(year), num2str(month,'%02g'), num2str(day,'%02g') ' tarihi icin yaris programi verileri cekildi. (' num2str(toc) ' saniye)']);
    catch
        fclose(fid);
        delete(['programlar\' fname]);
        error([num2str(year), num2str(month,'%02g'), num2str(day,'%02g') ' tarihi icin yaris programi web''den alinamadi.']);
    end
end

% adim 2: internetten ceklip kaydedilen dosyayi matlab workspace'e oku
filePath = ['programlar\' fname];
% web'den cekilen dosyayi oku
fid = fopen(filePath,'r');
% ilk satir yarisin adi, yeri, tarihi
tline = 0;
% kosulari sira sira tara
satirNo = 0;
clear yaris
yaris.kosular = {};
while ~isequal(tline,-1)
    tline = fgetl(fid);
    satirNo = satirNo + 1;
    
    if satirNo == 1
        % baslik satiri
        ind = find(tline == ';');
        ind = [0 ind length(tline)+1];
        for i = 1:length(ind)-1
            yaris.bilgiler{i} = tline(ind(i)+1:ind(i+1)-1);
        end
        % tarih alanini duzelt
        yaris.bilgiler{3} = yaris.bilgiler{3}([7:10, 3:6, 1:2]);
        continue
    end
    
    if ~isempty(strfind(tline,'. Kosu'))
        kosu.bilgiler = [];
        % demek ki kosu basligi (mesela 1. Kosu 12:30;ÞARTLI 3/DHÖW/Diþi; 4 Yaþlý Araplar; 58.00kg; 1200m; Kum)
        ind = find(tline == ';');
        ind = [0 ind length(tline)+1];
        for i = 1:length(ind)-1
            kosu.bilgiler{i} = tline(ind(i)+1:ind(i+1)-1);
        end
        % kacinci kosu oldugunu cekmek
        ind = find(kosu.bilgiler{1}=='.',1,'first');
        currKosuNo = str2double(kosu.bilgiler{1}(1:ind-1));
        if (currKosuNo == 0)
            %0.koþu ise atla
            %                 currKosuNo = 13;
            disp([filePath ' icindeki 0. kosu atlaniyor']);
            break
        end
        yaris.kosular{currKosuNo}.bilgiler = kosu.bilgiler;
        % bir sonraki iki satiri da atla
        tline = fgetl(fid);
        tline = fgetl(fid);
        % simdi atlar bilgilerini oku
        tline = fgetl(fid);
        ind = find(tline == ';');
        ind = [0 ind length(tline)+1];
        for i = 1:length(ind)-1
            at{i} = tline(ind(i)+1:ind(i+1)-1);
        end
        yaris.kosular{currKosuNo}.alanIsimleri = at;
        % simdi bosluk gorene kadar at satirlarini oku
        while true
            tline = fgetl(fid);
            if isempty(tline) || isnan(str2double(tline(1)))
                % demek ki at satiri degilmis
                break
            end
            
            if ...
                    ~isempty(strfind(tline,'1. ÇÝFTE')) || ...
                    ~isempty(strfind(tline,'2. ÇÝFTE')) || ...
                    ~isempty(strfind(tline,'3. ÇÝFTE')) || ...
                    ~isempty(strfind(tline,'4. ÇÝFTE')) || ...
                    ~isempty(strfind(tline,'5. ÇÝFTE')) || ...
                    ~isempty(strfind(tline,'6. ÇÝFTE')) || ...
                    ~isempty(strfind(tline,'7. ÇÝFTE')) || ...
                    ~isempty(strfind(tline,'1.ALTILI GANYAN')) || ...
                    ~isempty(strfind(tline,'2.ALTILI GANYAN'))
                %1. ÇÝFTE, 2. ÇÝFTE ve 3. ÇÝFTE numara ile yazdýðý için
                break
            end
            clear at
            
            % ÇELÝK;; varsa ÇELÝK; ile degistir
            str = ';ALÝ ÇELÝK;;';
            ind = strfind(tline,str);
            if ~isempty(ind)
                disp(['ipne ali celik (' filePath ')'])
                tline(ind+length(str)-1) = [];
            end
            
            % MEHMET DOÐAN;; varsa MEHMET DOÐAN; ile degistir
            str = ';MEHMET DOÐAN;;';
            ind = strfind(tline,str);
            if ~isempty(ind)
                disp(['ipne mehmet dogan(' filePath ')'])
                tline(ind+length(str)-1) = [];
            end
            
            ind = find(tline == ';');
            ind = [0 ind length(tline) + 1];
            for i = 1:length(ind)-1
                at{i} = tline(ind(i)+1:ind(i+1)-1);
            end
            % at numarasi, ilk field icine yazili
            atNo = str2double(at{1});
            yaris.kosular{currKosuNo}.atlar(atNo,:) = at;
            
        end
        % devam
        continue
    end
end

% adim 3: lut'tan bakarak indeksleri don
global lut
if exist('lut','var')
    if isempty(lut)
        load('yarislarInd.mat')
    end
else
    if isempty(lut)
        load('yarislarInd.mat')
    end
end

% % yarisProgramInd icine yazilacak toplam olay sayisini hesapla ve buna gore
% % init yap.
% n = 0;
% for y = 1:length(yaris)
%     for k = 1:length(yaris(y).kosular)
%         try
%             % bazi bos yarislar icin try bloku yazildi.
%             n = n + size(yaris(y).kosular{k}.atlar,1);
%         end
%     end
% end
% 
% % m'yi hesapla
% m = 0;
% for i = 1:length(lut)
%     if isempty(lut{i}.altElemanlar)
%         m = m + 1;
%     else
%         m = m + length(lut{i}.altElemanlar);
%     end
% end
% yarisProgramInd = zeros(n,m);

% bu kodda, n ve m'yi hesaplayip yarisProgramInd matrisini zeros ile
% ilklemeye gerek yok, zira boyle bir hizlanmaya ihtiyac yok. bu nedenle
% anilan matris bos ilkleniyor.
yarisProgramInd = [];

% alan isimleri yapisini doldur
alanIsim.yaris = {'Sehir','YarisGunNo','Tarih'};
alanIsim.kosu = {'KosuNo','KosuCinsi','Grup','Agirlik','Mesafe','Pist'};
alanIsim.at = yaris.kosular{1}.alanIsimleri;

% alanIsim, atlarin altindaki son uc alani sil ( 'Son 6 Yarýþ' 'KGS' 's20')
alanIsim.at(11:13) = [];

% tum olaylari tara (olay: her bir atin bir kosusu)
i = 0;
for k = 1:length(yaris.kosular)
    if ~isempty(yaris.kosular{k})
        if isfield(yaris.kosular{k},'atlar')
            for a = 1:size(yaris.kosular{k}.atlar,1)
                %             try
                i = i + 1;
                bilgi.yaris = yaris.bilgiler;
                bilgi.kosu = yaris.kosular{k}.bilgiler;
                bilgi.at = yaris.kosular{k}.atlar(a,:);
                if ~isempty(strfind(bilgi.at{2},char([40 75 111  351  109  97 122 41])))
                    % demek ki kosmaz
                    i = i - 1;
                    disp([bilgi.at{2} ' isimli at kosmadigi icin atlaniyor.'])
                    continue
                end
                ind = olayIndCek(bilgi,alanIsim);
                %                 yarislarInd(i,1:length(ind)) = ind;
                yarisProgramInd(i,:) = [ind, 0, 0];
%                 disp(['yaris#', num2str(y), ' kosu#', num2str(k), ' at#' num2str(a) ' indekslendi'])
                %             catch
                %                 i = i - 1;
                %                 % neden bu bloka dustugunun aciklamasi eklenecek
                %                 error(' ');
                %             end
            end
        end
    end
end
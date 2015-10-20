files = dir('sonuclar\*.csv');
if isempty(files)
    error('sonuclar klasoru yaris bilgilerini icermiyor');
end
clear yarislar
for f = 1:length(files)
    disp([num2str(f) '\' num2str(length(files)) ':'  files(f).name]);
    % eger son dosya aciksa kapat
    try
        fclose(fid);
    end
    filePath = ['sonuclar\' files(f).name];
    % web'den cekilen dosyayi oku
    fid = fopen(filePath,'r');
    % ilk satir yarisin adi, yeri, tarihi
    tline = 0;
    % kosulari sira sira tara
    satirNo = 0;
    clear yaris
    yaris.kosular = {};
    while ~isequal(tline,-1)% && ~isempty(tline)
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
            % demek ki kosu basligi (mesela 1. Kosu 12:30;�ARTLI 3/DH�W/Di�i; 4 Ya�l� Araplar; 58.00kg; 1200m; Kum)
            ind = find(tline == ';');
            ind = [0 ind length(tline)+1];
            for i = 1:length(ind)-1
                kosu.bilgiler{i} = tline(ind(i)+1:ind(i+1)-1);
            end
            % kacinci kosu oldugunu cekmek
            ind = find(kosu.bilgiler{1}=='.',1,'first');
            currKosuNo = str2doublebasit(kosu.bilgiler{1}(1:ind-1));
            if (currKosuNo == 0)
                %0.ko�u ise atla
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
                        ~isempty(strfind(tline,'1. ��FTE')) || ...
                        ~isempty(strfind(tline,'2. ��FTE')) || ...
                        ~isempty(strfind(tline,'3. ��FTE')) || ...
                        ~isempty(strfind(tline,'4. ��FTE')) || ...
                        ~isempty(strfind(tline,'5. ��FTE')) || ...
                        ~isempty(strfind(tline,'6. ��FTE')) || ...
                        ~isempty(strfind(tline,'7. ��FTE')) || ...
                        ~isempty(strfind(tline,'1.ALTILI GANYAN')) || ...
                        ~isempty(strfind(tline,'2.ALTILI GANYAN')) || ...
                        ~isempty(strfind(tline,'6''LI GANYAN')) || ...
                        ~isempty(strfind(tline,'1. 3''L� GANYAN'))
                    %1. ��FTE, 2. ��FTE ve 3. ��FTE numara ile yazd��� i�in
                    break
                end
                clear at
                
                % �EL�K;; varsa �EL�K; ile degistir
                str = ';AL� �EL�K;;';
                ind = strfind(tline,str);
                if ~isempty(ind)
                    disp(['ipne ali celik (' filePath ')'])
                    tline(ind+length(str)-1) = [];
                end
                
                % MEHMET DO�AN;; varsa MEHMET DO�AN; ile degistir
                str = ';MEHMET DO�AN;;';
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
                atNo = str2doublebasit(at{1});
                yaris.kosular{currKosuNo}.atlar(atNo,:) = at;
                
            end
            % devam
            continue
        end
    end
    yarislar(f) = yaris;
end

% dogrula
for y = 1:length(yarislar)
    for k = 1:length(yarislar(y).kosular)
        if ~isfield(yarislar(y).kosular{k},'atlar')
            warning(['sorunlu yaris:' num2str(y) ' ' num2str(k)])
        end
    end
end

% kaydet
disp('dosya kaydediliyor...')
tic
save('yarislar.mat','yarislar')
disp(['yarislar.mat kaydedildi (' num2str(toc) ' saniye)'])
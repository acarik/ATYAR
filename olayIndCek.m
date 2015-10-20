function indSatir = olayIndCek(bilgi,alanIsim)
global lut
% m = 2; % bu boyle kalmayacak elbette
ustAlanIsimler = {'yaris','kosu','at'};
% satirIcindeSutunInd = 0;
% indSatir = zeros(1,m);
indSatir = [];
for uai = 1:length(ustAlanIsimler)
    ustAlanIsim = ustAlanIsimler{uai};
    currUstAlanIsimIcinAlanIsimleri = getfield(alanIsim,ustAlanIsim);
    currUstAlanIsimIcinBilgiler = getfield(bilgi,ustAlanIsim);
    if length(currUstAlanIsimIcinBilgiler) == 7
        % demek ki iki tane kilo alani varmis
        currUstAlanIsimIcinBilgiler(4) = [];
    elseif length(currUstAlanIsimIcinBilgiler) == 8
        currUstAlanIsimIcinBilgiler(4:5) = [];
    end
    for ai = 1:length(currUstAlanIsimIcinAlanIsimleri)
        currAlanIsim = currUstAlanIsimIcinAlanIsimleri{ai};
        if strcmp(currAlanIsim,'HÇ')
            currAlanIsim = 'HK';
        end
        currAlanBilgi = alanBilgiOnisle(currUstAlanIsimIcinBilgiler{ai},currAlanIsim);
        bulunduMu = false;
        % bu alan ismini lut icinde ara
        for lai = 1:length(lut)
            lutElemanAlanAdi = lut{lai}.alanAdi;
            if isequal(lutElemanAlanAdi,currAlanIsim)
                currLutEleman = lut{lai};
                [lutInd, currLutElemanGunc] = olayAlanIndCek(currLutEleman,currAlanBilgi);
                %                 [length(currLutEleman.altElemanlar), length(lutInd)]
                lut{lai} = currLutElemanGunc;
                bulunduMu = true;
                break
            end
        end
        if bulunduMu
            %             disp([ustAlanIsim '>' currAlanIsim ' icin tutulan deger: ' num2str(lutInd)])
            %             indSatir(satirIcindeSutunInd+1:satirIcindeSutunInd+length(lutInd)) = lutInd;
            indSatir = [indSatir, lutInd];
            %             satirIcindeSutunInd = satirIcindeSutunInd + length(lutInd);
        else
            % sikinti
            keyboard
        end
    end
end

function [lutInd, currLutEleman] = olayAlanIndCek(currLutEleman,currAlanBilgi)

% disp(['Alan Adi: ' currLutEleman.alanAdi]);
if isempty(currLutEleman.altElemanlar)
    % demek ki alanin icerigini parse etmeye gerek yok
    if currLutEleman.lutFlag % eger lut uygulanacaksa
        % tum lut'u tara ve "deger"lerde currAlanBilgi icin eslesme ara
        n = length(currLutEleman.deger);
        % aranan indeksi n+1 olarak baslat, ki for loop'un sonunda bu degerde
        % kalirsa lut genisletilsin
        t = strcmp(currLutEleman.deger,currAlanBilgi);
        if any(t)
            % demek ki eslesme var
            lutInd = find(t);
        else
            % demek ki yeni eklenecek.
            lutInd = n + 1;
            %             currLutEleman.indeks(lutInd) = lutInd;
            fprintf('lut''a yeni eleman ekleniyor: "%s" isimli "%s"\n',currAlanBilgi,currLutEleman.alanAdi);
            currLutEleman.deger{lutInd} = currAlanBilgi;
        end
    else
        % yoksa dogrudan degeri yaz gec. tatava yapma.
        lutInd = currAlanBilgi;
    end
else
    m = length(currLutEleman.altElemanlar);
    lutInd = zeros(1,m);
    % currLutEleman icindeki her bir alt eleman icin calistir (bir anlamda recursive)
    for i = 1:m
        [lutInd(i), currLutEleman.altElemanlar{i}] = ...
            olayAlanIndCek(currLutEleman.altElemanlar{i}, currAlanBilgi{i});
    end
end

function currUstAlanIsimIcinBilgi = alanBilgiOnisle(currUstAlanIsimIcinBilgi,currAlanIsim)
switch currAlanIsim
    case 'Sehir'
        currUstAlanIsimIcinBilgi(1) = [];
    case 'YarisGunNo'
        indAcParantez = find(currUstAlanIsimIcinBilgi=='(',1,'first');
        indNokta = find(currUstAlanIsimIcinBilgi=='.',1,'first');
        currUstAlanIsimIcinBilgi = str2double(currUstAlanIsimIcinBilgi(indAcParantez+1:indNokta-1));
    case 'Tarih'
        formatIn = 'yy/mm/dd';
        currUstAlanIsimIcinBilgi = datenum(currUstAlanIsimIcinBilgi,formatIn);
    case 'KosuNo'
        indNokta = find(currUstAlanIsimIcinBilgi=='.',1,'first');
        indSonBosluk = find(currUstAlanIsimIcinBilgi==' ',1,'last');
        f1 = str2double(currUstAlanIsimIcinBilgi(1:indNokta-1));
        try
            f2 = str2double(currUstAlanIsimIcinBilgi(indSonBosluk+[1, 2, 4, 5])); % ki ":" karakterini silelim
        catch
            % demek ki saat girilmemis. mesela {'Ankara'  '(31. Yarýþ
            % Günü)'  '2006/07/25'}, kosu 10
            f2 = 0;
        end
        currUstAlanIsimIcinBilgi = {f1 f2};
    case 'KosuCinsi'
        %         disp(currUstAlanIsimIcinBilgi)
        s = currUstAlanIsimIcinBilgi;
        clear currUstAlanIsimIcinBilgi;
        currUstAlanIsimIcinBilgi{2} = ~isempty(strfind(s,'Diþi'));
        currUstAlanIsimIcinBilgi{3} = ~isempty(strfind(s,'Y1'));
        currUstAlanIsimIcinBilgi{4} = ~isempty(strfind(s,'Y2'));
        currUstAlanIsimIcinBilgi{5} = ~isempty(strfind(s,'Y3'));
        ind = find(s=='/',1,'first');
        if isempty(ind)
            currUstAlanIsimIcinBilgi{1} = s;
        else
            if s(ind-1) == ' '
                currUstAlanIsimIcinBilgi{1} = s(1:ind-2);
            else
                currUstAlanIsimIcinBilgi{1} = s(1:ind-1);
            end
        end
        %         disp([currUstAlanIsimIcinBilgi{1}, '#T'])
    case 'Grup'
        s = currUstAlanIsimIcinBilgi;
        clear currUstAlanIsimIcinBilgi
        ind = find(s==' ',1,'last');
        currUstAlanIsimIcinBilgi{1} = s(2:ind-1);
        currUstAlanIsimIcinBilgi{2} = s(ind+1:end);
    case 'Agirlik'
        s = currUstAlanIsimIcinBilgi;
        clear currUstAlanIsimIcinBilgi
        ind1 = find(s=='k');
        ind2 = find(s=='g');
        s([ind1, ind2]) = [];
        d = str2num(s);
        %         if length(d) == 1
        %             currUstAlanIsimIcinBilgi{1} = d(1);
        %             currUstAlanIsimIcinBilgi{2} = 0;
        %         elseif length(d) == 2
        %             currUstAlanIsimIcinBilgi{1} = d(1);
        %             currUstAlanIsimIcinBilgi{2} = d(2);
        %         elseif isempty(d)
        %             currUstAlanIsimIcinBilgi{1} = -1;
        %             currUstAlanIsimIcinBilgi{2} = 0;
        %         else
        %             keyboard;
        %         end
        if isempty(d)
            currUstAlanIsimIcinBilgi = -1;
        else
            currUstAlanIsimIcinBilgi = d(1);
        end
    case 'Mesafe'
        ind = find(currUstAlanIsimIcinBilgi=='m');
        currUstAlanIsimIcinBilgi(ind) = [];
        currUstAlanIsimIcinBilgi = str2num(currUstAlanIsimIcinBilgi);
    case 'Pist'
        currUstAlanIsimIcinBilgi(1) = [];
    case 'At No'
        currUstAlanIsimIcinBilgi = str2num(currUstAlanIsimIcinBilgi);
    case 'At Ýsmi'
        s = currUstAlanIsimIcinBilgi;
        clear currUstAlanIsimIcinBilgi
        s(end+1) = ' ';
        indKG = strfind(s,' KG ');
        if isempty(indKG)
            currUstAlanIsimIcinBilgi{3} = 0;
        else
            currUstAlanIsimIcinBilgi{3} = 1;
            s(indKG:indKG+2) = [];
        end
        
        indSK = strfind(s,' SK ');
        if isempty(indSK)
            currUstAlanIsimIcinBilgi{4} = 0;
        else
            currUstAlanIsimIcinBilgi{4} = 1;
            s(indSK:indSK+2) = [];
        end
        
        indK = strfind(s,' K ');
        if isempty(indK)
            currUstAlanIsimIcinBilgi{5} = 0;
        else
            currUstAlanIsimIcinBilgi{5} = 1;
            s(indK:indK+1) = [];
        end
        
        indK = strfind(s,' SKG ');
        if isempty(indK)
            currUstAlanIsimIcinBilgi{6} = 0;
        else
            currUstAlanIsimIcinBilgi{6} = 1;
            s(indK:indK+3) = [];
        end
        
        indK = strfind(s,' DB ');
        if isempty(indK)
            currUstAlanIsimIcinBilgi{7} = 0;
        else
            currUstAlanIsimIcinBilgi{7} = 1;
            s(indK:indK+2) = [];
        end
        
        indK = strfind(s,' YP ');
        if isempty(indK)
%             currUstAlanIsimIcinBilgi{8} = 0;
        else
%             currUstAlanIsimIcinBilgi{8} = 1;
            s(indK:indK+2) = [];
        end
        
        indK = strfind(s,' SKG ');
        if isempty(indK)
        else
            s(indK:indK+3) = [];
        end
        
        indK = strfind(s,' GKR ');
        if isempty(indK)
        else
            s(indK:indK+3) = [];
        end
        
        indK = strfind(s,' MBH ');
        if isempty(indK)
        else
            s(indK:indK+3) = [];
        end
        
        indK = strfind(s,' ÖG ');
        if isempty(indK)
        else
            s(indK:indK+2) = [];
        end
        
        
        if numel(find(s=='('))
            % muhtemelen orijin geldi. sil.
            indAc = find(s=='(');
            indKapa = find(s==')');
            disp([s ' verisinden "' s(indAc:indKapa) '" siliniyor'])
        end
        
        % sondaki bosluklari temizle
        sil = [];
        for i = length(s):-1:1
            if s(i) == ' '
                sil(end+1) = i;
            else
                break
            end
        end
        s(sil) = [];
        indAc = find(s=='(');
        if isempty(indAc)
            currUstAlanIsimIcinBilgi{1} = s;
            currUstAlanIsimIcinBilgi{2} = 'TR';
        else
            indKapa = find(s==')');
            currUstAlanIsimIcinBilgi{1} = s(1:indAc-2);
            orijin = s(indAc+1:indKapa-1);
            if strcmp(orijin,'US')
                orijin = 'USA';
            end
            if strcmp(orijin,'RU')
                orijin = 'RUS';
            end
            currUstAlanIsimIcinBilgi{2} = orijin;
        end
        
        % artik orijin bilgisi kosan at icin tutulmadigi icin cikariliyor.
        currUstAlanIsimIcinBilgi(2) = [];
        
    case 'Yaþ'
        currUstAlanIsimIcinBilgi = strsplit(currUstAlanIsimIcinBilgi,' ');
        currUstAlanIsimIcinBilgi{1} = str2doublebasit(currUstAlanIsimIcinBilgi{1}(1:end-1));
        
    case {'Orijin(Baba)', 'Orijin(Anne)'};
        s = currUstAlanIsimIcinBilgi;
        clear currUstAlanIsimIcinBilgi
        indAc = find(s=='(');
        if isempty(indAc)
            currUstAlanIsimIcinBilgi{1} = s;
            currUstAlanIsimIcinBilgi{2} = 'TR';
        else
            indKapa = find(s==')');
            currUstAlanIsimIcinBilgi{1} = s(1:indAc-2);
            orijin = s(indAc+1:indKapa-1);
            if strcmp(orijin,'US')
                orijin = 'USA';
            end
            if strcmp(orijin,'RU')
                orijin = 'RUS';
            end
            currUstAlanIsimIcinBilgi{2} = orijin;
        end
        
    case 'Kilo'
        s = currUstAlanIsimIcinBilgi;
        clear currUstAlanIsimIcinBilgi
        ind = find(s == '+');
        if isempty(ind)
            %             currUstAlanIsimIcinBilgi{1} = str2double(s);
            currUstAlanIsimIcinBilgi = str2double(s);
            %             currUstAlanIsimIcinBilgi{2} = 0;
        else
            %             currUstAlanIsimIcinBilgi{1} = str2double(s(1:ind-1));
            currUstAlanIsimIcinBilgi = str2double(s(1:ind-1));
            %             currUstAlanIsimIcinBilgi{2} = str2double(s(ind+1:end));
        end
        
    case 'Fark'
        currUstAlanIsimIcinBilgi = 0; % siktir et farki
    case 'Jokey Adý'
        if length(currUstAlanIsimIcinBilgi) > 2
            if strcmp(currUstAlanIsimIcinBilgi(end-1:end),'AP')
                if strcmp(currUstAlanIsimIcinBilgi(end-2:end),' AP')
                    % apranti alanini sil
                    currUstAlanIsimIcinBilgi(end-2:end) = [];
                end
            end
        end
        
    case 'Sahip Adý'
        % hicbir sey yapmaya gerek yok. aynen don.
        
    case 'Antrenör Adý'
        if length(currUstAlanIsimIcinBilgi) > 2
            if strcmp(currUstAlanIsimIcinBilgi(1:3),'TS ')
                % bastaki 'TS' alanini sil. 
                currUstAlanIsimIcinBilgi(1:3) = [];
            end
        end
        
    case {'HK', 'HÇ'}
        currUstAlanIsimIcinBilgi = str2double(currUstAlanIsimIcinBilgi);
        if isnan(currUstAlanIsimIcinBilgi)
            % cunku kosmayan atlar icin HK bos geliyor
            currUstAlanIsimIcinBilgi = 0;
        end
    case 'Derece'
        if isempty(currUstAlanIsimIcinBilgi)
            currUstAlanIsimIcinBilgi = -1;
        else
            switch currUstAlanIsimIcinBilgi
                case {'Derecesiz','Koþmaz'}
                    currUstAlanIsimIcinBilgi = -1;
                otherwise
                    s = strsplit(currUstAlanIsimIcinBilgi,'.');
                    for i = 1:length(s)
                        % cunku eger kosmamissa 0..0 degeri geliyor
                        if isempty(s{i})
                            s{i} = '0';
                        end
                    end
                    currUstAlanIsimIcinBilgi = str2double(s{1})*60 + str2double(s{2}) + str2double(s{3})/100;
            end
        end
    case 'Ganyan'
        if isempty(currUstAlanIsimIcinBilgi)
            currUstAlanIsimIcinBilgi = 0;
        else
            s = strsplit(currUstAlanIsimIcinBilgi,',');
            currUstAlanIsimIcinBilgi = str2double([s{1}, '.', s{2}]);
        end
    otherwise
        keyboard
end

% nan gelen var mi diye kontrol et
% simdilik hizlandirmak icin bu kismi kapattim !!!
% cunku nan gelmiyor artik
% if iscell(currUstAlanIsimIcinBilgi)
%     for i = 1:length(currUstAlanIsimIcinBilgi)
%         for j = 1:length(currUstAlanIsimIcinBilgi{i})
%             if isnan(currUstAlanIsimIcinBilgi{i}(j))
%                 keyboard
%             end
%         end
%     end
% else
%     for i = 1:length(currUstAlanIsimIcinBilgi)
%         if isnan(currUstAlanIsimIcinBilgi(i))
%             keyboard
%         end
%     end
% end

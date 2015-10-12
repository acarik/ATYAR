function ind = olayIndSorgula(sorgu)
global lut yarislarInd

indMatrix = true(size(yarislarInd,1),length(sorgu));

% her bir sorgu alani icin
for i = 1:length(sorgu)
    currSorguAlanAdi = sorgu{i}.alanAdi;
    % ... lut icindeki alan adlarini tara
    ind = find(currSorguAlanAdi=='>');
    if isempty(ind)
        % demek ki ust alanla ilgili bir sorgu yapilmis
        currAlanAdi = currSorguAlanAdi;
        % once currAlanAdi'ni bulmak icin tum lut'u tara
        ind = lutAlanAdiAra(currAlanAdi);
        if ind == -1
            % bulunamadi
            error('alan adi bulunamadi! (%s)',currAlanAdi)
        end
        indAlt = [];
        sutunInd = yarislarIndSutunIndeksBul(ind,indAlt);
        % bulundu
        indMatrix(:,sutunInd) = mantiksalIndeksDegeriniDon(sorgu{i},ind,indAlt,sutunInd);
    else
        % demek ki alt alanla ilgili bir sorgu
        currAlanAdi = currSorguAlanAdi(1:ind-1);
        currAltAlanAdi = currSorguAlanAdi(ind+1:end);
        % once currAlanAdi'ni bulmak icin tum lut'u tara
        ind = lutAlanAdiAra(currAlanAdi);
        if ind == -1
            % bulunamadi
            error('alan adi bulunamadi! (%s)',currAlanAdi)
        end
        indAlt = -1;
        % simdi alt alan adi icin tara
        for j = 1:length(lut{ind}.altElemanlar)
            if strcmp(lut{ind}.altElemanlar{j}.alanAdi,currAltAlanAdi)
                indAlt = j;
                break
            end
        end
        if indAlt == -1
            % bulunamadi
            error('alt alan adi bulunamadi! (%s)',currAltAlanAdi)
        end
        sutunInd = yarislarIndSutunIndeksBul(ind,indAlt);
        % bulundu
        indMatrix(:,sutunInd) = mantiksalIndeksDegeriniDon(sorgu{i},ind,indAlt,sutunInd);
        
    end
end

ind = true(size(indMatrix,1),1);
for i = 1:size(indMatrix,2)
    ind = and(ind,indMatrix(:,i));
end

function sutun = mantiksalIndeksDegeriniDon(sorguDegeri,ind,indAlt,sutunInd)
global yarislarInd
% eger bos sorgu yapilmissa hepsini sec
if isempty(sorguDegeri.deger)
    sutun = true(size(yarislarInd,1),1);
    return
end

% yarislarInd icindeki degeri elde et (gercekDeger)
gercekDeger = gercekDegeriBul(sorguDegeri,ind,indAlt);

if length(gercekDeger) == 1
    % eger tek bir deger sorgulanmissa karsilastirma tipinin bir anlami yok
    sutun = yarislarInd(:,sutunInd) == gercekDeger;
else
    % yoksa karsilastirma tipinin anlami var
    switch sorguDegeri.karsilastirmaTipi
        case 'and'
            sutun = true(size(yarislarInd,1),1);
            for i = 1:length(gercekDeger)
                sutun = and(sutun,yarislarInd(:,sutunInd)==gercekDeger(i));
            end
        case 'or'
            sutun = false(size(yarislarInd,1),1);
            for i = 1:length(gercekDeger)
                sutun = or(sutun,yarislarInd(:,sutunInd)==gercekDeger(i));
            end
        case 'aralik'
            if length(gercekDeger) ~= 2
                error('aralik tipi sorguda yalnizca iki deger girilmeli')
            end
            sutun = and(...
                yarislarInd(:,sutunInd)>=gercekDeger(1),...
                yarislarInd(:,sutunInd)<=gercekDeger(2));
        otherwise
            keyboard
    end
end


function r = gercekDegeriBul(sorguDegeri,ind,indAlt)
global lut
r = zeros(1,length(sorguDegeri.deger));
if getLutFlag(ind,indAlt)
    % eger lut uygulanmissa
    % lut degerlerini tara ve indeksleri don
    if isempty(indAlt)
        % sadece ust indeks
        for i = 1:length(sorguDegeri.deger)
            currSorguDegeri = sorguDegeri.deger{i};
            bulundu = false;
            for j = 1:length(lut{ind}.deger)
                currLutDegeri = lut{ind}.deger{j};
                if isequal(currSorguDegeri,currLutDegeri)
                    bulundu = true;
                    r(i) = j;
                    break
                end
            end
            if ~bulundu
                error('sorgu degeri %s lut icinde bulunamadi',currSorguDegeri);
            end
        end
    else
        % ust ve alt indeks
        for i = 1:length(sorguDegeri.deger)
            currSorguDegeri = sorguDegeri.deger{i};
            bulundu = false;
            for j = 1:length(lut{ind}.altElemanlar{indAlt}.deger)
                currLutDegeri = lut{ind}.altElemanlar{indAlt}.deger{j};
                if isequal(currSorguDegeri,currLutDegeri)
                    bulundu = true;
                    r(i) = j;
                    break
                end
            end
            if ~bulundu
                error('sorgu degeri %s lut icinde bulunamadi',currSorguDegeri);
            end
        end
    end
    
else
    % uygulanmamissa
    if iscell(sorguDegeri.deger)
        for i = 1:length(sorguDegeri.deger)
            r(i) = sorguDegeri.deger{i};
        end
    else
        r = sorguDegeri.deger;
    end
end

function r = getLutFlag(ind,indAlt)
global lut
if isempty(indAlt)
    r = lut{ind}.lutFlag;
else
    r = lut{ind}.altElemanlar{indAlt}.lutFlag;
end

%         
%         if lut{ind}.altElemanlar{indAlt}.lutFlag
%             % o halde lut degerleri icinden indeksi cekecegiz
%             bulundu = false;
%             for j = 1:length(lut{ind}.altElemanlar{indAlt}.deger)
%                 if strcmp(lut{ind}.altElemanlar{indAlt}.deger{j},sorgu{i}.alanAdi)
%                     indMatrix(:,sutunInd) = mantiksalIndeksDegeriniDon(j,sutunInd);
%                     bulundu = true;
%                     break
%                 end
%             end
%             if ~bulundu
%                 error('sorgulanan %s degeri lut icinde bulunamadi',sorgu{i}.alanAdi
%         else
%             % o halde degerin kendisini alacagiz
%             indMatrix(:,sutunInd) = mantiksalIndeksDegeriniDon(lut{ind}.altElemanlar{indAlt}.deger{j},sutunInd);
%         end


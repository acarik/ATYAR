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


function r = getLutFlag(indUst,indAlt)
global lut
if isempty(indAlt)
    r = lut{indUst}.lutFlag;
else
    r = lut{indUst}.altElemanlar{indAlt}.lutFlag;
end

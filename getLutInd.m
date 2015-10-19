function [ind, ustInd, altInd] = getLutInd(alanAdi)
global lut
ind = find(alanAdi=='>');
if isempty(ind)
    ustInd = 0;
    altInd = [];
    ind = 0;
    for i = 1:length(lut)
        if isempty(lut{i}.altElemanlar)
            ind = ind + 1;
            if strcmp(alanAdi,lut{i}.alanAdi)
                ustInd = i;
                return
            end
        else
            for j = 1:length(lut{i}.altElemanlar)
                ind = ind + 1;
                if strcmp(alanAdi,lut{i}.altElemanlar{j}.alanAdi)
                    ustInd = i;
                    altInd = j;
                    return
                end
            end
        end
    end
    
    error('bulamadim');
else
    ustAlanAdi = alanAdi(1:ind-1);
    altAlanAdi = alanAdi(ind+1:end);
    ustInd = 0;
    altInd = [];
    ind = 0;
    for i = 1:length(lut)
        if isempty(lut{i}.altElemanlar)
            ind = ind + 1;
        else
            for j = 1:length(lut{i}.altElemanlar)
                ind = ind + 1;
                if strcmp(ustAlanAdi,lut{i}.alanAdi) && strcmp(altAlanAdi,lut{i}.altElemanlar{j}.alanAdi)
                    ustInd = i;
                    altInd = j;
                    return
                end
            end
        end
    end 
end
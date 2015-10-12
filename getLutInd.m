function [ind, ustInd, altInd] = getLutInd(alanAdi)
global lut
ustInd = 0;
altInd = 0;
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
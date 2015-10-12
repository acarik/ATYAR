function ind = lutAlanAdiAra(currAlanIsim)
global lut
ind = -1;
for lai = 1:length(lut)
    lutElemanAlanAdi = lut{lai}.alanAdi;
    if isequal(lutElemanAlanAdi,currAlanIsim)
        ind = lai;
        break
    end
end
function ind = lutSorgu(indx,degerlerOr)
global lut yarislarInd
yarislarIndSutNo = indx(1);
ustInd = indx(2);
altInd = indx(3);

orlanacakIndDegerleri = zeros(1,length(degerlerOr));
if altInd == 0
    for i = 1:length(degerlerOr)
        for j = 1:length(lut{ustInd}.deger)
            if strcmp(lut{ustInd}.deger{j},degerlerOr{i})
                orlanacakIndDegerleri(i) = j;
                break
            end
        end
    end
else
    keyboard
end


% simdi or'la
ind = false(size(yarislarInd,1),1);
for i = 1:length(orlanacakIndDegerleri)
    ind = or(ind,yarislarInd(:,yarislarIndSutNo));
end

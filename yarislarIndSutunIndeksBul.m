function sutunInd = yarislarIndSutunIndeksBul(ind,indAlt)
global lut
sutunInd = 0;
% for i = 1:length(lut)
%     sutunInd = sutunInd + 1;
%     if isempty(lut{i}.altElemanlar) == 0
%         if i == ind
%         end
%     else
%         for j = 1:length(lut{i}.altElemanlar)
%             
%     end
%     end

    
% disp('lut alan isimleri dokumu:')
for i = 1:length(lut)
%     disp([num2str(i) ': ' lut{i}.alanAdi]);
    if isempty(lut{i}.altElemanlar)
        sutunInd = sutunInd + 1;
        if i == ind
            return
        end
    end
    for j = 1:length(lut{i}.altElemanlar)
        sutunInd = sutunInd + 1;
        if i == ind && j == indAlt
            return
        end
    end
end

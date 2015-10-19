function lutAgacGoster()
% if isempty(lut)
%     load('yarislarInd.mat')
% end
global lut
lutIlkle()

disp('lut alan isimleri dokumu:')
ind = 0;
for i = 1:length(lut)
    if isempty(lut{i}.altElemanlar)
        ind = ind + 1;
        fprintf('lut indeks %d\t lutFlag: %d\t alan: %d %s\n',...
            ind, lut{i}.lutFlag, i, lut{i}.alanAdi);
    else
        for j = 1:length(lut{i}.altElemanlar)
            ind = ind + 1;
            fprintf('lut indeks %d\t lutFlag: %d\t alan: %d.%d %s>%s\n',...
                ind, lut{i}.altElemanlar{j}.lutFlag, i, j, lut{i}.alanAdi, lut{i}.altElemanlar{j}.alanAdi);
        end
    end
end

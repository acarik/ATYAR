function [oran] = neuralDisiErkekOrani(kosu)

indice = find(kosu(:,8) == 1);
oran = size(indice,1) / size(kosu,1);
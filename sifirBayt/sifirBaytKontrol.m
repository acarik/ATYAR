function ret = sifirBaytKontrol(fname)
% ret=1: bulundu
% ret=0: bulunmadi
global sifirBayt
if isempty(sifirBayt)
    load sifirBayt.mat
end

% ret = false;
% for i = 1:length(sifirBayt)
%     if strcmp(sifirBayt{i},fname)
%         ret = true;
%         break
%     end
% end

ret = any(strcmp(sifirBayt,fname));
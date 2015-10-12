function ret = nonnum_temizle_double_cevir(s)
% sil = [];
% for i = 1:length(str)
%     s = str(i);
%     t = str2double(s);
%     if isnan(t) || s == 'i'
%         sil(end+1) = i;
%     end
% end
% 
% str(sil) = [];
% ret = str2double(str);

n = length(s);
d = zeros(1,n);
for i = 1:n
    d(i) = str2double(s(i));
end

i = or(isnan(d),s=='i');
s(i) = [];
ret = str2double(s);
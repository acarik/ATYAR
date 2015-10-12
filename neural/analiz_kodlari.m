% clc
% N = find(kosuInd(:,1) == 33503);
% 
% datestr(kosuInd(N(1),4))
% kosuInd(N(1),1)
% [[(1:40)' neuralData(kosuInd(N(1),1),:)']]

% N = 33529;
% clc;
% a = find(neuralData(end-N:end,41)==1);
% a1 = size(a,1) / N
% b = find(neuralData(end-N:end,41)==2);
% b1 = size(b,1) / N
% c = find(neuralData(end-N:end,41)==3);
% c1 = size(c,1) / N
% 
% d = find(neuralData(end-N:end,41)==4);
% d1 = size(d,1) / N
% 
% e = find(neuralData(end-N:end,41)==5);
% e1 = size(e,1) / N
% 
% a1+b1+c1+d1+e1
% 

clc;

A = find (isnan(neuralData) == 1)


for i =1:43
    disp([num2str(i),'.kolon ', 'en yüksek deðer ',num2str(max(neuralData(:,i))),' en düþük deðer ' num2str(min(neuralData(:,i)))]);
end

% 
% clc
% [a b] = max(neuralData(:,9));
% 
% N = find(kosuInd(:,1) == b);
% aa = N(1);
% 
% 
% disp(['Koþu Id ' num2str(neuralData(b,1))]);
% disp(['Yarýþ Günü ' datestr(kosuInd(aa,4))]);
% disp(['Yarýþ Þehir: ' num2str(neuralDataLut{1,4}.deger{neuralData(b,5)})]);
% disp(['6lýnýn ', num2str(neuralData(b,8)),'. ayaðý']);
% disp(['Koþan At Sayýsý ', num2str(neuralData(b,13))]);
% 
% 
% [[(1:40)' neuralData(b,:)']]
% 
% 
% save('neuralData','neuralData','neuralDataLut');

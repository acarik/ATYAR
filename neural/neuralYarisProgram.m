%neural network verisi hazýrlama
GUNCELLE = 0; %yarislarInd verisi güncellendiyse burayý da güncelle

load('kosuInd.mat');
load('..\yarisProgramiInd.mat');

j = 0;

%kosuya gore yeni indice atama
kosuIndProgram = zeros(size(yarisProgramiInd,1),size(yarisProgramiInd,2)+1);
for i = 1 : size(yarisProgramiInd,1)
    if i == 1 || ( (yarisProgramiInd(i,4) - yarisProgramiInd(i-1,4)) ~=0 )
        j = j + 1;
    else
        j = j;
    end
    
    kosuIndProgram(i,:) = [j yarisProgramiInd(i,:)];
end
kosuIndProgram(1,1) = 1;

kosuSayisi = max(kosuIndProgram(:,1));
%43 veri olduðu kabul edildi
neuralDataProg = zeros(kosuSayisi,43);
% neural network 1. verisi  koþu indice'i
neuralDataProg(:,1) = (1 : kosuSayisi)';


for i = 1:kosuSayisi
    
    %ilgili koþýyý çek
    indice = find(kosuIndProgram(:,1) == i);
    kosu = kosuIndProgram(indice,:);
    
    %2.kolon yarýþ tipi ve diþi oluþtur
    neuralDataProg(i,2) = neuralYarisTipiOlustur(kosu);
    %3.kolon yaþ gurubu
    neuralDataProg(i,3) = kosu(1,12);
    %4.kolon arap ingiliz
    neuralDataProg(i,4) = kosu(1,13);
    %5.kolon þehir
    neuralDataProg(i,5) = kosu(1,2);
    %6.kolon pist
    neuralDataProg(i,6) = kosu(1,16);
    %7.kolon kaçýncý ay olduðu
    neuralDataProg(i,7) = neuralAyBul(kosu);
    %8.kolon 6'lýnýn kaçýncý ayaðý
    neuralDataProg(i,8) = neuralAyakBul(kosuIndProgram,indice);
    %9.kolon antrenör kazandýrma oraný varyansý
    neuralDataProg(i,9) = neuralAntrenorVaryans(kosu,kosuInd);
    %10.kolon disi erkek oraný
    neuralDataProg(i,10) = neuralDisiErkekOrani(kosu);
    %11.kolon kosan atlarýn yas varyansý
    neuralDataProg(i,11) = neuralYasVaryans(kosu);
    %12.kolon mesafe
    neuralDataProg(i,12) = kosu(1,15);
    %13.kolon yaristaki at sayýsý
    neuralDataProg(i,13) = size(kosu,1);
    %14.kolon-20.kolon  handikap parametreleri
    neuralDataProg(i,14:20) = neuralHandikap(kosu);
    %21.kolon-27.kolon  agirlik parametreleri    
    neuralDataProg(i,21:27) = neuralAgirlik(kosu);
    %28.kolon-36.kolon  jokey parametreleri    
    neuralDataProg(i,28:36) = neuralJokey(kosu,kosuInd);
    %37.42 kolon ganyan parametreleri
    neuralDataProg(i,37:42) = 0;  
    %tarihi 41.kolona yaz
    neuralDataProg(i,43) = kosu(1,4);

    
    disp(['#', num2str(i), '.kosu programý iþlendi'])
    
end

save('neuralDataProg.mat','neuralDataProg');



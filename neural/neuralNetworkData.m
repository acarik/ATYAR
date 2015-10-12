%neural network verisi hazýrlama
GUNCELLE = 0; %yarislarInd verisi güncellendiyse burayý da güncelle

if ~exist('kosuInd','var')
    %güncelleme
    if GUNCELLE
        load('..\yarislarInd.mat');        
        j = 1;
        kosuInd = zeros(size(yarislarInd,1), size(yarislarInd,2)+1);
        kosuInd(1,:) = [1 yarislarInd(1,:)];
        %kosuya gore yeni indice atama
        for i = 2 : size(yarislarInd,1)
            if( (yarislarInd(i,4) - yarislarInd(i-1,4)) ~=0 )
                j = j + 1;
            else
                j = j;
            end
            
            kosuInd(i,:) = [j yarislarInd(i,:)];
        end
        save('kosuInd.mat','kosuInd');
    else
        load('kosuInd.mat');
    end
    
end


neuralDataLutOlustur();
kosuSayisi = max(kosuInd(:,1));
%40 veri olduðu kabul edildi
neuralData = zeros(kosuSayisi,43);
% neural network 1. verisi  koþu indice'i
neuralData(:,1) = (1 : kosuSayisi)';


for i = 1:kosuSayisi
    
    %ilgili koþýyý çek
    indice = find(kosuInd(:,1) == i);
    kosu = kosuInd(indice,:);
    
    %2.kolon yarýþ tipi ve diþi oluþtur
    neuralData(i,2) = neuralYarisTipiOlustur(kosu);
    %3.kolon yaþ gurubu
    neuralData(i,3) = kosu(1,12);
    %4.kolon arap ingiliz
    neuralData(i,4) = kosu(1,13);
    %5.kolon þehir
    neuralData(i,5) = kosu(1,2);
    %6.kolon pist
    neuralData(i,6) = kosu(1,16);
    %7.kolon kaçýncý ay olduðu
    neuralData(i,7) = neuralAyBul(kosu);
    %8.kolon 6'lýnýn kaçýncý ayaðý
    neuralData(i,8) = neuralAyakBul(kosuInd,indice);
    %9.kolon antrenör kazandýrma oraný varyansý
    neuralData(i,9) = neuralAntrenorVaryans(kosu,kosuInd);
    %10.kolon antrenör kazandýrma oraný varyansý
    neuralData(i,10) = neuralDisiErkekOrani(kosu);
    %11.kolon kosan atlarýn yas varyansý
    neuralData(i,11) = neuralYasVaryans(kosu);
    %12.kolon mesafe
    neuralData(i,12) = kosu(1,15);
    %13.kolon yaristaki at sayýsý
    neuralData(i,13) = size(kosu,1);
    %14.kolon-20.kolon  handikap parametreleri
    neuralData(i,14:20) = neuralHandikap(kosu);
    %21.kolon-27.kolon  agirlik parametreleri    
    neuralData(i,21:27) = neuralAgirlik(kosu);
    %28.kolon-36.kolon  jokey parametreleri    
    neuralData(i,28:36) = neuralJokey(kosu,kosuInd);
    %37.42 kolon ganyan parametreleri
    neuralData(i,37:42) = neuralGanyan(kosu);  
    %tarihi 41.kolona yaz
    neuralData(i,43) = kosu(1,4);

    
    disp(['#', num2str(i), '.kosu iþlendi'])
    
end

save('neuralData.mat','neuralData','neuralDataLut');

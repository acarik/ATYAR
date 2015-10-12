%neural network verisi haz�rlama
GUNCELLE = 0; %yarislarInd verisi g�ncellendiyse buray� da g�ncelle

if ~exist('kosuInd','var')
    %g�ncelleme
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
%40 veri oldu�u kabul edildi
neuralData = zeros(kosuSayisi,43);
% neural network 1. verisi  ko�u indice'i
neuralData(:,1) = (1 : kosuSayisi)';


for i = 1:kosuSayisi
    
    %ilgili ko��y� �ek
    indice = find(kosuInd(:,1) == i);
    kosu = kosuInd(indice,:);
    
    %2.kolon yar�� tipi ve di�i olu�tur
    neuralData(i,2) = neuralYarisTipiOlustur(kosu);
    %3.kolon ya� gurubu
    neuralData(i,3) = kosu(1,12);
    %4.kolon arap ingiliz
    neuralData(i,4) = kosu(1,13);
    %5.kolon �ehir
    neuralData(i,5) = kosu(1,2);
    %6.kolon pist
    neuralData(i,6) = kosu(1,16);
    %7.kolon ka��nc� ay oldu�u
    neuralData(i,7) = neuralAyBul(kosu);
    %8.kolon 6'l�n�n ka��nc� aya��
    neuralData(i,8) = neuralAyakBul(kosuInd,indice);
    %9.kolon antren�r kazand�rma oran� varyans�
    neuralData(i,9) = neuralAntrenorVaryans(kosu,kosuInd);
    %10.kolon antren�r kazand�rma oran� varyans�
    neuralData(i,10) = neuralDisiErkekOrani(kosu);
    %11.kolon kosan atlar�n yas varyans�
    neuralData(i,11) = neuralYasVaryans(kosu);
    %12.kolon mesafe
    neuralData(i,12) = kosu(1,15);
    %13.kolon yaristaki at say�s�
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

    
    disp(['#', num2str(i), '.kosu i�lendi'])
    
end

save('neuralData.mat','neuralData','neuralDataLut');

%neural network verisi haz�rlama
GUNCELLE = 0; %yarislarInd verisi g�ncellendiyse buray� da g�ncelle

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
%43 veri oldu�u kabul edildi
neuralDataProg = zeros(kosuSayisi,43);
% neural network 1. verisi  ko�u indice'i
neuralDataProg(:,1) = (1 : kosuSayisi)';


for i = 1:kosuSayisi
    
    %ilgili ko��y� �ek
    indice = find(kosuIndProgram(:,1) == i);
    kosu = kosuIndProgram(indice,:);
    
    %2.kolon yar�� tipi ve di�i olu�tur
    neuralDataProg(i,2) = neuralYarisTipiOlustur(kosu);
    %3.kolon ya� gurubu
    neuralDataProg(i,3) = kosu(1,12);
    %4.kolon arap ingiliz
    neuralDataProg(i,4) = kosu(1,13);
    %5.kolon �ehir
    neuralDataProg(i,5) = kosu(1,2);
    %6.kolon pist
    neuralDataProg(i,6) = kosu(1,16);
    %7.kolon ka��nc� ay oldu�u
    neuralDataProg(i,7) = neuralAyBul(kosu);
    %8.kolon 6'l�n�n ka��nc� aya��
    neuralDataProg(i,8) = neuralAyakBul(kosuIndProgram,indice);
    %9.kolon antren�r kazand�rma oran� varyans�
    neuralDataProg(i,9) = neuralAntrenorVaryans(kosu,kosuInd);
    %10.kolon disi erkek oran�
    neuralDataProg(i,10) = neuralDisiErkekOrani(kosu);
    %11.kolon kosan atlar�n yas varyans�
    neuralDataProg(i,11) = neuralYasVaryans(kosu);
    %12.kolon mesafe
    neuralDataProg(i,12) = kosu(1,15);
    %13.kolon yaristaki at say�s�
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

    
    disp(['#', num2str(i), '.kosu program� i�lendi'])
    
end

save('neuralDataProg.mat','neuralDataProg');



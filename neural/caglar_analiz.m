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


analizDataLutOlustur();

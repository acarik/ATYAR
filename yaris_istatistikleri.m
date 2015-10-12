%% Haluk 18.03.2015
%%son 10 yýl koþu tipine baðlý istatistik deðerleri
if ~exist('yarislarInd','var')
    load('yarislarInd.mat');
end
   %hangi tarih aralýðýný ayarlayalým
%    t0 = '2010/01/01';
%    tend = '2015/01/01';
%    N = length(yarislar);
%    for i = 1 : N
%        flag1 = strcmp(yarislar(1,i).bilgiler{1,3}, t0);
%        flag2 = strcmp(yarislar(1,i).bilgiler{1,3}, tend);
%        
%        if flag1 == 1;
%            a = i;
%        end
%        if flag2 == 1;
%            b = i;
%        end    
%    end
%    
% end


%%
%yarislarInd matrisindeki her koþudaki ilk atý yazalým
kosu_birincileri_ind = [];
yaris_kosu_diff = [1 ;diff(yarislarInd(:,4))];
for i = 1:size(yarislarInd,1)
    if(yaris_kosu_diff(i) ~=0)
        kosu_birincileri_ind = [kosu_birincileri_ind ; i];
    end
end
birincilerInd = yarislarInd(kosu_birincileri_ind,:);






for i = 23:23%length(lut{1,5}.altElemanlar{1}.deger)
    disp(lut{1,5}.altElemanlar{1}.deger(i));
    indice1 = find((birincilerInd(:,6) == i) &(birincilerInd(:,7) == 0) );
    indice2 = find((birincilerInd(:,6) == i) &(birincilerInd(:,7) == 1) );    
    
    birinciKosuInd = birincilerInd(indice1,:);
    ganyanKosu = birinciKosuInd(:,37);
    figure;
    hist(ganyanKosu,40);
    N = size(ganyanKosu,1);
    title([ num2str(N) ' ' lut{1,5}.altElemanlar{1,1}.deger{i} ' Yarýþý için Histogram' ])
    axis([1,50,0 max(ganyanKosu)]);
    
    %diþi ganyan
    birinciKosuDisiInd = birincilerInd(indice2,:);
    ganyanKosuDisi = birinciKosuDisiInd(:,37);
    figure;
    hist(ganyanKosuDisi,40);
    N = size(ganyanKosuDisi,1);
    title([ num2str(N) ' ' lut{1,5}.altElemanlar{1,1}.deger{i} ' Diþi Yarýþý için Histogram' ])
    if (isempty(ganyanKosuDisi) )
        ganyanKosuDisi = 10;
    end
    axis([1,50,0 max(ganyanKosuDisi)]); 
end
  

% figure;
% plot(ganyanSartli3)


    
N = 87;

disp(lut{1,1}.deger{birinciKosuInd(N,1)})
disp(datedisp(birinciKosuInd(N,3)))
disp(datedisp(lut{1,5}.altElemanlar{1}.deger{birinciKosuInd(N,6)}))
disp(datedisp(lut{1,6}.altElemanlar{1}.deger{birinciKosuInd(N,11)}))
disp(datedisp(lut{1,11}.altElemanlar{1}.deger{birinciKosuInd(N,17)}))
disp(datedisp(lut{1,6}.altElemanlar{2}.deger{birinciKosuInd(N,12)}))
disp(birinciKosuInd(N,37))


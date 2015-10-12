function [agirlikDegisken] = neuralAgirlik(kosu)
agirlik = kosu(:,31);

indice = find(agirlik > 100);
agirlik(indice) = agirlik(indice)/10; 
n = size(kosu,1);

a = sort(agirlik,'descend');

agirlikDegisken(1,1) = max(agirlik);     
agirlikDegisken(1,2) = min(agirlik);     
agirlikDegisken(1,3) = mean(agirlik); 
agirlikDegisken(1,4) = (a(1) - a(2));
agirlikDegisken(1,7) = var(agirlik); 


%yarista 2 veya 3 at olması durumunda
switch n
    case 2
        agirlikDegisken(1,5) = 0;
    case 3
        agirlikDegisken(1,5) = 0;
        agirlikDegisken(1,6) = 0;
    otherwise
        agirlikDegisken(1,5) = (a(2) - a(3));
        agirlikDegisken(1,6) = (a(3) - a(4));
end


 

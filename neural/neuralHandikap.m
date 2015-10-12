function [handikapDegisken] = neuralHandikap(kosu)
handikap = kosu(:,35);

a = sort(kosu(:,35),'descend');
n = size(kosu,1);


handikapDegisken(1,1) = max(handikap);     
handikapDegisken(1,2) = min(handikap);     
handikapDegisken(1,3) = mean(handikap);
handikapDegisken(1,4) = (a(1) - a(2));
handikapDegisken(1,7) = var(handikap); 

%yarista 2 veya 3 at olması durumunda
switch n
    case 2
        handikapDegisken(1,5) = 0;
    case 3
        handikapDegisken(1,5) = 0;
        handikapDegisken(1,6) = 0;
    otherwise
        handikapDegisken(1,5) = (a(2) - a(3));
        handikapDegisken(1,6) = (a(3) - a(4));
end



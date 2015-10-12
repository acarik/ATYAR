function [ganyanDegisken] = neuralGanyan(kosu)
ganyan = kosu(:,37);

ganyanSifirsiz = ganyan;
n = find(ganyan == 0);
ganyanSifirsiz(n) = [];
if size(ganyanSifirsiz,1) == 0
    ganyanDegisken = zeros(1,6);
else
    ganyanDegisken(1,1) = ganyan(1);
    if(ganyan(1) == 0)
        if(ganyan(2) == 0)
            ganyanDegisken(1,1) = ganyan(3);
        else
            ganyanDegisken(1,1) = ganyan(2);
        end
    end
    ganyanDegisken(1,2) = min(ganyanSifirsiz);
    a = sort(ganyanSifirsiz,'ascend');
    if size(ganyanSifirsiz,1) > 2
        ganyanDegisken(1,3) =a(2);
    else
        ganyanDegisken(1,3) =0;
    end
    
    if size(ganyanSifirsiz,1) > 3
        ganyanDegisken(1,4) =a(3);
    else
        ganyanDegisken(1,4) =0;
    end  
    
    ganyanDegisken(1,5) = find(a == ganyanDegisken(1),1,'first');
    ganyanDegisken(1,6) =  ganyanDegisken(1,5) / length(ganyan);
    
    
    
    
end


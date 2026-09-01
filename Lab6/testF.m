function [residual] = testF(F, P1, P2)

    residual = zeros(1,size(P1 , 2)) ; 
  
    
    for i = 1: size(P1 , 2)

        residual(i) = abs(P2(:,i).' * F * P1(:,i)); 
        

    end
end
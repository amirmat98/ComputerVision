function [F] = EightPointsAlgorithmN(P1, P2)

    % Normalizing the points provided in homogeneous form 
    
    [nP1, T1] = normalise2dpts(P1) ; 
    
    [nP2, T2]= normalise2dpts(P2) ; 
    
    % Using the 8 points algorithm on the normalized points
    
    F_Norm = EightPointsAlgorithm(nP1, nP2) ; 
    
    % Denormalizing the calculated F 
    
    F = T2.' * F_Norm * T1 ; 
    
    end
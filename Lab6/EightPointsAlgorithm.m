function F = EightPointsAlgorithm(P1, P2)

    % Defining matrix A for any numbers of given corresponding points
    A = zeros(size(P1 , 2),9);
    
    for i = 1:size(P1,2)
    
    
        A(i,:) = [P2(1,i)*P1(:,i).' P2(2,i)*P1(:,i).' P2(3,i)*P1(:,i).'] ;
    
    end
    
    % disp(A);
    
    % Computing the SVD decomposition of Matrix A
    [U, D, V]=svd(A);
    
    % Choosing the last column of V as the solution 
    f_Sol = V(:,end) ;
    
    % reshaping to a 3*3 matrix to get a matrix F
    f_Reshaped = reshape(f_Sol , [3 3]).';
    
    % disp(sprintf('Rank of reshaped f is %d', rank(f_Reshaped)));
    
    %% Force the rank of F to be 2%% Force the rank of F to be 2
    
    % Computing the SVD decomposition of the reshaped F
    
    [U1 , D1, V1] = svd(f_Reshaped) ; 
    
    D1(3,3) = 0 ; 
    
    % Final form of F
    
    F = U1*D1*V1.' ; 
    
    % disp(sprintf('Rank of new f is %d', rank(F)));
    
    end 
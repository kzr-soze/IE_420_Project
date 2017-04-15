function [ price,S ] = ExerciseBoundary(Option,K,T,sigma,r,q,N,Exercise,ub,lb)
%ExerciseBoundary: searches for S*(T) using binomial search. stops when the
%region of interest is less than bound.
    
    bound = 5*10^-3;
    %disp(K);
    OpType = 1;
    if (Option=='C')
        OpType = -1;
    end
    
    go = true;
    count = 0;
    while (go)
        S = (ub+lb)/2;
        count = count+1;
       % disp([num2str(K)]);
        [price,ct] = Binomial(Option,K,T,S,sigma,r,q,N,Exercise);
        disp([S,price,ct]);
        %disp(OpType*(K-S));
        %disp(price == OpType*(K-S));
        %disp(OpType*(K-S)+ bound);
        %[exer,index] = ExerciseAt(Option,S,K,price);
        % disp(['Cycle: ',num2str(count),' Candidate Solution: ',num2str(S)]);

        if( ub-lb < bound/10)
            go = false;
        elseif ( OpType*(K-S)+bound >= price)
            if (OpType ==1) %Put
                lb = S;
                S = (ub+lb)/2;
            else
                ub = S;
                S = (ub+lb)/2;
            end
        elseif (OpType==1)
            ub = S;
            S = (ub+lb)/2;
        else
            lb = S;
            S = (ub+lb)/2;
        end
    end
    price = -OpType*(price - OpType*K);
    
end


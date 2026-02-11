function [s_KB] = KB_0527_1(yhat, R, N, S, K, SS, M)
    num_symbol = length(S); % numbers of symbol
    K_best = zeros(2*N, K); % initialized k's best path value
    %T_layer_2N = zeros(1, num_symbol); % initialized PEDs for upper layer
    T = zeros(2*N-1, K); % 2*N-1 PEDs for 2*N layers
    if (2*N == 8) &&  (M==256)
        K_layer= [1 4 4 8 8 8 8 8];
    elseif (2*N == 16) &&  (M==256)
        K_layer= [1 4 4 4 4 4 4 8 8 8 8 8 8 8 8 8];
    elseif (2*N == 8) 
        K_layer= [1 8 8 8 8 8 4 2];%K-best-Sorted-Rii-KB_0527_1
    else
        K_layer= [1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2];
    end
    for layer=2*N:-1:1 
        K1 = K_layer(layer);
     
        if layer == 2*N % upper layer
           [T_2N, indices] = sort(abs(yhat(layer) - R(layer,layer).* S)); %delete .^2
           T_layer_2N = T_2N(1:K1);
           K_best(layer,:) = [S(indices(1:K1)) zeros(1, K-K1)]; % set up  upper layer nodes    
        else
            if layer == 2*N-1 % for 2*N-1 and 2*N layer PEDs
                T_prev = T_layer_2N;
            else % for other two layers PEDs
                K2 = K_layer(layer+1);
                T_prev = T(layer + 1,1:K2);
            end
            [cands, Tcands] = deal(zeros(length(T_prev), 2)); % deal func generates zeros matrices for cands, Tcands
            num_paths = length(T_prev);
            for path=1:num_paths % calculate M*K PEDs
                interference = sum(R(layer,layer+1:2*N).' .* K_best(layer+1:2*N, path)); % ∑R(i, j)*s(j) from j = i+1 to 2*N
                Li = yhat(layer) - interference; % remove interference for y_hat in the layer
                [~, indices] = sort(abs(Li - R(layer,layer).* S)); % calculate all possible PEDs to one parent node %delete .^2
                Tcands(path, :) = T_prev(path) + abs(Li - R(layer,layer) .* S(indices(1:2))); % save PEDs by asscending order %delete .^2
                cands(path, :) = S(indices(1:2)); % save cands in asscending order
            end
            [Tbest, indices] = sort(reshape(Tcands', 1, [])); % reshape PED to row vector, and sort from low to high
            cands = reshape(cands', 1, []); % reshape candidates to row vector
            T(layer,:) = [Tbest(1:K1) zeros(1, K-K1)]; % assign PED from low to high
            K_best(layer, :) = [cands(indices(1:K1)) zeros(1, K-K1)]; % assign candidates with PED low to high
            path_indices = ceil(indices/num_symbol); % convert symbol indices to path indices
            K_best(layer+1:2*N, 1:K1) = K_best(layer+1:2*N, path_indices(1:K1) ); % update previous paths according to current PED
        end
    end
    K_best(SS,1) = K_best(1:2*N,1);
    s_KB = K_best(1:N,1) + 1j * K_best(N+1:2*N,1); % use first col of K_best(shortest path) be our solution
end
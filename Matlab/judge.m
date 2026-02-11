function s_hat = judge(y, Rii, M)

s_hat = zeros(1,1);

    if M == 16 %[-3 -1 1 3]
        
            if (abs(y)>= 2/10^(1/2) * Rii)
                s_hat = sign_func(y) * 3/10^(1/2);
            else
                s_hat = sign_func(y) * 1/10^(1/2);
            end
       
            
        
    end
    if M == 64 %[-7 -5 -3 -1 1 3 5 7]
        
            if (abs(y)>= 4/42^(1/2) * Rii)
                if (abs(y)>= 6/42^(1/2) * Rii)
                    s_hat = sign_func(y) * 7/42^(1/2);
                else
                    s_hat = sign_func(y) * 5/42^(1/2);
                end
            else
                if (abs(y)>= 2/42^(1/2) * Rii)
                    s_hat = sign_func(y) * 3/42^(1/2);
                else
                    s_hat = sign_func(y) * 1/42^(1/2);
                end
            end
        
            
        
    end
        
end    

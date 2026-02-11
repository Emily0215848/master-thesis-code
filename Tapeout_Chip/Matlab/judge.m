function s_hat = judge(s, M, Nt)

s_hat = zeros(Nt,1);
for kk = 1:Nt
    if M == 4 %[ -1 1 ]        
        if (s(kk)>0)
            s_hat(kk) = 1;
        else
            s_hat(kk) = -1;
        end                    
    end
    if M == 16 %[-3 -1 1 3]
        if (s(kk)>0)
            if (s(kk)>2)
                s_hat(kk) = 3;
            else
                s_hat(kk) = 1;
            end
        else
            if (s(kk)<-2)
                s_hat(kk) = -3;
            else
                s_hat(kk) = -1;
            end
        end
    end
    if M == 64 %[-7 -5 -3 -1 1 3 5 7]
        if (s(kk)>0)
            if (s(kk)>4)
                if (s(kk)>6)
                    s_hat(kk) = 7;
                else
                    s_hat(kk) = 5;
                end
            else
                if (s(kk)>2)
                    s_hat(kk) = 3;
                else
                    s_hat(kk) = 1;
                end
            end
        else
            if (s(kk)<-4)
                if (s(kk)<-6)
                    s_hat(kk) = -7;
                else
                    s_hat(kk) = -5;
                end
            else
                if (s(kk)<-2)
                    s_hat(kk) = -3;
                else
                    s_hat(kk) = -1;
                end
            end
        end
    end
        
end    
end
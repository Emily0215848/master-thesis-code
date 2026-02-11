function s_hat = Slicing(s, M, Nt)

s_hat = zeros(Nt,1);
for kk = 1:Nt
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
    %64
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
    %256
    if M == 256 %[-15, -13, -11, -9, -7, -5, -3, -1, 1, 3, 5, 7, 9, 11, 13, 15]
        if (s(kk)>0)
            if (s(kk)>8)
                if (s(kk)>12)
                    if (s(kk)>14)
                        s_hat(kk) = 15;
                    else
                        s_hat(kk) = 13;
                    end
                else
                    if (s(kk)>10)
                        s_hat(kk) = 11;
                    else
                        s_hat(kk) = 9;
                    end
                end
            else
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
            end
        else
            if (s(kk)<-8)
                if (s(kk)<-12)
                    if (s(kk)<14)
                        s_hat(kk) = -15;
                    else
                        s_hat(kk) = -13;
                    end
                else
                    if (s(kk)<10)
                        s_hat(kk) = -11;
                    else
                        s_hat(kk) = -9;
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
end
function [GG_two] = cordic_vectoring_new(micro_rr,times,kapa)
%micro_rr一定會是一個2xN的矩陣，實數
%回傳值會是
        for rotation=0:times
            if(micro_rr(1,1)<0)
                sign11=-1;
            else
                sign11=1;
            end
            if(micro_rr(2,1)<0)
                sign21=-1;
            else
                sign21=1;
            end
            sigma=-sign21*sign11;
            

            rot_matrix=[1,-sigma*(2^(-rotation));sigma*(2^(-rotation)),1];%課本P16第2式

            micro_rr=rot_matrix*micro_rr;
            
        end
        
        
GG_two=kapa*micro_rr;
end
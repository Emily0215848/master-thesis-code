function [GG_two] = cordic_vectoring_fixpoint(micro_rr,times,kapa,constant)
%micro_rr一定會是一個2xN的矩陣，實數
%micro_rr = [2 4;-1 3]; 
%times = 3;

%回傳值會是
        for rotation=0:times-1
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
            mi = micro_rr;
            if size(micro_rr,2) == 4 
                mi(1,1)=fix(rot_matrix(1,1) * micro_rr(1,1)) + fix(rot_matrix(1,2) * micro_rr(2,1));
                mi(1,2)=fix(rot_matrix(1,1) * micro_rr(1,2)) + fix(rot_matrix(1,2) * micro_rr(2,2));
                mi(1,3)=fix(rot_matrix(1,1) * micro_rr(1,3)) + fix(rot_matrix(1,2) * micro_rr(2,3));
                mi(1,4)=fix(rot_matrix(1,1) * micro_rr(1,4)) + fix(rot_matrix(1,2) * micro_rr(2,4));
                mi(2,1)=fix(rot_matrix(2,1) * micro_rr(1,1)) + fix(rot_matrix(2,2) * micro_rr(2,1));
                mi(2,2)=fix(rot_matrix(2,1) * micro_rr(1,2)) + fix(rot_matrix(2,2) * micro_rr(2,2));
                mi(2,3)=fix(rot_matrix(2,1) * micro_rr(1,3)) + fix(rot_matrix(2,2) * micro_rr(2,3));
                mi(2,4)=fix(rot_matrix(2,1) * micro_rr(1,4)) + fix(rot_matrix(2,2) * micro_rr(2,4));
            elseif size(micro_rr,2) == 3
                mi(1,1)=fix(rot_matrix(1,1) * micro_rr(1,1)) + fix(rot_matrix(1,2) * micro_rr(2,1));
                mi(1,2)=fix(rot_matrix(1,1) * micro_rr(1,2)) + fix(rot_matrix(1,2) * micro_rr(2,2));
                mi(1,3)=fix(rot_matrix(1,1) * micro_rr(1,3)) + fix(rot_matrix(1,2) * micro_rr(2,3));
                mi(2,1)=fix(rot_matrix(2,1) * micro_rr(1,1)) + fix(rot_matrix(2,2) * micro_rr(2,1));
                mi(2,2)=fix(rot_matrix(2,1) * micro_rr(1,2)) + fix(rot_matrix(2,2) * micro_rr(2,2));
                mi(2,3)=fix(rot_matrix(2,1) * micro_rr(1,3)) + fix(rot_matrix(2,2) * micro_rr(2,3));
            else
                mi(1,1)=fix(rot_matrix(1,1) * micro_rr(1,1)) + fix(rot_matrix(1,2) * micro_rr(2,1));
                mi(1,2)=fix(rot_matrix(1,1) * micro_rr(1,2)) + fix(rot_matrix(1,2) * micro_rr(2,2));
                mi(2,1)=fix(rot_matrix(2,1) * micro_rr(1,1)) + fix(rot_matrix(2,2) * micro_rr(2,1));
                mi(2,2)=fix(rot_matrix(2,1) * micro_rr(1,2)) + fix(rot_matrix(2,2) * micro_rr(2,2));
            end
            micro_rr = mi;
        end
        
%%(2^-1+2^-3) - 2^-6  = 0.609375
if size(micro_rr,2) == 4 
    micro_rr(1,1)=fix(micro_rr(1,1)/2) + fix(micro_rr(1,1)/2^3) - fix(micro_rr(1,1)/2^6);
    micro_rr(1,2)=fix(micro_rr(1,2)/2) + fix(micro_rr(1,2)/2^3) - fix(micro_rr(1,2)/2^6);
    micro_rr(1,3)=fix(micro_rr(1,3)/2) + fix(micro_rr(1,3)/2^3) - fix(micro_rr(1,3)/2^6);
    micro_rr(1,4)=fix(micro_rr(1,4)/2) + fix(micro_rr(1,4)/2^3) - fix(micro_rr(1,4)/2^6);
    micro_rr(2,1)=fix(micro_rr(2,1)/2) + fix(micro_rr(2,1)/2^3) - fix(micro_rr(2,1)/2^6);
    micro_rr(2,2)=fix(micro_rr(2,2)/2) + fix(micro_rr(2,2)/2^3) - fix(micro_rr(2,2)/2^6);
    micro_rr(2,3)=fix(micro_rr(2,3)/2) + fix(micro_rr(2,3)/2^3) - fix(micro_rr(2,3)/2^6);
    micro_rr(2,4)=fix(micro_rr(2,4)/2) + fix(micro_rr(2,4)/2^3) - fix(micro_rr(2,4)/2^6);
elseif size(micro_rr,2) == 3
    micro_rr(1,1)=fix(micro_rr(1,1)/2) + fix(micro_rr(1,1)/2^3) - fix(micro_rr(1,1)/2^6);
    micro_rr(1,2)=fix(micro_rr(1,2)/2) + fix(micro_rr(1,2)/2^3) - fix(micro_rr(1,2)/2^6);
    micro_rr(1,3)=fix(micro_rr(1,3)/2) + fix(micro_rr(1,3)/2^3) - fix(micro_rr(1,3)/2^6);
    micro_rr(2,1)=fix(micro_rr(2,1)/2) + fix(micro_rr(2,1)/2^3) - fix(micro_rr(2,1)/2^6);
    micro_rr(2,2)=fix(micro_rr(2,2)/2) + fix(micro_rr(2,2)/2^3) - fix(micro_rr(2,2)/2^6);
    micro_rr(2,3)=fix(micro_rr(2,3)/2) + fix(micro_rr(2,3)/2^3) - fix(micro_rr(2,3)/2^6);
else
    micro_rr(1,1)=fix(micro_rr(1,1)/2) + fix(micro_rr(1,1)/2^3) - fix(micro_rr(1,1)/2^6);
    micro_rr(1,2)=fix(micro_rr(1,2)/2) + fix(micro_rr(1,2)/2^3) - fix(micro_rr(1,2)/2^6);
    micro_rr(2,1)=fix(micro_rr(2,1)/2) + fix(micro_rr(2,1)/2^3) - fix(micro_rr(2,1)/2^6);
    micro_rr(2,2)=fix(micro_rr(2,2)/2) + fix(micro_rr(2,2)/2^3) - fix(micro_rr(2,2)/2^6);
end
GG_two=micro_rr;%fix(kapa*micro_rr/constant) fix(kapa*micro_rr)
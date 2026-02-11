 function [RR,SS] = cordic_QR_new(R_tilde,recursive_times,SS)
M = size(R_tilde,1);%幾個row，(MxN)
N = size(R_tilde,2);

%recursive_times =6;
%kapa = 0.60728;%%固定做六次的話
%kapa= 1/prod(sqrt(1+2.^(-2*(0:recursive_times-1))));

RR = zeros(M,N);
    for i=1:(N-1)
        %if (M==N-1) && (i==N-1)
        %    if (RR(i,i)<0)%如果A在左半平面
        %        RR(i,i:end)=  -RR(i,i:end);%可以確定轉的角度不會超過90度%不轉到右半平面，出來會變負數，因為cordic會將其轉到負x軸上
        %    end
        %    break;
        %end
        %%%%%%%%GR_based%%%%%%%%%%%%%%%%%%%%%
        for jj = 1 : (N-i+1)%norm max%N=8
            norm_HH(jj) = sum(abs(R_tilde((1:end),jj)));
        end
        [~,S] = min(norm_HH(1 : (N-i+1)));
        SS([i S+i-1]) = SS([S+i-1 i]); 
        R_tilde(:,[1 S]) = R_tilde(:,[S 1]); 
        RR(:,[i S+i-1]) = RR(:,[S+i-1 i]); 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [RR(i:M,i:N)] = cordic_block_new(R_tilde,recursive_times);
        R_tilde = RR((i+1):M,(i+1):N);
    end
    if (RR(M,M)<0)%如果A在左半平面
        RR(M,M)=  -RR(M,M);%可以確定轉的角度不會超過90度%不轉到右半平面，出來會變負數，因為cordic會將其轉到負x軸上
    end
end
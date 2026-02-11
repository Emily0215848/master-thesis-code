function [RR] = cordic_block_new(RR,recursive_times)
%功能是把R的[i+1:end,i]全部轉成零
M = size(RR,1);%幾個row，(MxN)
N = size(RR,2);

% recursive_times = 6;
% kapa = 0.60728;%%固定做六次的話
kapa= 1/prod(sqrt(1+2.^(-2*(0:recursive_times-1))));%(1+tan^2theta)^(-1/2)=costheta

    
                
    %--------------CGR

    %%把theta_a求出來--------------cord#1
    %if (real(RR(1,1))<0)%如果A在左半平面
    %        RR(1,:)=  -RR(1,:);%可以確定轉的角度不會超過90度%不轉到右半平面，出來會變負數，因為cordic會將其轉到負x軸上
    %end
    %micro_rr(1,:)=real(RR(1,:));
    %micro_rr(2,:)=imag(RR(1,:));
    %[upper_tri] = cordic_vectoring(micro_rr,recursive_times,kapa);%cord#1
    %
    %RR(1,:)=  upper_tri(1,:) + j*upper_tri(2,:);
    %RR(1,1)=  upper_tri(1,1);%令其不要有虛數
%
    %%轉theta_b--------------cord#2
    %if (real(RR(2,1))<0)%如果B在左半平面
    %        RR(2,:)=  -RR(2,:);
    %end
    %micro_rr(1,:)=real(RR(2,:));
    %micro_rr(2,:)=imag(RR(2,:));
    %[upper_tri] = cordic_vectoring(micro_rr,recursive_times,kapa);%cord#2
    %RR(2,:)=  upper_tri(1,:)+j*upper_tri(2,:);%因為第二個會被轉成0,所以沒差




    %%轉theta_ab(不用判斷_象限
    %if (RR(1,1)<0)%如果A在左半平面
    %        RR(1,:)=  -RR(1,:);%可以確定轉的角度不會超過90度%不轉到右半平面，出來會變負數，因為cordic會將其轉到負x軸上
    %end
    %%if (real(RR(2,1))<0)%如果B在左半平面
    %%        RR(2,:)=  -RR(2,:);
    %%end
    %micro_rr(1,:)=RR(1,:);
    %micro_rr(2,:)=RR(2,:);
    %[upper_tri1] = cordic_vectoring(micro_rr,recursive_times,kapa);%cord#3
    %micro_rr(1,:)=imag(RR(1,:));
    %micro_rr(2,:)=imag(RR(2,:));
    %micro_rr(1,1)=real(RR(1,1));
    %micro_rr(2,1)=real(RR(2,1));
    %[upper_tri2] = cordic_vectoring(micro_rr,recursive_times,kapa);%cord#4
    %RR(1,:)=  upper_tri1(1,:)+j*upper_tri2(1,:);%c'
    %RR(2,:)=  upper_tri1(2,:)+j*upper_tri2(2,:);%d'
    %RR(1,1)=  upper_tri1(1,1);%sqrt(a^+b^)
    %RR(2,1)=  upper_tri1(2,1);%0
    
    
    
    
    
    %==========R-cgr
    for column_element = 2:M
        
        %轉theta_ab(不用判斷\象限
        
        if (RR(1,1)<0)%如果A在左半平面
            RR(1,:)=  -RR(1,:);%可以確定轉的角度不會超過90度%不轉到右半平面，出來會變負數，因為cordic會將其轉到負x軸上
        end

        micro_rr(1,:)=RR(1,:);
        micro_rr(2,:)=RR(column_element,:);
        [upper_tri1] = cordic_vectoring_new(micro_rr,recursive_times,kapa);%cord#1
        
        RR(1,:)=  upper_tri1(1,:);
        RR(column_element,:)=  upper_tri1(2,:);%sqrt(a^+b^)
        RR(column_element,1)=  0;%0

    end
end
    
            
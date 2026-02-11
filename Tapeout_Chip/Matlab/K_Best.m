function K_Best(Num_cc,Num_ii,Nt, Nr, N, SNR_DB, SNR, symbol_set, symbol_pattern, EE, M, m, Constellation_Mapping_Table, L, K)
%6bit，前3，後3
power = 3;
total_ber = zeros(1,length(SNR));
constant = 2^power;
for cc = 1:Num_cc
    cc
    randn('seed',cc);  %change seed for AWGN
    rand('seed',cc);   %change seed for uniform
    ber = zeros(1,length(SNR));
    
    for ss = 1:length(SNR)
        for ii = 1:Num_ii
%%%%%%%%%%%%%%%%%%%%%%%%%沒做FIX POINT%%%%%%%%%%%%%
            bb = round(rand(1,L)); %% Information Bits
            s = zeros(Nt,1);
            
            for kk = 1 : Nt
                for jj = 1 : M
                    if(bb(:,1+(kk-1)*log2(M):kk*log2(M)) == Constellation_Mapping_Table(jj,1:log2(M)))
                        s(kk,1) = Constellation_Mapping_Table(jj,end);
                        break;
                    end
                end
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%
            H = 1/sqrt(2) .* (randn(N,N) + 1j*randn(N,N));
            HH = [real(H) -imag(H); imag(H) real(H)];
            n = sqrt(0.5/SNR(ss)) * ( randn(N,1) + 1j*randn(N,1) ); %AWGN%不用做Fix
            
%%%%%%%%%%%沒做FIX POINT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            s = s / sqrt(EE);
            y = H * s + n;
            yy = [real(y); imag(y)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            SS = [1 2 3 4];
            
            %%%%%QR_decomposition%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [arg_rr,SS] = cordic_QR_new(HH,6,SS);%2Nr*(2Nt+1)[yy_hat,R] = CORDIC_bin(yy, HH_k,6)
            RR_k   = arg_rr(1:2*Nt,1:2*Nt);%2Nt*2Nt
%%%%%%%%%%沒做FIX POINT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            yy_k   = arg_rr(1:2*Nt,end);%2Nt*1
         
            %[Q, RR_k] = qr(HH_k);
            %yy_k = Q' * yy_k;
            %%%%%%%%%%%%%%%%%%%%%%%%%Slicing%%%%%%%%%%%%%%%%%%%%%%%%%%
            S1 = symbol_pattern/sqrt(EE);
            s_1 = zeros(4,1);
            [~,index] = min(abs(yy_k(4) - RR_k(4,4) .* S1).^2);
            s_1(4) = S1(index);
            
            for layer=3:-1:1 % calculate M*K PEDs
                interference = sum(RR_k(layer,layer+1:2*N).' .* s_1(layer+1:2*N)); % ∑R(i, j)*s(j) from j = i+1 to 2*N
                Li = yy_k(layer) - interference; % remove interference for y_hat in the layer
                [~, index] = min(abs(Li - RR_k(layer,layer).* S1).^2); % calculate closest PED to one parent node
                s_1(layer) = S1(index);
            end
            s_1(SS) = s_1(1:2*N);
            s_hat = s_1(1:N) + 1j * s_1(N+1:2*N);
            
            %for kk = 1:2*Nt
            %    Sign_y = sign_func(yy_k(ss));
            %end
            s_hat= s_hat * sqrt(EE);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            s_hat = judge(real(s_hat),M,Nt) + 1j*judge(imag(s_hat),M,Nt); %sort by SS
           
            bb_hat =zeros(1,L); %% Information Bits
            for kk = 1 : Nt
                for jj = 1 : M
                    if(Constellation_Mapping_Table(jj,end) ==  s_hat(kk))
                        bb_hat(:,1+(kk-1)*log2(M):kk*log2(M)) = Constellation_Mapping_Table(jj,1:log2(M));
                        break;
                    end
                end
            end

            ber(1,ss) = ber(1,ss) + sum(bb_hat ~= bb);
%%%%%%%%%%%%%%%%%%%    
        end %for ii = 1:100
    end  %for ss = 1:length(SNR)
    
    total_ber = total_ber + ber;
end  %for cc = 1:Num

total_ber_average = total_ber/Num_cc/Num_ii/L;
figure,
semilogy(SNR_DB, total_ber_average, 'b-*');
xlabel('SNR');
ylabel('Average BER');
%title(M + "\_QAM");
hold on;
grid;
%%%%%
method = 2;
if method == 1
    str_detector = 'Sorted';
elseif method == 2
    str_detector = 'Unsorted';
end
axis([min(SNR_DB) max(SNR_DB) 0.00001 1]);
str2 = strcat('K-best Nt-',num2str(Nt),' Nr-',num2str(Nr));
legend(str2);
hold on;
eval (['save ' str_detector '_Nt=' num2str(Nt) '_Nr=' num2str(Nr) '_' num2str(M) 'QAM' '_Num_cc=' num2str(Num_cc) '_Num_ii=' num2str(Num_ii) '.mat  total_ber_average SNR_DB']);
end